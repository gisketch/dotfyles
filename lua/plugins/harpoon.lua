-- Grapple.nvim for quick file navigation (Harpoon alternative)
return {
  "cbochs/grapple.nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons", lazy = true }
  },
  opts = {
    scope = "git", -- Use git repository as scope
    icons = true,
    status = false,
  },
  event = { "BufReadPost", "BufNewFile" },
  cmd = "Grapple",
  keys = {
    -- Add file to grapple (same as your <leader>a for harpoon)
    { "<leader>a", "<cmd>Grapple toggle<cr>", desc = "Add file to grapple" },
    
    -- Toggle grapple menu (same as your <C-e> for harpoon)
    { "<C-e>", "<cmd>Grapple toggle_tags<cr>", desc = "Toggle grapple menu" },
    
    -- Quick navigation to indexed files (1-9) - same as your harpoon setup
    { "<leader>1", "<cmd>Grapple select index=1<cr>", desc = "Grapple file 1" },
    { "<leader>2", "<cmd>Grapple select index=2<cr>", desc = "Grapple file 2" },
    { "<leader>3", "<cmd>Grapple select index=3<cr>", desc = "Grapple file 3" },
    { "<leader>4", "<cmd>Grapple select index=4<cr>", desc = "Grapple file 4" },
    { "<leader>5", "<cmd>Grapple select index=5<cr>", desc = "Grapple file 5" },
    { "<leader>6", "<cmd>Grapple select index=6<cr>", desc = "Grapple file 6" },
    { "<leader>7", "<cmd>Grapple select index=7<cr>", desc = "Grapple file 7" },
    { "<leader>8", "<cmd>Grapple select index=8<cr>", desc = "Grapple file 8" },
    { "<leader>9", "<cmd>Grapple select index=9<cr>", desc = "Grapple file 9" },
    
    -- Navigate to previous & next tagged files (same as your harpoon setup)
    { "<C-S-P>", "<cmd>Grapple cycle_tags prev<cr>", desc = "Previous grapple file" },
    { "<C-S-N>", "<cmd>Grapple cycle_tags next<cr>", desc = "Next grapple file" },
  },
}