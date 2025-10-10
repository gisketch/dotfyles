-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Hide cmd
vim.opt.cmdheight = 0

-- Autocmds for relative number behavior
vim.cmd [[
    autocmd InsertEnter * :set norelativenumber
]]

vim.cmd [[
    autocmd InsertLeave * :set relativenumber
]]

-- Auto-remove trailing whitespace on save
vim.cmd [[
    autocmd BufWritePre * :%s/\s\+$//e
]]

-- Terminal behavior
vim.cmd [[tnoremap <expr> <C-\><C-\> '<C-\><C-N>"'.nr2char(getchar()).'pi']]

-- Concealment and folding
vim.cmd([[set conceallevel=2]])
vim.cmd([[set nofoldenable]])

-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Line wrapping
vim.opt.wrap = false

-- File handling
vim.opt.swapfile = false
vim.opt.backup = false
-- Cross-platform undo directory
local undodir
if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
    -- Windows
    undodir = vim.fn.expand('$LOCALAPPDATA/nvim-undo')
else
    -- macOS and Linux
    undodir = vim.fn.expand('~/.vim/undodir')
end
vim.fn.mkdir(undodir, 'p')
vim.opt.undodir = undodir
vim.opt.undofile = true

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Appearance
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.fillchars = 'eob: '

-- Miscellaneous
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50

-- Custom commands
vim.cmd([[command! -nargs=0 Stringify :%s/"/\\"/g | %s/\n//g]])
