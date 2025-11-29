-- breeding-fish.lua
local is_debug_active = script.active_mods["debugadapter"] ~= nil

local breeding_cycle = settings.startup["breeding-cycle"].value
---@cast breeding_cycle integer
local breeding_limit = settings.startup["breeding-limit"].value
local breeding_space_ratio = 1024 / breeding_limit

-- Scaling parameters; adjust divisor for desired growth rate (lower = faster)
local chunks_scale_divisor = 1500
local max_chunks_per_surface_per_tick = 32 -- Per-surface cap for every-tick processing
local global_max_chunks_per_tick = 128 -- Global cap (prevents multi-planet overload) -- Remove this, we have 5 planets we can be samrt with per tick value

-- Track generated chunks per surface
storage.generated_chunks = storage.generated_chunks or {}

local supported_planets = {
    ["nauvis"] = true, -- Native: fish
    ["gleba"] = true, -- Player has to import fish
    ["pelagos"] = true, -- Native: fish
    ["lignumis"] = true, -- Native: fish
    ["rabbasca"] = true, -- Native: turbo-fish
}

-- Calculating helpers
local function get_chunk_area(chunk_pos)
    local left_top = { x = chunk_pos.x * 32, y = chunk_pos.y * 32 }
    return { left_top, { x = left_top.x + 32, y = left_top.y + 32 } }
end

local function calculate_breeding_probability(fish_count, max_viable)
    if fish_count < 2 or fish_count >= max_viable then
        return 0
    end

    local mu = max_viable / 2
    if mu <= 2 then
        return 0
    end

    if fish_count <= mu then
        return 0.2 + 0.7 * (fish_count - 2) / (mu - 2)
    else
        return 0.9 * (max_viable - fish_count) / (max_viable - mu)
    end
end

local function breed_in_chunk(surface, chunk_pos)
    local area = get_chunk_area(chunk_pos) -- Compute once

    local fish = surface.find_entities_filtered { area = area, type = "fish" }
    local fish_count = #fish
    if fish_count < 2 or fish_count > breeding_limit then
        return
    end

    local water_filter = { collision_mask = { "water_tile" }, collision_mask_mode = "contains" }
    local water_count = surface.count_tiles_filtered { area = area, collision_mask = water_filter.collision_mask, collision_mask_mode = water_filter.collision_mask_mode }

    if water_count == 0 then
        return
    end

    local max_viable = math.floor(water_count / breeding_space_ratio)
    if fish_count >= max_viable then
        return
    end

    local prob = calculate_breeding_probability(fish_count, max_viable)
    if math.random() < prob then
        -- Fixed high tries: expected ~0.5 * water_count water hits → matches original spawn rate
        local max_tries = 512
        local left_top = area[1]
        local fish_name = fish[1].name

        for _ = 1, max_tries do
            -- Random pos in chunk
            local pos = {
                x = left_top.x + math.random() * 31.999, -- Sub-32 for edge safety
                y = left_top.y + math.random() * 31.999
            }
            local tile = surface.get_tile(pos)
            if tile and tile.collides_with("water_tile") then
                if surface.can_place_entity { name = fish_name, position = pos } then
                    local entity = surface.create_entity { name = fish_name, position = pos }
                    if entity then
                        if is_debug_active then
                            game.print(string.format("Fish just spawned on %s at (%.1f, %.1f): %s", surface.planet.name,
                                pos.x, pos.y, entity.name))
                        end
                        return
                    end
                end
            end
        end
    end
end

local function on_breeding_tick(event)
    local total_chunks_this_tick = 0
    for planet_name in pairs(supported_planets) do
        local surface = game.surfaces[planet_name]
        if surface then
            local total_chunks = storage.generated_chunks[surface.index] or 1
            local num_chunks = math.max(1, math.min(max_chunks_per_surface_per_tick, math.ceil(total_chunks / (chunks_scale_divisor))))
            num_chunks = math.min(num_chunks, global_max_chunks_per_tick - total_chunks_this_tick)

            for i = 1, num_chunks do
                local chunk = surface.get_random_chunk()
                if chunk then
                    breed_in_chunk(surface, chunk)
                end
            end
            total_chunks_this_tick = total_chunks_this_tick + num_chunks
            if total_chunks_this_tick >= global_max_chunks_per_tick then
                break
            end
        end
    end
end

-- Storage handling
local function on_chunk_generated(event)
    local surface = event.surface
    if surface.planet and supported_planets[surface.planet.name] then
        local surface_id = surface.index
        storage.generated_chunks[surface_id] = (storage.generated_chunks[surface_id] or 0) + 1
    end
end

local function initialize_generated_chunks()
    for planet_name in pairs(supported_planets) do
        local surface = game.surfaces[planet_name]
        if surface then
            local surface_id = surface.index
            if not storage.generated_chunks[surface_id] then
                storage.generated_chunks[surface_id] = 1
            end
        end
    end
end

script.on_init(function()
    storage.generated_chunks = {}
    initialize_generated_chunks()
end)

script.on_configuration_changed(function(data)
    if data.mod_changes["natural-fish-dynamics"] then
        storage.generated_chunks = storage.generated_chunks or {}
        initialize_generated_chunks()
    end
end)

-- Main functions: Now every tick for steady perf + smooth spawns
script.on_event(defines.events.on_chunk_generated, on_chunk_generated)
script.on_nth_tick(breeding_cycle, on_breeding_tick)