-- Git integration for buffers
return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        signs = {
            add = { text = "│" },
            change = { text = "│" },
            delete = { text = "󰍵" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
            untracked = { text = "│" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
            follow_files = true
        },
        auto_attach = true,
        attach_to_untracked = false,
        current_line_blame = false,
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = 'eol',
            delay = 1000,
            ignore_whitespace = false,
            virt_text_priority = 100,
            use_focus = true,
        },
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
            style = 'minimal',
            relative = 'cursor',
            row = 0,
            col = 1
        },
    },
    keys = {
        -- Navigation
        {
            "]c",
            function()
                if vim.wo.diff then
                    vim.cmd.normal({ ']c', bang = true })
                else
                    require('gitsigns').nav_hunk('next')
                end
            end,
            desc = "Next git hunk"
        },
        {
            "[c",
            function()
                if vim.wo.diff then
                    vim.cmd.normal({ '[c', bang = true })
                else
                    require('gitsigns').nav_hunk('prev')
                end
            end,
            desc = "Previous git hunk"
        },

        -- Gitsigns operations picker
        {
            "<leader>uh",
            function()
                local gitsigns = require('gitsigns')

                -- Gitsigns operations with nerd font icons
                local hunk_operations = {
                    { icon = "󰊢", name = "Stage Hunk", action = function() gitsigns.stage_hunk() end },
                    { icon = "󰛔", name = "Reset Hunk", action = function() gitsigns.reset_hunk() end },
                    { icon = "󰊢", name = "Stage Buffer", action = function() gitsigns.stage_buffer() end },
                    { icon = "󰜺", name = "Undo Stage Hunk", action = function() gitsigns.undo_stage_hunk() end },
                    { icon = "󰛔", name = "Reset Buffer", action = function() gitsigns.reset_buffer() end },
                    { icon = "󰍉", name = "Preview Hunk", action = function() gitsigns.preview_hunk() end },
                    { icon = "󰈬", name = "Blame Line", action = function() gitsigns.blame_line { full = true } end },
                    { icon = "󰔀", name = "Diff This", action = function() gitsigns.diffthis() end },
                    { icon = "󰔀", name = "Diff This ~", action = function() gitsigns.diffthis('~') end },
                    { icon = "󰔡", name = "Toggle Line Blame", action = function() gitsigns.toggle_current_line_blame() end },
                    { icon = "󰍵", name = "Toggle Deleted", action = function() gitsigns.toggle_deleted() end },
                }

                -- Create display items for vim.ui.select
                local display_items = {}
                for _, op in ipairs(hunk_operations) do
                    table.insert(display_items, op.icon .. " " .. op.name)
                end

                vim.ui.select(display_items, {
                    prompt = ' Gitsigns Operations: ',
                    format_item = function(item)
                        return item
                    end,
                }, function(choice, idx)
                    if not choice or not idx then
                        return
                    end

                    local selected_op = hunk_operations[idx]
                    selected_op.action()
                end)
            end,
            desc = "Gitsigns operations picker",
        },

        -- Text object
        { "ih", ":<C-U>Gitsigns select_hunk<CR>", mode = { "o", "x" }, desc = "Select hunk" },
    },
}
