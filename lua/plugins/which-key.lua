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
      { "<leader>n", group = "Notifications" },
      { "<leader>s", group = "Sessions" },

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

      -- Git keymaps (vim-fugitive only)
      { "<leader>gs", desc = "Git status (fugitive)" },
      { "<leader>gd", desc = "Git diff split" },
      { "<leader>gc", desc = "Git commit" },
      { "<leader>gp", desc = "Git push" },
      { "<leader>gl", desc = "Git pull" },
      { "<leader>gb", desc = "Git blame" },
      { "<leader>gL", desc = "Git log" },

      -- Session management
      { "<leader>ss", desc = "Save Session" },
      { "<leader>sd", desc = "Delete Session" },

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
      { "<leader>vpp", desc = "Open packer config" },

      -- Code utilities
      { "<leader>f", desc = "Format file" },

      -- Floaterm - Beautiful floating terminal
      { "<leader>t", "<cmd>FloatermToggle<cr>", desc = "Toggle Floating Terminal" },

      -- LSP keymaps
      { "gd", desc = "Go to definition" },
      { "K", desc = "Hover documentation" },
      { "<leader>vws", desc = "Workspace symbol search" },
      { "<leader>vd", desc = "Open diagnostic float" },
      { "[d", desc = "Previous diagnostic" },
      { "]d", desc = "Next diagnostic" },
      { "<leader>vca", desc = "Code action" },
      { "<leader>vrr", desc = "References" },
      { "<leader>vrn", desc = "Rename symbol" },
    --   { "<C-h>", desc = "Signature help", mode = "i" },

      -- Go to mappings
      { "gD", desc = "Go to declaration" },
      { "gi", desc = "Go to implementation" },
      { "go", desc = "Go to type definition" },
      { "gr", desc = "Go to references" },
      { "gs", desc = "Signature help" },

      -- Diagnostic navigation
      { "<C-k>", desc = "Previous diagnostic" },
      { "<C-j>", desc = "Next diagnostic" },

      -- Visual mode
      { "<leader>vca", desc = "Code action", mode = "v" },

      -- Split and tab management
      { "<C-h>", desc = "Move to left split" },
      { "<C-j>", desc = "Move to bottom split" },
      { "<C-k>", desc = "Move to top split" },
      { "<C-l>", desc = "Move to right split" },

      -- Terminal mode
      { "<Esc>", desc = "Exit terminal mode", mode = "t" },

      -- Quickfix
      { "<C-k>", desc = "Previous quickfix item" },
      { "<C-j>", desc = "Next quickfix item" },

      -- Telescope
      { "<leader>pf", desc = "Find files in project" },
      { "<C-p>", desc = "Find files in git" },
      { "<leader>ps", desc = "Grep in project" },
      { "<leader>vh", desc = "Help tags" },

      -- Oil file manager
      { "<leader>pv", desc = "Open file explorer" },

      -- Snacks dashboard and utilities
      { "<leader>.", desc = "Dashboard" },
      { "<leader>bd", desc = "Delete Buffer" },
      { "<leader>cR", desc = "Rename File" },
      { "<leader>gB", desc = "Git Blame Line" },
      { "<leader>nd", desc = "Hide All Notifications" },
      { "<leader>un", desc = "Show Notification History" },
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },

      -- Toggle mappings (created by snacks)
      { "<leader>us", desc = "Toggle spelling" },
      { "<leader>uw", desc = "Toggle wrap" },
      { "<leader>uL", desc = "Toggle relative number" },
      { "<leader>ud", desc = "Toggle diagnostics" },
      { "<leader>ul", desc = "Toggle line number" },
      { "<leader>uc", desc = "Toggle conceal level" },
      { "<leader>uT", desc = "Toggle treesitter" },
      { "<leader>ub", desc = "Toggle dark background" },
      { "<leader>uh", desc = "Toggle inlay hints" },
    })
  end,
}