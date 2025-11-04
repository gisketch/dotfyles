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
