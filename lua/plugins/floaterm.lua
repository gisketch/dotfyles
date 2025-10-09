-- Floaterm: Beautiful floating terminal manager
return {
  "nvzone/floaterm",
  dependencies = "nvzone/volt",
  cmd = "FloatermToggle",
  opts = {
    border = false,
    size = { h = 60, w = 70 },
    
    -- Terminal mappings
    mappings = {
      term = function(buf)
        -- Cycle through terminals
        vim.keymap.set({ "n", "t" }, "<C-j>", function()
          require("floaterm.api").cycle_term_bufs("prev")
        end, { buffer = buf, desc = "Previous terminal" })
        
        vim.keymap.set({ "n", "t" }, "<C-k>", function()
          require("floaterm.api").cycle_term_bufs("next")
        end, { buffer = buf, desc = "Next terminal" })
        
        -- Switch to sidebar
        vim.keymap.set({ "n", "t" }, "<C-h>", function()
          -- Switch to sidebar functionality
        end, { buffer = buf, desc = "Switch to sidebar" })
      end,
    },
    
    -- Default terminals
    terminals = {
      { name = "Terminal" },
    },
  },
}