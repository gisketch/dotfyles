-- Leap motion plugin for fast navigation
return {
  "ggandor/leap.nvim",
  dependencies = { "tpope/vim-repeat" },
  config = function()
    -- Set up keymaps
    vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap-forward)')
    vim.keymap.set({'n', 'x', 'o'}, 'S', '<Plug>(leap-backward)')
    vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)')
    
    -- Recommended tweaks for better experience
    -- Exclude whitespace and the middle of alphabetic words from preview
    require('leap').opts.preview_filter = function(ch0, ch1, ch2)
      return not (
        ch1:match('%s') or
        ch0:match('%a') and ch1:match('%a') and ch2:match('%a')
      )
    end
    
    -- Define equivalence classes for brackets and quotes
    require('leap').opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }
    
    -- Use traversal keys to repeat previous motion
    require('leap.user').set_repeat_keys('<enter>', '<backspace>')
  end,
}