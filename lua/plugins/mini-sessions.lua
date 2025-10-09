-- Mini.sessions for session management
return {
  "nvim-mini/mini.sessions",
  version = false,
  config = function()
    local sessions = require('mini.sessions')
    
    -- Cross-platform session directory
    local session_dir
    if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
      -- Windows
      session_dir = vim.fn.expand('$LOCALAPPDATA/nvim-sessions')
    else
      -- macOS and Linux
      session_dir = vim.fn.expand('~/.local/share/nvim-sessions')
    end
    
    -- Create directory if it doesn't exist
    vim.fn.mkdir(session_dir, 'p')
    
    sessions.setup({
      -- Whether to read default session if Neovim opened without file arguments
      autoread = false,

      -- Whether to write currently read session before leaving it
      autowrite = true,

      -- Directory where global sessions are stored
      directory = session_dir,

      -- File for local session (use '' to disable)
      file = 'Session.vim',

      -- Whether to force possibly harmful actions
      force = { read = false, write = true, delete = false },

      -- Hook functions for actions
      hooks = {
        -- Before successful action
        pre = { read = nil, write = nil, delete = nil },
        -- After successful action
        post = { read = nil, write = nil, delete = nil },
      },

      -- Whether to print session path after action
      verbose = { read = false, write = true, delete = true },
    })

    -- Helper function to get session list for dashboard
    _G.get_session_list = function()
      local session_files = vim.fn.glob(session_dir .. '/*', false, true)
      local sessions_list = {}
      
      for _, file in ipairs(session_files) do
        local name = vim.fn.fnamemodify(file, ':t:r')
        local mtime = vim.fn.getftime(file)
        table.insert(sessions_list, {
          name = name,
          file = file,
          mtime = mtime,
        })
      end
      
      -- Sort by modification time (newest first)
      table.sort(sessions_list, function(a, b)
        return a.mtime > b.mtime
      end)
      
      -- Limit to 10 sessions
      local limited_sessions = {}
      for i = 1, math.min(10, #sessions_list) do
        table.insert(limited_sessions, sessions_list[i])
      end
      
      return limited_sessions
    end

    -- Helper function to save session with input
    _G.save_session_with_input = function()
      vim.ui.input({ prompt = 'Session name: ' }, function(name)
        if name and name ~= '' then
          sessions.write(name)
        end
      end)
    end

    -- Helper function to delete session with picker
    _G.delete_session_with_picker = function()
      local session_list = _G.get_session_list()
      if #session_list == 0 then
        vim.notify('No sessions found', vim.log.levels.INFO)
        return
      end
      
      local items = {}
      for _, session in ipairs(session_list) do
        table.insert(items, session.name)
      end
      
      vim.ui.select(items, {
        prompt = 'Delete session: ',
      }, function(choice)
        if choice then
          sessions.delete(choice, { force = true })
        end
      end)
    end
  end,
  keys = {
    {
      "<leader>ss",
      function()
        _G.save_session_with_input()
      end,
      desc = "Save Session",
    },
    {
      "<leader>sd",
      function()
        _G.delete_session_with_picker()
      end,
      desc = "Delete Session",
    },
  },
}