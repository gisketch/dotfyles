-- Telescope fuzzy finder
return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "JoseConseco/telescope_sessions_picker.nvim",
        "nvim-telescope/telescope-ui-select.nvim"
    },
    config = function()
        -- Cross-platform session directory (same as mini-sessions)
        local session_dir
        if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
            -- Windows
            session_dir = vim.fn.expand('$LOCALAPPDATA/nvim-sessions') .. '/'
        else
            -- macOS and Linux
            session_dir = vim.fn.expand('~/.local/share/nvim-sessions') .. '/'
        end

        -- Full screen telescope functionality
        local temp_showtabline
        local temp_laststatus

        function _G.global_telescope_find_pre()
            temp_showtabline = vim.o.showtabline
            temp_laststatus = vim.o.laststatus
            vim.o.showtabline = 0
            vim.o.laststatus = 0
        end

        function _G.global_telescope_leave_prompt()
            vim.o.laststatus = temp_laststatus
            vim.o.showtabline = temp_showtabline
        end

        -- Auto commands for full screen telescope
        vim.cmd([[
      augroup TelescopeFullScreen
        autocmd!
        autocmd User TelescopeFindPre lua global_telescope_find_pre()
        autocmd FileType TelescopePrompt autocmd BufLeave <buffer> lua global_telescope_leave_prompt()
      augroup END
    ]])

        require("telescope").setup({
            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--hidden",
                    "--glob=!.git/",
                },
                prompt_prefix = "   ",
                selection_caret = " ",
                entry_prefix = " ",
                initial_mode = "insert",
                selection_strategy = "reset",
                sorting_strategy = "ascending",
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        width = { padding = 10 },
                        height = { padding = 5 },
                        preview_width = 0.5,
                    },
                },
                file_sorter = require("telescope.sorters").get_fuzzy_file,
                file_ignore_patterns = { "node_modules", ".git/" },
                generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                winblend = 0,
                border = {},
                borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
                color_devicons = true,
                use_less = true,
                set_env = { ["COLORTERM"] = "truecolor" },
                -- Better path display - filename first
                path_display = {
                    "filename_first",
                },
            },
            extensions = {
                sessions_picker = {
                    sessions_dir = session_dir,
                },
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown {
                        -- You can customize the theme here
                    }
                }
            },
        })

        -- Load extensions
        require('telescope').load_extension('sessions_picker')
        require("telescope").load_extension("ui-select")
    end,
    keys = {
        { "<leader>pf", "<cmd>Telescope find_files<cr>",      desc = "Find files" },
        { "<leader>lg", "<cmd>Telescope live_grep<cr>",       desc = "Live grep" },
        { "<leader>pb", "<cmd>Telescope buffers<cr>",         desc = "Find buffers" },
        -- { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
        { "<leader>ps", "<cmd>Telescope live_grep<cr>",       desc = "Find word or string in project" },
        { "<leader>e",  "<cmd>Telescope sessions_picker<cr>", desc = "Load Session" },
    },
}
