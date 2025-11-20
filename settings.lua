-- settings.lua
data:extend({
    {
        type = "int-setting",
        name = "breeding-limit",
        setting_type = "startup",
        default_value = 256,
        minimum_value = 16,
        maximum_value = 512,
        order = "a",
        localised_description = {"", "Max fish in a chunk full of water."}
    },
    {
        type = "int-setting",
        name = "breeding-cycle",
        setting_type = "startup",
        default_value = 60,
        minimum_value = 30,
        maximum_value = 600,
        order = "b",
        localised_description = {"", "In ticks, Script will run every Nth tick only."}
    }
})