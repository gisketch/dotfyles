-- Git integration for buffers
return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "󰍵" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "│" },
    },
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    watch_gitdir = {
      follow_files = true
    },
    auto_attach = true,
    attach_to_untracked = false,
    current_line_blame = false,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol',
      delay = 1000,
      ignore_whitespace = false,
      virt_text_priority = 100,
      use_focus = true,
    },
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil,
    max_file_length = 40000,
    preview_config = {
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1
    },
  },
  keys = {
    -- Navigation
    { "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({']c', bang = true})
        else
          require('gitsigns').nav_hunk('next')
        end
      end, desc = "Next git hunk" },
    { "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({'[c', bang = true})
        else
          require('gitsigns').nav_hunk('prev')
        end
      end, desc = "Previous git hunk" },

    -- Actions
    { "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage hunk" },
    { "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset hunk" },
    { "<leader>hS", "<cmd>Gitsigns stage_buffer<cr>", desc = "Stage buffer" },
    { "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Undo stage hunk" },
    { "<leader>hR", "<cmd>Gitsigns reset_buffer<cr>", desc = "Reset buffer" },
    { "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview hunk" },
    { "<leader>hb", function() require('gitsigns').blame_line{full=true} end, desc = "Blame line" },
    -- { "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle line blame" },
    { "<leader>hd", "<cmd>Gitsigns diffthis<cr>", desc = "Diff this" },
    { "<leader>hD", function() require('gitsigns').diffthis('~') end, desc = "Diff this ~" },
    -- { "<leader>td", "<cmd>Gitsigns toggle_deleted<cr>", desc = "Toggle deleted" },

    -- Text object
    { "ih", ":<C-U>Gitsigns select_hunk<CR>", mode = {"o", "x"}, desc = "Select hunk" },
  },
}
