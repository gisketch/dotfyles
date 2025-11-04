return {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        local palette = require('github-theme.palette').load('github_dark_dimmed')

        -- colors
        local darker_black = "#191d23"
        local black = "#1e2228"
        local black2 = "#24292f"
        local black3 = "#2b3137"

        local grey = "#363b42"
        local grey2 = "#4c566a"

        require('github-theme').setup({
            groups = {
                github_dark_dimmed = {
                    NormalFloat = { bg = darker_black },
                    FloatTitle = { bg = palette.success.fg, fg = black, bold = true }, -- title styling
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
                    CursorLineNr = {
                        fg = palette.accent.fg, bold = true
                    },

                    -- Telescope borderless configuration
                    TelescopeNormal = {
                        bg = black,
                    },
                    TelescopeSelection = {
                        bg = black2,
                    },
                    TelescopePromptNormal = {
                        bg = black3,
                    },
                    TelescopePromptBorder = {
                        bg = black3,
                    },
                    TelescopePromptTitle = {
                        bg = palette.accent.fg,
                        fg = black,
                    },
                    TelescopePreviewTitle = {
                        bg = palette.success.fg,
                        fg = black,
                    },
                    TelescopePreviewNormal = {
                        bg = darker_black,
                    },
                    TelescopePreviewBorder = {
                        bg = darker_black,
                        fg = darker_black,
                    },


                    -- indent
                    SnacksIndent = {
                        fg = black3
                    },
                    SnacksIndentScope = {
                        fg = grey
                    },


                    -- notification
                    SnacksNotifierTitleWarn = {
                        fg = palette.attention.fg,
                        bg = black3,
                        -- fg = black
                    },
                    SnacksNotifierBorderWarn = {
                        bg = black3,
                        fg = black3,
                    },
                    SnacksNotifierWarn = {
                        bg = black3,
                    },

                    -- Grapple highlight groups
                    GrappleActive = { fg = palette.success.fg, bold = true },
                    GrappleMuted = { fg = palette.success.muted },
                }

            }
        })
        vim.cmd('colorscheme github_dark_dimmed')
        -- Enable transparent background so the terminal's transparency shows through
        -- Override any theme backgrounds that set a solid color
        -- vim.cmd('highlight Normal guibg=NONE ctermbg=NONE')
        -- vim.cmd('highlight NormalNC guibg=NONE ctermbg=NONE')
        -- vim.cmd('highlight NormalFloat guibg=NONE ctermbg=NONE')
        -- vim.cmd('highlight SignColumn guibg=NONE ctermbg=NONE')
        -- vim.cmd('highlight EndOfBuffer guibg=NONE ctermbg=NONE')
        -- vim.cmd('highlight FloatBorder guibg=NONE ctermbg=NONE')
    end,

}

-- -- Colorscheme configuration
-- return {
--   "webhooked/kanso.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require('kanso').setup({
--       bold = true,                 -- enable bold fonts
--       italics = true,             -- enable italics
--       compile = false,             -- enable compiling the colorscheme
--       undercurl = true,            -- enable undercurls
--       commentStyle = { italic = true },
--       functionStyle = {},
--       keywordStyle = { italic = true},
--       statementStyle = {},
--       typeStyle = {},
--       transparent = false,         -- do not set background color
--       dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
--       terminalColors = true,       -- define vim.g.terminal_color_{0,17}
--       colors = {                   -- add/modify theme and palette colors
--           palette = {},
--           theme = { zen = {}, pearl = {}, ink = {}, all = {} },
--       },
--       overrides = function(colors) -- add/modify highlights
--           -- Get the background color from the theme
--           local bg = colors.theme.ui.bg
--           local bg_highlight = colors.theme.ui.bg_highlight or colors.theme.ui.bg_m1
--           local fg = colors.theme.ui.fg
--
--           return {
--             -- Floating window colors (random bright color for testing)
--             --     -- Zen Bg Shades
--             -- zenBg0 = "#090E13",
--             -- zenBg1 = "#1C1E25",
--             -- zenBg2 = "#22262D",
--             -- zenBg3 = "#393B44",
--             --
--             -- -- Ink Bg Shades
--             -- inkBg0 = "#14171d",
--             -- inkBg1 = "#1f1f26",
--             -- inkBg2 = "#22262D",
--             -- inkBg3 = "#393B44",
--             -- inkBg4 = "#4b4e57",
--             --
--             NormalFloat = { bg = "#14171D" },
--             FloatBorder = { bg ="#14171D", fg = "#14171D" },
--             BlinkCmpMenu = { bg = "#14171D" },
--             BlinkCmpMenuBorder = { bg ="#14171D", fg = "#14171D" },
--             -- FloatTitle = { bg ="#1C1E25" , fg = "#ffffff", bold = true },  -- title styling
--
--             -- Grapple highlight groups
--             GrappleActive = { fg = "#7FB4CA", bold = true },  -- blue from your palette
--             GrappleMuted = { fg = "#658594" },                -- blue2 (muted) from your palette
--
--             -- Tiny Inline Diagnostic highlight groups
--             TinyInlineDiagnosticVirtualTextError = { fg = "#f7768e", bg = "#3d2a2e", italic = true },
--             TinyInlineDiagnosticVirtualTextWarn = { fg = "#e0af68", bg = "#3d3424", italic = true },
--             TinyInlineDiagnosticVirtualTextInfo = { fg = "#7aa2f7", bg = "#2a2d3a", italic = true },
--             TinyInlineDiagnosticVirtualTextHint = { fg = "#9ece6a", bg = "#2a3426", italic = true },
--             TinyInlineDiagnosticVirtualTextArrow = { fg = "#565f89", bg = "NONE" },
--
--             -- Inverted groups for left/right signs
--             TinyInlineInvDiagnosticVirtualTextError = { fg = "#3d2a2e", bg = "#f7768e" },
--             TinyInlineInvDiagnosticVirtualTextWarn = { fg = "#3d3424", bg = "#e0af68" },
--             TinyInlineInvDiagnosticVirtualTextInfo = { fg = "#2a2d3a", bg = "#7aa2f7" },
--             TinyInlineInvDiagnosticVirtualTextHint = { fg = "#2a3426", bg = "#9ece6a" },
--
--             -- Also ensure the base diagnostic groups have proper colors
--             DiagnosticError = { fg = "#f7768e" },
--             DiagnosticWarn = { fg = "#e0af68" },
--             DiagnosticInfo = { fg = "#7aa2f7" },
--             DiagnosticHint = { fg = "#9ece6a" },
--
--             -- Telescope borderless configuration
--             TelescopeNormal = {
--               bg = bg,
--               fg = fg,
--             },
--             TelescopeBorder = {
--               bg = bg,
--               fg = bg,
--             },
--             TelescopePromptNormal = {
--               bg = bg,
--             },
--             TelescopePromptBorder = {
--               bg = bg,
--               fg = bg,
--             },
--             TelescopePromptTitle = {
--               bg = bg_highlight,
--               fg = fg,
--             },
--             TelescopePreviewTitle = {
--               bg = bg,
--               fg = bg,
--             },
--             TelescopeResultsTitle = {
--               bg = bg,
--               fg = bg,
--             },
--             TelescopeResultsNormal = {
--               bg = bg,
--             },
--             TelescopePreviewNormal = {
--               bg = "#14171d",
--             },
--             TelescopeResultsBorder = {
--               bg = bg,
--               fg = bg,
--             },
--             TelescopePreviewBorder = {
--               bg = bg,
--               fg = bg,
--             },
--           }
--       end,
--       background = {               -- map the value of 'background' option to a theme
--           dark = "zen",           -- try "zen", "mist" or "pearl" !
--           light = "pearl"         -- try "zen", "mist" or "pearl" !
--       },
--       foreground = "default",      -- "default" or "saturated"
--     })
--     vim.cmd("colorscheme kanso")
--   end,
-- }

