-- Map descriptive strings to tick values (hidden from UI; multipliers relative to 60-tick standard)
local cycle_mapping = {
    ["fast-(x2)"] = 30,      -- 2x frequency
    ["normal"] = 60,        -- 1x (baseline)
    ["slow-(/2)"] = 120,     -- 0.5x frequency
    ["very-slow-(/5)"] = 300, -- 0.2x frequency
    ["ultra-slow-(/10)"] = 600 -- 0.1x frequency
}
local breeding_cycle = cycle_mapping[settings.startup["breeding-cycle"].value] or 60  -- Default to normal
---@cast breeding_cycle integer
local breeding_limit = settings.startup["breeding-limit"].value
local breeding_space_ratio = 1024 / breeding_limit

-- Scaling parameters; adjust divisor for desired growth rate (lower = faster)
local chunks_scale_divisor = 1500
local max_chunks_per_surface_per_tick = 32 -- Per-surface cap for every-tick processing

local max_nth = breeding_cycle  -- Max interval for small maps
local min_nth = math.ceil(breeding_cycle / max_chunks_per_surface_per_tick)  -- ~2; min interval to cap max load at original ~32 chunks/sec

-- Track generated chunks per surface
storage.generated_chunks = storage.generated_chunks or {}

local FishUtils = require("scripts.fish-utils")

local function on_tick_handler(event)
    local tick = event.tick
    for planet_name in pairs(FishUtils.supported_planets) do
        local surface = game.surfaces[planet_name]
        if surface then
            local surface_id = surface.index
            local total_chunks = storage.generated_chunks[surface_id] or 1
            local raw_nth = breeding_cycle * chunks_scale_divisor / total_chunks
            local nth = math.max(min_nth, math.min(max_nth, math.floor(raw_nth + 0.5)))
            if tick % nth == 0 then
                local chunk = surface.get_random_chunk()
                if chunk then
                    FishUtils.breed_in_chunk(surface, chunk, breeding_limit, breeding_space_ratio)
                end
            end
        end
    end
end

script.on_init(function()
    storage.generated_chunks = {}
    FishUtils.initialize_generated_chunks()
end)

script.on_configuration_changed(function(data)
    if data.mod_changes["natural-fish-dynamics"] then
        storage.generated_chunks = storage.generated_chunks or {}
        FishUtils.initialize_generated_chunks()
    end
end)

script.on_event(defines.events.on_chunk_generated, FishUtils.on_chunk_generated)
script.on_event(defines.events.on_tick, on_tick_handler)