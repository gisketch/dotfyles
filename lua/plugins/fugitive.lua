-- Git integration with vim-fugitive
local function open_git_in_float(cmd, title)
  -- Helper function to open Git commands with terminal output in floating window
  local buf = vim.api.nvim_create_buf(false, true)
  local width = math.floor(vim.o.columns * 0.6)
  local height = math.floor(vim.o.lines * 0.6)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = title,
    title_pos = "center",
  })

  vim.fn.termopen(cmd, {
    on_exit = function(_, exit_code, _)
      if exit_code == 0 then
        vim.defer_fn(function()
          if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
          end
        end, 200)
      end
    end,
  })

  vim.cmd("startinsert")
  vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>close<cr>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, "t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
end

return {
  "tpope/vim-fugitive",
  cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse", "GRemove", "GRename" },
  keys = {
    {
      "<leader>gs",
      function()
        -- Open Git status in a split first
        vim.cmd("Git")

        -- Get the fugitive buffer and window that was just created
        local fugitive_buf = vim.api.nvim_get_current_buf()
        local fugitive_win = vim.api.nvim_get_current_win()

        -- Calculate floating window dimensions (80% of editor size)
        local width = math.floor(vim.o.columns * 0.8)
        local height = math.floor(vim.o.lines * 0.8)
        local row = math.floor((vim.o.lines - height) / 2)
        local col = math.floor((vim.o.columns - width) / 2)

        -- Create floating window with title
        local float_win = vim.api.nvim_open_win(fugitive_buf, true, {
          relative = "editor",
          width = width,
          height = height,
          row = row,
          col = col,
          style = "minimal",
          border = "rounded",
          title = " 󱖫 Git Status ",
          title_pos = "center",
        })

        -- Close the original split window without deleting the buffer
        vim.api.nvim_win_close(fugitive_win, false)

        -- Set window-local options for better UX
        vim.wo[float_win].winblend = 0

        -- Map q to close the floating window
        vim.api.nvim_buf_set_keymap(fugitive_buf, "n", "q", "<cmd>close<cr>", { noremap = true, silent = true })
      end,
      desc = "Git status (floating)",
    },
    { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git diff split" },
    {
      "<leader>gc",
      function()
        -- Open Git commit in a split first
        vim.cmd("Git commit")

        -- Get the commit buffer and window that was just created
        local commit_buf = vim.api.nvim_get_current_buf()
        local commit_win = vim.api.nvim_get_current_win()

        -- Calculate floating window dimensions (70% width, 80% height for commit messages)
        local width = math.floor(vim.o.columns * 0.7)
        local height = math.floor(vim.o.lines * 0.8)
        local row = math.floor((vim.o.lines - height) / 2)
        local col = math.floor((vim.o.columns - width) / 2)

        -- Create floating window with title
        local float_win = vim.api.nvim_open_win(commit_buf, true, {
          relative = "editor",
          width = width,
          height = height,
          row = row,
          col = col,
          style = "minimal",
          border = "rounded",
          title = "  Git Commit ",
          title_pos = "center",
        })

        -- Close the original split window without deleting the buffer
        vim.api.nvim_win_close(commit_win, false)

        -- Set window-local options
        vim.wo[float_win].winblend = 0

        -- Map q to abort commit and close floating window
        vim.api.nvim_buf_set_keymap(commit_buf, "n", "q", "<cmd>cq<cr>", { noremap = true, silent = true })
      end,
      desc = "Git commit (floating)",
    },
    {
      "<leader>ug",
      function()
        -- Git operations with nerd font icons
        local git_operations = {
          { icon = "", name = "Push", cmd = "git push", terminal = true },
          { icon = "", name = "Push (force with lease)", cmd = "git push --force-with-lease", terminal = true },
          { icon = "󰓂", name = "Pull", cmd = "git pull", terminal = true },
          { icon = "", name = "Fetch", cmd = "git fetch", terminal = true },
          { icon = "", name = "Log", cmd = "Git log", terminal = false },
          { icon = "", name = "Stash", cmd = "git stash", terminal = true },
          { icon = "", name = "Amend Commit", cmd = "Git commit --amend", terminal = false },
        }

        -- Create display items for vim.ui.select
        local display_items = {}
        for _, op in ipairs(git_operations) do
          table.insert(display_items, op.icon .. " " .. op.name)
        end

        vim.ui.select(display_items, {
          prompt = '󰊢 Git Operations: ',
          format_item = function(item)
            return item
          end,
        }, function(choice, idx)
          if not choice or not idx then
            return
          end

          local selected_op = git_operations[idx]

          if selected_op.terminal then
            -- Use terminal floating window for operations with live output
            open_git_in_float(selected_op.cmd, " 󰊢 " .. selected_op.name .. " ")
          elseif selected_op.name == "Amend Commit" then
            -- Handle amend commit with floating window
            vim.cmd("Git commit --amend")
            local commit_buf = vim.api.nvim_get_current_buf()
            local commit_win = vim.api.nvim_get_current_win()

            local width = math.floor(vim.o.columns * 0.7)
            local height = math.floor(vim.o.lines * 0.8)
            local row = math.floor((vim.o.lines - height) / 2)
            local col = math.floor((vim.o.columns - width) / 2)

            local float_win = vim.api.nvim_open_win(commit_buf, true, {
              relative = "editor",
              width = width,
              height = height,
              row = row,
              col = col,
              style = "minimal",
              border = "rounded",
              title = "  Git Amend ",
              title_pos = "center",
            })

            vim.api.nvim_win_close(commit_win, false)
            vim.wo[float_win].winblend = 0
            vim.api.nvim_buf_set_keymap(commit_buf, "n", "q", "<cmd>cq<cr>", { noremap = true, silent = true })
          else
            -- Use regular Fugitive command
            vim.cmd(selected_op.cmd)
          end
        end)
      end,
      desc = "Git operations picker",
    },
  },
}
