-- Statusline configuration
return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "cbochs/grapple.nvim", "lewis6991/gitsigns.nvim" },
    config = function()
        local num_icons = {
            "󰎤 ",
            "󰎧 ",
            "󰎪 ",
            "󰎭 ",
            "󰎱 ",
            "󰎳 ",
            "󰎶 ",
            "󰎹 ",
            "󰎼 ",
            "󰽽 ",
        }

        -- Grapple numbers component
        local grapple_numbers = {
            function()
                local grapple = require("grapple")
                local tags = grapple.tags()

                if not tags or #tags == 0 then
                    return ""
                end

                local current_path = vim.fn.expand("%:p")
                local current_tag = grapple.find({ path = current_path })
                local icons = {}

                for i, tag in ipairs(tags) do
                    local icon = num_icons[i] or tostring(i)
                    local is_current = current_tag and current_tag.path == tag.path
                    if is_current then
                        table.insert(icons, string.format("%%#GrappleActive#%s%%*", icon))
                    else
                        table.insert(icons, string.format("%%#GrappleMuted#%s%%*", icon))
                    end
                end

                return table.concat(icons, "")
            end,
            separator = { left = "", right = "" },
        }

        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                always_show_tabline = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                    refresh_time = 16, -- ~60fps
                    events = {
                        'WinEnter',
                        'BufEnter',
                        'BufWritePost',
                        'SessionLoadPost',
                        'FileChangedShellPost',
                        'VimResized',
                        'Filetype',
                        'CursorMoved',
                        'CursorMovedI',
                        'ModeChanged',
                        'DirChanged',
                    },
                }
            },
            sections = {
                lualine_a = {
                    'mode',
                    {
                        function()
                            local reg = vim.fn.reg_recording()
                            return reg == "" and "" or ("recording @" .. reg)
                        end,
                        icon = "", -- Optional icon prefix
                    }
                },
                lualine_b = {
                    'filename',
                    'branch',
                    {
                        'diff',
                        source = function()
                            local gitsigns = vim.b.gitsigns_status_dict
                            if gitsigns then
                                return {
                                    added = gitsigns.added,
                                    modified = gitsigns.changed,
                                    removed = gitsigns.removed
                                }
                            end
                        end,
                    },
                    'diagnostics'
                },
                lualine_c = { grapple_numbers },
                -- lualine_x = { 'filename' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        }
        -- Create autocmds for session-related updates
        local grapple_lualine_group = vim.api.nvim_create_augroup("GrappleLualine", { clear = true })
        -- Force refresh lualine when sessions are loaded
        vim.api.nvim_create_autocmd({ "SessionLoadPost", "VimEnter" }, {
            group = grapple_lualine_group,
            callback = function()
                -- Delay the refresh to ensure grapple has loaded its state
                vim.defer_fn(function()
                    require('lualine').refresh()
                end, 150)
            end,
        })
        -- Also refresh when directory changes (common with session switches)
        vim.api.nvim_create_autocmd("DirChanged", {
            group = grapple_lualine_group,
            callback = function()
                vim.defer_fn(function()
                    require('lualine').refresh()
                end, 100)
            end,
        })
        -- Refresh when grapple tags are updated
        vim.api.nvim_create_autocmd("User", {
            pattern = "GrappleUpdate",
            group = grapple_lualine_group,
            callback = function()
                require('lualine').refresh()
            end,
        })
    end,
}
