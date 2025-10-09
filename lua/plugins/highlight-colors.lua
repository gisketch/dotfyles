-- Color highlighting plugin for CSS, Tailwind, and more
return {
  "brenoprata10/nvim-highlight-colors",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- Ensure termguicolors is enabled
    vim.opt.termguicolors = true
    
    require("nvim-highlight-colors").setup({
      ---Render style
      ---@usage 'background'|'foreground'|'virtual'
      render = 'background',

      ---Set virtual symbol (requires render to be set to 'virtual')
      virtual_symbol = '■',

      ---Set virtual symbol prefix (defaults to '')
      virtual_symbol_prefix = '',

      ---Set virtual symbol suffix (defaults to ' ')
      virtual_symbol_suffix = ' ',

      ---Set virtual symbol position()
      ---@usage 'inline'|'eol'|'eow'
      virtual_symbol_position = 'inline',

      ---Highlight hex colors, e.g. '#FFFFFF'
      enable_hex = true,

      ---Highlight short hex colors e.g. '#fff'
      enable_short_hex = true,

      ---Highlight rgb colors, e.g. 'rgb(0 0 0)'
      enable_rgb = true,

      ---Highlight hsl colors, e.g. 'hsl(150deg 30% 40%)'
      enable_hsl = true,
      
      ---Highlight ansi colors, e.g '\033[0;34m'
      enable_ansi = true,

      ---Highlight hsl colors without function, e.g. '--foreground: 0 69% 69%;'
      enable_hsl_without_function = true,

      ---Highlight CSS variables, e.g. 'var(--testing-color)'
      enable_var_usage = true,

      ---Highlight named colors, e.g. 'green'
      enable_named_colors = true,

      ---Highlight tailwind colors, e.g. 'bg-blue-500'
      enable_tailwind = true, -- Enabled since you might use Tailwind

      ---Set custom colors for your theme variables
      custom_colors = {
        { label = '%-%-theme%-primary%-color', color = '#0f1219' },
        { label = '%-%-theme%-secondary%-color', color = '#5a5d64' },
      },

      -- Exclude certain filetypes if needed
      exclude_filetypes = {},
      exclude_buftypes = {},
    })
  end,
}