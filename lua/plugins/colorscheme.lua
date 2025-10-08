-- Colorscheme configuration
return {
  "thesimonho/kanagawa-paper.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("kanagawa-paper").setup({
      undercurl = true,
      transparent = false,
      gutter = false,
      dim_inactive = false,
      terminal_colors = true,
      styles = {
        comment = { italic = true },
        functions = { italic = false },
        keyword = { italic = false, bold = false },
        statement = { italic = false, bold = false },
        type = { italic = false },
      },
    })
    vim.cmd.colorscheme("kanagawa-paper-ink")
  end,
}