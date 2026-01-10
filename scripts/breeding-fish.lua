-- breeding-fish.lua
-- Map descriptive strings to tick values (hidden from UI; multipliers relative to 60-tick standard)
local cycle_mapping = {
    ["fast-(x2)"] = 30,      -- 2x frequency
    ["normal"] = 60,        -- 1x (baseline)
    ["slow-(/2)"] = 120,     -- 0.5x frequency
    ["very-slow-(/5)"] = 300, -- 0.2x frequency
    ["ultra-slow-(/10)"] = 600 -- 0.1x frequency
}

-- Scaling parameters; adjust divisor for desired growth rate (lower = faster)
local chunks_scale_divisor = 1500
local max_chunks_per_surface_per_tick = 32 -- Per-surface cap for every-tick processing

-- Track generated chunks per surface
storage.generated_chunks = storage.generated_chunks or {}

local FishUtils = require("scripts.fish-utils")

local function on_tick_handler(event)
    local tick = event.tick

    -- Current runtime settings (changeable in-game)
    local current_cycle = cycle_mapping[settings.global["breeding-cycle"].value] or 60
    local current_limit = settings.global["breeding-limit"].value
    local current_space_ratio = 1024 / current_limit

    for planet_name in pairs(FishUtils.supported_planets) do
        local surface = game.surfaces[planet_name]
        if surface then
            local surface_id = surface.index
            local total_chunks = storage.generated_chunks[surface_id] or 1

            local raw_nth = current_cycle * chunks_scale_divisor / total_chunks
            local min_nth = math.ceil(current_cycle / max_chunks_per_surface_per_tick)
            local nth = math.max(min_nth, math.min(current_cycle, math.floor(raw_nth + 0.5)))

            if tick % nth == 0 then
                local chunk = surface.get_random_chunk()
                if chunk then
                    FishUtils.breed_in_chunk(surface, chunk, current_limit, current_space_ratio)
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