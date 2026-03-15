-- Map descriptive strings to tick values (hidden from UI; multipliers relative to 60-tick standard)
local cycle_mapping =
{
    ["ultra-fast-(x10)"] = 6,
    ["very-fast-(x5)"] = 12,
    ["fast-(x2)"] = 30,
    ["normal"] = 60,
    ["slow-(/2)"] = 120,
    ["very-slow-(/5)"] = 300,
    ["ultra-slow-(/10)"] = 600
}

local FishUtils = require("scripts.fish-utils")

local function on_tick_handler(event)
    local tick = event.tick

    -- Current runtime settings (changeable in-game)
    local current_cycle = cycle_mapping[settings.global["breeding-cycle"].value] or 60
    local current_limit = settings.global["breeding-limit"].value
    local current_space_ratio = 1024 / current_limit
    local current_scale = settings.global["breeding-chunk-scale-divisor"].value
    local current_max_chunks = settings.global["breeding-max-chunks-per-tick"].value
    local current_litter_size = settings.global["fish-litter-size"].value

    for planet_name in pairs(FishUtils.supported_planets) do
        -- Skip if breeding is disabled for this planet
        if settings.global["breeding-enable-" .. planet_name].value then
            local surface = game.surfaces[planet_name]
            if surface then
                local surface_id = surface.index
                local total_chunks = storage.generated_chunks[surface_id] or 1

                local raw_nth = current_cycle * current_scale / total_chunks
                local min_nth = math.ceil(current_cycle / current_max_chunks)
                local nth = math.max(min_nth, math.min(current_cycle, math.floor(raw_nth + 0.5)))

                if tick % nth == 0 then
                    local chunk = surface.get_random_chunk()
                    if chunk then
                        FishUtils.breed_in_chunk(surface, chunk, current_limit, current_space_ratio, current_litter_size)
                    end
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