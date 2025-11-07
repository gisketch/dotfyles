-- Generic utilities picker
return {
  "folke/which-key.nvim", -- Dependency to ensure which-key is loaded
  optional = true,
  keys = {
    {
      "<leader>ut",
      function()
        -- Utility operations with nerd font icons
        local utility_operations = {
          { icon = "󰌘 ", name = "Restart LSP Server", cmd = "LspRestart" },
          { icon = "󰎟 ", name = "Notifications", cmd = "lua Snacks.picker.notifications()" },
          { icon = " ", name = "Clear Buffers", cmd = "%bd|e#" },
          { icon = " ", name = "Command History", cmd = "lua Snacks.picker.command_history()" },
        }

        -- Create display items for vim.ui.select
        local display_items = {}
        for _, op in ipairs(utility_operations) do
          table.insert(display_items, op.icon .. " " .. op.name)
        end

        vim.ui.select(display_items, {
          prompt = "󱧕 Utilities",
          format_item = function(item)
            return item
          end,
        }, function(choice, idx)
          if not choice or not idx then
            return
          end

          local selected_op = utility_operations[idx]
          vim.cmd(selected_op.cmd)
        end)
      end,
      desc = "Utilities picker",
    },
  },
}
