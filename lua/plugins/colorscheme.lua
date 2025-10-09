-- Colorscheme configuration
return {
  "webhooked/kanso.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require('kanso').setup({
      bold = true,                 -- enable bold fonts
      italics = true,             -- enable italics
      compile = false,             -- enable compiling the colorscheme
      undercurl = true,            -- enable undercurls
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true},
      statementStyle = {},
      typeStyle = {},
      transparent = false,         -- do not set background color
      dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
      terminalColors = true,       -- define vim.g.terminal_color_{0,17}
      colors = {                   -- add/modify theme and palette colors
          palette = {},
          theme = { zen = {}, pearl = {}, ink = {}, all = {} },
      },
      overrides = function(colors) -- add/modify highlights
          -- Get the background color from the theme
          local bg = colors.theme.ui.bg
          local bg_highlight = colors.theme.ui.bg_highlight or colors.theme.ui.bg_m1
          local fg = colors.theme.ui.fg
          
          return {
            -- Tiny Inline Diagnostic highlight groups
            TinyInlineDiagnosticVirtualTextError = { fg = "#f7768e", bg = "#3d2a2e", italic = true },
            TinyInlineDiagnosticVirtualTextWarn = { fg = "#e0af68", bg = "#3d3424", italic = true },
            TinyInlineDiagnosticVirtualTextInfo = { fg = "#7aa2f7", bg = "#2a2d3a", italic = true },
            TinyInlineDiagnosticVirtualTextHint = { fg = "#9ece6a", bg = "#2a3426", italic = true },
            TinyInlineDiagnosticVirtualTextArrow = { fg = "#565f89", bg = "NONE" },
            
            -- Inverted groups for left/right signs
            TinyInlineInvDiagnosticVirtualTextError = { fg = "#3d2a2e", bg = "#f7768e" },
            TinyInlineInvDiagnosticVirtualTextWarn = { fg = "#3d3424", bg = "#e0af68" },
            TinyInlineInvDiagnosticVirtualTextInfo = { fg = "#2a2d3a", bg = "#7aa2f7" },
            TinyInlineInvDiagnosticVirtualTextHint = { fg = "#2a3426", bg = "#9ece6a" },
            
            -- Also ensure the base diagnostic groups have proper colors
            DiagnosticError = { fg = "#f7768e" },
            DiagnosticWarn = { fg = "#e0af68" },
            DiagnosticInfo = { fg = "#7aa2f7" },
            DiagnosticHint = { fg = "#9ece6a" },
            
            -- Telescope borderless configuration
            TelescopeNormal = {
              bg = bg,
              fg = fg,
            },
            TelescopeBorder = {
              bg = bg,
              fg = bg,
            },
            TelescopePromptNormal = {
              bg = bg,
            },
            TelescopePromptBorder = {
              bg = bg,
              fg = bg,
            },
            TelescopePromptTitle = {
              bg = bg_highlight,
              fg = fg,
            },
            TelescopePreviewTitle = {
              bg = bg,
              fg = bg,
            },
            TelescopeResultsTitle = {
              bg = bg,
              fg = bg,
            },
            TelescopeResultsNormal = {
              bg = bg,
            },
            TelescopePreviewNormal = {
              bg = bg,
            },
            TelescopeResultsBorder = {
              bg = bg,
              fg = bg,
            },
            TelescopePreviewBorder = {
              bg = bg,
              fg = bg,
            },
          }
      end,
      background = {               -- map the value of 'background' option to a theme
          dark = "zen",           -- try "zen", "mist" or "pearl" !
          light = "pearl"         -- try "zen", "mist" or "pearl" !
      },
      foreground = "default",      -- "default" or "saturated"
    })
    vim.cmd("colorscheme kanso")
  end,
}
