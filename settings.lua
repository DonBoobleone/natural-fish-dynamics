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