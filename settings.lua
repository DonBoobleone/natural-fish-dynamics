-- settings.lua
data:extend({
    {
        type = "int-setting",
        name = "breeding-limit",
        setting_type = "runtime-global",
        default_value = 128,
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
        allowed_values = {"ultra-fast-(x10)", "very-fast-(x5)", "fast-(x2)", "normal", "slow-(/2)", "very-slow-(/5)", "ultra-slow-(/10)"},
        order = "b",
        localised_name = {"mod-setting-name.breeding-cycle"},
        localised_description = {"mod-setting-description.breeding-cycle"}
    },
    {
        type = "int-setting",
        name = "breeding-chunk-scale-divisor",
        setting_type = "runtime-global",
        default_value = 1200,
        minimum_value = 300,
        maximum_value = 3600,
        order = "b-a",
        localised_name = {"mod-setting-name.breeding-chunk-scale-divisor"},
        localised_description = {"mod-setting-description.breeding-chunk-scale-divisor"}
    },
    {
        type = "int-setting",
        name = "breeding-max-chunks-per-tick",
        setting_type = "runtime-global",
        default_value = 32,
        minimum_value = 8,
        maximum_value = 128,
        order = "b-b",
        localised_name = {"mod-setting-name.breeding-max-chunks-per-tick"},
        localised_description = {"mod-setting-description.breeding-max-chunks-per-tick"}
    },
    {
        type = "int-setting",
        name = "fish-litter-size",
        setting_type = "runtime-global",
        default_value = 1,
        minimum_value = 1,
        maximum_value = 16,
        order = "b-c",
        localised_name = {"mod-setting-name.fish-litter-size"},
        localised_description = {"mod-setting-description.fish-litter-size"}
    },

    -- Per-planet enable/disable settings (default true)
    {
        type = "bool-setting",
        name = "breeding-enable-nauvis",
        setting_type = "runtime-global",
        default_value = true,
        order = "c-a",
        localised_name = {"mod-setting-name.breeding-enable-nauvis"},
        localised_description = {"mod-setting-description.breeding-enable-nauvis"}
    },
    {
        type = "bool-setting",
        name = "breeding-enable-gleba",
        setting_type = "runtime-global",
        default_value = true,
        order = "c-b",
        localised_name = {"mod-setting-name.breeding-enable-gleba"},
        localised_description = {"mod-setting-description.breeding-enable-gleba"}
    },
    {
        type = "bool-setting",
        name = "breeding-enable-aquilo",
        setting_type = "runtime-global",
        default_value = true,
        order = "c-c",
        localised_name = {"mod-setting-name.breeding-enable-aquilo"},
        localised_description = {"mod-setting-description.breeding-enable-aquilo"}
    },
    {
        type = "bool-setting",
        name = "breeding-enable-pelagos",
        setting_type = "runtime-global",
        default_value = true,
        order = "c-d",
        localised_name = {"mod-setting-name.breeding-enable-pelagos"},
        localised_description = {"mod-setting-description.breeding-enable-pelagos"}
    },
    {
        type = "bool-setting",
        name = "breeding-enable-lignumis",
        setting_type = "runtime-global",
        default_value = true,
        order = "c-e",
        localised_name = {"mod-setting-name.breeding-enable-lignumis"},
        localised_description = {"mod-setting-description.breeding-enable-lignumis"}
    },
    {
        type = "bool-setting",
        name = "breeding-enable-rabbasca",
        setting_type = "runtime-global",
        default_value = true,
        order = "c-f",
        localised_name = {"mod-setting-name.breeding-enable-rabbasca"},
        localised_description = {"mod-setting-description.breeding-enable-rabbasca"}
    }
})