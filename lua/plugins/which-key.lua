-- Which-key for keymap help
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    require("which-key").setup({
      preset = "classic",
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
          motions = true,
          text_objects = true,
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

    -- Register key groups and descriptions for all keymaps
    require("which-key").add({
      -- Main leader groups
      { "<leader>p", group = "Project" },
      { "<leader>f", group = "Find" },
      { "<leader>l", group = "LSP/Live" },
      { "<leader>g", group = "Git" },
      { "<leader>c", group = "Code" },
      { "<leader>t", group = "Terminal/Toggle" },
      { "<leader>w", group = "Workspace" },
      { "<leader>r", group = "Rename" },

      -- Movement and navigation
      { "<leader>h", desc = "Go to line start" },
      { "<leader>l", desc = "Go to line end" },
      { "<leader>j", desc = "Previous location list item" },
      { "<leader>k", desc = "Next location list item" },

      -- Leap motion keymaps
      { "s", desc = "Leap forward", mode = { "n", "x", "o" } },
      { "S", desc = "Leap backward", mode = { "n", "x", "o" } },
      { "gs", desc = "Leap from window", mode = { "n", "x", "o" } },

      -- Vim-surround keymaps (built-in, no custom config needed)
      { "cs", desc = "Change surrounding", mode = "n" },
      { "ds", desc = "Delete surrounding", mode = "n" },
      { "ys", desc = "Add surrounding", mode = "n" },
      { "yss", desc = "Add surrounding to line", mode = "n" },
      { "S", desc = "Add surrounding", mode = "v" },

      -- Git keymaps (vim-fugitive)
      { "<leader>gs", desc = "Git status" },
      { "<leader>gd", desc = "Git diff split" },
      { "<leader>gc", desc = "Git commit" },
      { "<leader>gp", desc = "Git push" },
      { "<leader>gl", desc = "Git pull" },
      { "<leader>gb", desc = "Git blame" },
      { "<leader>gL", desc = "Git log" },

      -- Clipboard operations
      { "<leader>p", desc = "Paste without overwriting register", mode = "x" },
      { "<leader>y", desc = "Yank to system clipboard", mode = { "n", "v" } },
      { "<leader>Y", desc = "Yank line to system clipboard" },

      -- Search and replace
      { "<leader>s", desc = "Search and replace word under cursor" },

      -- File operations
      { "<leader>x", desc = "Make file executable" },
      { "<leader><leader>", desc = "Source current file" },

      -- Session management
      { "<leader>S", desc = "Save session" },

      -- Code utilities
      { "<leader>cb", desc = "Surround with code block", mode = "x" },

      -- LSP keymaps (from lsp.lua)
      { "<leader>D", desc = "Type Definition" },
      { "<leader>d", desc = "Show Diagnostics Float" },
      { "<leader>e", desc = "Show Diagnostics" },
      { "<leader>q", desc = "Diagnostic Quickfix" },
      { "<leader>th", desc = "Toggle Inlay Hints" },
      { "<leader>wa", desc = "Add workspace folder" },
      { "<leader>wr", desc = "Remove workspace folder" },
      { "<leader>wl", desc = "List workspace folders" },
      { "<leader>rn", desc = "Rename symbol" },
      { "<leader>ca", desc = "Code action", mode = { "n", "v" } },
      { "<leader>f", desc = "Format document" },

      -- Go to mappings
      { "g", group = "Go to" },
      { "gd", desc = "Go to Definition" },
      { "gD", desc = "Go to Declaration" },
      { "gi", desc = "Go to Implementation" },
      { "gr", desc = "Go to References" },

      -- Diagnostic navigation
      { "[d", desc = "Previous Diagnostic" },
      { "]d", desc = "Next Diagnostic" },

      -- Visual mode movement
      { "J", desc = "Move selection down", mode = "v" },
      { "K", desc = "Move selection up", mode = "v" },

      -- Split and tab management
      { "<C-k>", desc = "Move to split above" },
      { "<C-j>", desc = "Move to split below" },
      { "<C-h>", desc = "Move to split left" },
      { "<C-l>", desc = "Move to split right" },

      -- Terminal mode
      { "<Esc>", desc = "Exit terminal mode", mode = "t" },

      -- Quickfix navigation
      { "<C-k>", desc = "Previous quickfix item" },
      { "<C-j>", desc = "Next quickfix item" },

      -- Telescope keymaps
      { "<leader>pf", desc = "Find files" },
      { "<leader>lg", desc = "Live grep" },
      { "<leader>pb", desc = "Find buffers" },
      { "<leader>fh", desc = "Help tags" },

      -- Oil file explorer
      { "<leader>pv", desc = "Open file explorer" },
    })
  end,
}