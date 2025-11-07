-- Theme configuration system
-- Supports multiple themes with separate highlight overrides

local M = {}

-- Theme definitions with their specific configurations
M.themes = {
    github_dark = {
        name = "GitHub Dark Dimmed",
        plugin = {
            'projekt0n/github-nvim-theme',
            name = 'github-theme',
        },
        colorscheme_name = 'github_dark_dimmed',
        neovide_colors = {
            title_background = "#22272e",
            title_text = "#22272e",
        },
        setup_highlights = function()
            local palette = require('github-theme.palette').load('github_dark_dimmed')

            -- Colors
            local darker_black = "#191d23"
            local black = "#1e2228"
            local black2 = "#24292f"
            local black3 = "#2b3137"
            local grey = "#363b42"

            require('github-theme').setup({
                groups = {
                    github_dark_dimmed = {
                        NormalFloat = { bg = darker_black },
                        FloatTitle = { bg = palette.success.fg, fg = black, bold = true },
                        FloatBorder = { bg = darker_black, fg = darker_black },
                        BlinkCmpMenuBorder = { bg = black, fg = black },
                        BlinkCmpDoc = { bg = black },
                        BlinkCmpScrollBarThumb = { bg = palette.black.base, fg = palette.black.base },
                        BlinkCmpDocBorder = { bg = black, fg = black },

                        -- Tiny Inline Diagnostic highlight groups
                        TinyInlineDiagnosticVirtualTextError = { fg = palette.danger.fg, bg = palette.danger.subtle, italic = true },
                        TinyInlineDiagnosticVirtualTextWarn = { fg = palette.attention.fg, bg = palette.attention.subtle, italic = true },
                        TinyInlineDiagnosticVirtualTextInfo = { fg = palette.accent.fg, bg = palette.accent.subtle, italic = true },
                        TinyInlineDiagnosticVirtualTextHint = { fg = palette.success.fg, bg = palette.success.subtle, italic = true },
                        TinyInlineDiagnosticVirtualTextArrow = { fg = "#565f89", bg = "NONE" },

                        -- Inverted groups for left/right signs
                        TinyInlineInvDiagnosticVirtualTextError = { fg = palette.danger.fg, bg = palette.danger.subtle, italic = true },
                        TinyInlineInvDiagnosticVirtualTextWarn = { fg = palette.attention.fg, bg = palette.attention.subtle, italic = true },
                        TinyInlineInvDiagnosticVirtualTextInfo = { fg = palette.accent.fg, bg = palette.accent.subtle, italic = true },
                        TinyInlineInvDiagnosticVirtualTextHint = { fg = palette.success.fg, bg = palette.success.subtle, italic = true },
                        TinyInlineInvDiagnosticVirtualTextArrow = { fg = "#565f89", bg = "NONE" },

                        -- LineNumber
                        CursorLineNr = { fg = palette.accent.fg, bold = true },

                        -- Telescope borderless configuration
                        TelescopeNormal = { bg = black },
                        TelescopeSelection = { bg = black2 },
                        TelescopePromptNormal = { bg = black3 },
                        TelescopePromptBorder = { bg = black3 },
                        TelescopePromptTitle = { bg = palette.accent.fg, fg = black },
                        TelescopePreviewTitle = { bg = palette.success.fg, fg = black },
                        TelescopePreviewNormal = { bg = darker_black },
                        TelescopePreviewBorder = { bg = darker_black, fg = darker_black },

                        -- Indent guides
                        SnacksIndent = { fg = black3 },
                        SnacksIndentScope = { fg = grey },

                        -- Notification
                        SnacksNotifierTitleWarn = { fg = palette.attention.fg, bg = black3 },
                        SnacksNotifierBorderWarn = { bg = black3, fg = black3 },
                        SnacksNotifierWarn = { bg = black3 },

                        -- Grapple highlight groups
                        GrappleActive = { fg = palette.success.fg, bold = true },
                        GrappleMuted = { fg = palette.success.muted },
                    }
                }
            })
        end,
    },

    everforest = {
        name = "Everforest",
        plugin = {
            'neanias/everforest-nvim',
            name = 'everforest',
        },
        colorscheme_name = 'everforest',
        neovide_colors = {
            title_background = "#272e33",
            title_text = "#272e33",
        },
        setup_highlights = function()
            -- Everforest configuration
            require('everforest').setup({
                background = "hard", -- Options: 'hard', 'medium', 'soft'
                transparent_background_level = 0,
                italics = true,
                disable_italic_comments = false,

                on_highlights = function(hl, palette)
                    -- Colors
                    local darker_black = "#1e2326"
                    local black = "#272e33"
                    local black2 = "#2e383c"
                    local black3 = "#374145"
                    local grey = "#414b50"

                    hl.DiagnosticError = { fg = palette.none, bg = palette.none, sp = palette.red }
                    hl.DiagnosticWarn = { fg = palette.none, bg = palette.none, sp = palette.yellow }
                    hl.DiagnosticInfo = { fg = palette.none, bg = palette.none, sp = palette.blue }
                    hl.DiagnosticHint = { fg = palette.none, bg = palette.none, sp = palette.green }
                    hl.NormalFloat = { bg = darker_black }
                    hl.FloatTitle = { bg = palette.green, fg = black, bold = true }
                    hl.FloatBorder = { bg = darker_black, fg = darker_black }
                    hl.BlinkCmpMenuBorder = { bg = darker_black, fg = darker_black }
                    hl.BlinkCmpMenu = { bg = darker_black }
                    hl.BlinkCmpDoc = { bg = darker_black }
                    hl.BlinkCmpScrollBarThumb = { bg = darker_black, fg = darker_black }
                    hl.BlinkCmpDocBorder = { bg = darker_black, fg = darker_black }

                    -- LineNumber
                    hl.CursorLineNr = { fg = palette.green, bold = true }

                    -- Leap
                    hl.LeapLabel = { fg = palette.yellow, bold = true }

                    -- Telescope borderless configuration
                    hl.TelescopeNormal = { bg = black }
                    hl.TelescopeSelection = { bg = black2 }
                    hl.TelescopePromptNormal = { bg = black3 }
                    hl.TelescopePromptBorder = { bg = black3, fg = black3 }
                    hl.TelescopePromptTitle = { bg = palette.blue, fg = black }
                    hl.TelescopePreviewTitle = { bg = palette.green, fg = black }
                    hl.TelescopePreviewNormal = { bg = darker_black }
                    hl.TelescopePreviewBorder = { bg = darker_black, fg = darker_black }

                    -- Snacks borderless
                    -- hl.TelescopeNormal = { bg = black }
                    -- hl.TelescopeSelection = { bg = black2 }
                    -- hl.TelescopePromptNormal = { bg = black3 }
                    hl.SnacksPickerInput = { bg = black3, }
                    hl.SnacksPickerPreview = { bg = darker_black, }
                    hl.SnacksPickerList = { bg = black, }
                    hl.SnacksPickerInputBorder = { bg = black3, fg = black3 }
                    hl.SnacksPickerPreviewBorder = { bg = darker_black, fg = darker_black }
                    hl.SnacksPickerListBorder = { bg = black, fg = black }

                    hl.SnacksPickerInputTitle = { bg = palette.green, fg = black }
                    hl.SnacksPickerPreviewTitle = { bg = palette.blue, fg = black }

                    hl.SnacksInputIcon = { bg = darker_black, fg = palette.green }
                    hl.SnacksInputTitle = { bg = palette.green, fg = darker_black }
                    hl.SnacksInputNormal = { bg = darker_black,}
                    hl.SnacksInputBorder = { bg = darker_black, fg = darker_black }
                    hl.SnacksInputPrompt = { bg = darker_black, }

                    -- Indent guides
                    hl.SnacksIndent = { fg = black3 }
                    hl.SnacksIndentScope = { fg = grey }

                    -- Notification
                    hl.SnacksNotifierTitleWarn = { fg = palette.yellow, bg = black3 }
                    hl.SnacksNotifierBorderWarn = { bg = black3, fg = black3 }
                    hl.SnacksNotifierWarn = { bg = black3 }
                    hl.NoiceCmdlinePopupBorder = { bg = darker_black, fg = darker_black }

                    -- Grapple highlight groups
                    hl.GrappleActive = { fg = palette.green, bold = true }

                    -- Tiny Inline Diagnostic highlight groups
                    hl.TinyInlineDiagnosticVirtualTextError = { fg = palette.red, bg = palette.red, italic = true }
                    hl.TinyInlineDiagnosticVirtualTextWarn = { fg = palette.yellow, bg = palette.yellow, italic = true }
                    hl.TinyInlineDiagnosticVirtualTextInfo = { fg = palette.blue, bg = palette.blue, italic = true }
                    hl.TinyInlineDiagnosticVirtualTextHint = { fg = palette.green, bg = palette.green, italic = true }
                    hl.TinyInlineDiagnosticVirtualTextArrow = { fg = palette.purple, bg = "NONE" }

                    hl.TinyInlineInvDiagnosticVirtualTextError = { fg = palette.red, bg = palette.red, italic = true }
                    hl.TinyInlineInvDiagnosticVirtualTextWarn = { fg = palette.yellow, bg = palette.yellow, italic = true }
                    hl.TinyInlineInvDiagnosticVirtualTextInfo = { fg = palette.blue, bg = palette.blue, italic = true }
                    hl.TinyInlineInvDiagnosticVirtualTextHint = { fg = palette.green, bg = palette.green, italic = true }
                    hl.TinyInlineInvDiagnosticVirtualTextArrow = { fg = palette.purple, bg = "NONE" }
                end,
            })

            -- Custom highlight overrides for everforest (empty for now)
            -- You can add everforest-specific overrides here later
        end,
    },
}

-- Get the current theme from global variable or default to github_dark
M.get_current_theme = function()
    return vim.g.current_colorscheme or "everforest"
end

-- Apply a theme by name
M.apply_theme = function(theme_key)
    local theme = M.themes[theme_key]
    if not theme then
        vim.notify("Theme '" .. theme_key .. "' not found", vim.log.levels.ERROR)
        return
    end

    -- Setup highlights (this also configures the theme plugin)
    theme.setup_highlights()

    -- Apply the colorscheme
    vim.cmd('colorscheme ' .. theme.colorscheme_name)

    -- Update neovide colors if running in neovide
    if vim.g.neovide then
        vim.g.neovide_title_background_color = theme.neovide_colors.title_background
        vim.g.neovide_title_text_color = theme.neovide_colors.title_text
    end

    -- Save the current theme
    vim.g.current_colorscheme = theme_key

    -- vim.notify("Applied theme: " .. theme.name, vim.log.levels.INFO)
end

-- Theme picker using telescope
M.theme_picker = function()
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local themes_list = {}
    for key, theme in pairs(M.themes) do
        table.insert(themes_list, {
            key = key,
            name = theme.name,
        })
    end

    pickers.new({}, {
        prompt_title = "Select Theme",
        finder = finders.new_table({
            results = themes_list,
            entry_maker = function(entry)
                return {
                    value = entry.key,
                    display = entry.name,
                    ordinal = entry.name,
                }
            end,
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                M.apply_theme(selection.value)
            end)
            return true
        end,
    }):find()
end

-- Return the plugin configurations for lazy.nvim
-- We need to return all theme plugins
local plugins = {}
for _, theme in pairs(M.themes) do
    local plugin_spec = vim.deepcopy(theme.plugin)
    plugin_spec.lazy = false
    plugin_spec.priority = 1000
    table.insert(plugins, plugin_spec)
end

-- Add config to the first plugin (github-theme) to initialize the default theme
plugins[1].config = function()
    local default_theme = M.get_current_theme()
    M.apply_theme(default_theme)
end

-- Make the module globally accessible for the theme picker
_G.ThemeManager = M

return plugins
