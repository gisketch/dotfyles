return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        notify = {
            enabled = false
        },
        lsp = {
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
        },
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
    }
}
