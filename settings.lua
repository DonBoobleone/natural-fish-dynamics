-- settings.lua
data:extend({
    {
        type = "int-setting",
        name = "breeding-limit",
        setting_type = "runtime-global",
        default_value = 256,
        minimum_value = 16,
        maximum_value = 512,
        order = "a",
        localised_name = {"mod-setting-name.breeding-limit"},
        localised_description = {"mod-setting-description.breeding-limit"}
    },
    {
        type = "string-setting",
        name = "breeding-cycle",
        setting_type = "runtime-global",
        default_value = "normal",
        allowed_values = {"fast-(x2)", "normal", "slow-(/2)", "very-slow-(/5)", "ultra-slow-(/10)"},
        order = "b",
        localised_name = {"mod-setting-name.breeding-cycle"},
        localised_description = {"mod-setting-description.breeding-cycle"}
    }
})