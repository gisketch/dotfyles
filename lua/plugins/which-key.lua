-- Which-key for keymap help
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    require("which-key").setup({
      preset = "helix",
      delay = function(ctx)
        return ctx.plugin and 0 or 200
      end,
      filter = function(mapping)
        return true
      end,
      spec = {},
      notify = true,
      triggers = {
        { "<auto>", mode = "nxso" },
      },
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = true,
          motions = false,
          text_objects = false,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
      win = {
        no_overlap = true,
        padding = { 1, 2 },
        title = true,
        title_pos = "center",
        zindex = 1000,
      },
      layout = {
        width = { min = 20 },
        spacing = 3,
      },
    })

    -- Register key groups only - individual keymaps auto-register from their plugin configs
    require("which-key").add({
      -- Leader key groups
      { "<leader>p", group = "Project" },
      { "<leader>f", group = "Find" },
      { "<leader>l", group = "LSP/Live" },
      { "<leader>g", group = "Git" },
      { "<leader>c", group = "Code" },
      { "<leader>t", group = "Terminal/Toggle" },
      { "<leader>w", group = "Workspace" },
      { "<leader>r", group = "Rename" },
      { "<leader>n", group = "Notifications" },
      { "<leader>u", group = "UI/Utilities" },
      { "<leader>v", group = "Vim" },
    })
  end,
}
