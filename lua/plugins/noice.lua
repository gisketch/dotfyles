return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        notify = {
            enabled = false
        },
        lsp = {
            enabled = false,
            progress = {
                enabled = false
            }
        },
        views = {
            cmdline_popup = {
                border = {
                    style = "none",
                    padding = { 1, 3 },
                },
                filter_options = {},
                win_options = {
                    winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                },
            },
            cmdline = {
                border = {
                    style = "none",
                    padding = { 1, 3 },
                },
            },
        },
        presets = {
            bottom_search = false,
            command_palette = false,
            long_message_to_split = false,
            inc_rename = false,
            lsp_doc_border = false,
        },
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
    }
}
