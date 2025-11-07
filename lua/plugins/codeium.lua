return {
    "Exafunction/windsurf.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("codeium").setup({
            enable_cmp_source = false,
            virtual_text = {
                enabled = true,
                filetypes = {},
                default_filetype_enabled = true,
                -- How long to wait (in ms) before requesting completions after typing stops.
                idle_delay = 15,
                map_keys = true,
                accept_fallback = nil,
                key_bindings = {
                    accept = "<C-a>",
                    accept_word = false,
                    accept_line = false,
                    clear = false,
                    next = "<M-]>",
                    prev = "<M-[>",
                }
            }
        })
    end
}
