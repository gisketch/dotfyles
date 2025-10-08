-- Native Neovim LSP Configuration
return {
  -- Schema store for JSON
  {
    "b0o/schemastore.nvim",
    lazy = true,
  },

  -- Mason for LSP server management
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end,
  },

  -- Mason LSP config for automatic server installation
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",        -- TypeScript/JavaScript
          "html",         -- HTML
          "cssls",        -- CSS
          "jsonls",       -- JSON
          "lua_ls",       -- Lua
          "pyright",      -- Python
          "tailwindcss",  -- Tailwind CSS (useful for React)
        },
        automatic_installation = true,
      })

      -- Enable LSP configurations after Mason installs servers
      vim.api.nvim_create_autocmd("User", {
        pattern = "MasonLspInstallComplete",
        callback = function()
          -- Enable all configured LSP servers
          local servers = { "ts_ls", "html", "cssls", "jsonls", "lua_ls", "pyright", "tailwindcss" }
          for _, server in ipairs(servers) do
            vim.lsp.enable(server)
          end
        end,
      })

      -- Also enable immediately if servers are already installed
      vim.schedule(function()
        local servers = { "ts_ls", "html", "cssls", "jsonls", "lua_ls", "pyright", "tailwindcss" }
        for _, server in ipairs(servers) do
          vim.lsp.enable(server)
        end
      end)
    end,
  },

  -- Blink.cmp - Performant completion plugin
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      keymap = { preset = 'default' },

      appearance = {
        -- 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        nerd_font_variant = 'mono'
      },

      -- Only show documentation popup when manually triggered
      completion = { 
        documentation = { auto_show = false },
        menu = {
          border = 'none'
        }
      },

      -- Default list of enabled providers
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      -- Use Rust fuzzy matcher for better performance
      fuzzy = { implementation = "prefer_rust_with_warning" },

      -- Signature help configuration
      signature = { enabled = true }
    },
    opts_extend = { "sources.default" }
  },

  -- LSP Configuration and Keymaps
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    config = function()
      -- Configure diagnostics
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "none",
          source = "always",
          header = "",
          prefix = "",
        },
      })

      -- LSP Attach function for keymaps and options
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }

          -- LSP Keymaps (using native 0.11 defaults where possible)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
          vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))
          vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, vim.tbl_extend("force", opts, { desc = "Add workspace folder" }))
          vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, vim.tbl_extend("force", opts, { desc = "Remove workspace folder" }))
          vim.keymap.set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, vim.tbl_extend("force", opts, { desc = "List workspace folders" }))
          vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Type definition" }))
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
          vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Go to references" }))
          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, vim.tbl_extend("force", opts, { desc = "Format document" }))

          -- Diagnostic keymaps
          vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show diagnostics float" }))
          vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show line diagnostics" }))
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
          vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, vim.tbl_extend("force", opts, { desc = "Diagnostic loclist" }))

          -- Inlay hints toggle (disabled by default)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if client and client.server_capabilities.inlayHintProvider then
            -- Disable inlay hints by default
            vim.lsp.inlay_hint.enable(false, { bufnr = ev.buf })
            
            -- Add toggle keymap
            vim.keymap.set("n", "<leader>th", function()
              local current_setting = vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf })
              vim.lsp.inlay_hint.enable(not current_setting, { bufnr = ev.buf })
              print("Inlay hints " .. (not current_setting and "enabled" or "disabled"))
            end, vim.tbl_extend("force", opts, { desc = "Toggle inlay hints" }))
          end
        end,
      })

      -- Configure LSP capabilities for blink.cmp
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Set up global LSP configuration
      vim.lsp.config("*", {
        capabilities = capabilities,
      })
    end,
  },
}