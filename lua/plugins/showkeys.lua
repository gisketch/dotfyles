-- Showkeys configuration - displays keypresses on screen
return {
  "nvzone/showkeys",
  lazy = false, -- Load immediately
  opts = {
    timeout = 1,
    maxkeys = 5,
    position = "bottom-right", -- Show keys on bottom right as requested
  },
  config = function(_, opts)
    require("showkeys").setup(opts)
    -- Auto-start showkeys when Neovim loads
    vim.defer_fn(function()
      vim.cmd("ShowkeysToggle")
    end, 100) -- Small delay to ensure everything is loaded
  end,
}