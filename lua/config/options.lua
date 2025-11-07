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
vim.opt.cursorline = true

-- Terminal shell configuration (Windows only)
if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
    vim.opt.shell = 'powershell.exe'
    vim.opt.shellcmdflag = '-Command'
    vim.opt.shellquote = ''
    vim.opt.shellxquote = ''
end

vim.opt.ignorecase = true

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
-- vim.opt.numberwidth = 8

-- Miscellaneous
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50

-- Custom commands
vim.cmd([[command! -nargs=0 Stringify :%s/"/\\"/g | %s/\n//g]])

if vim.g.neovide then
    vim.o.guifont = "JetBrainsMonoNL Nerd Font Propo:h12"
    -- vim.g.neovide_scale_factor = 1.4
    vim.opt.linespace = 3

    -- Neovide title colors are now managed by the theme system
    -- See lua/plugins/colorscheme.lua for theme-specific color configurations

    vim.g.neovide_padding_top = 2
    vim.g.neovide_padding_bottom = 2
    vim.g.neovide_padding_right = 2
    vim.g.neovide_padding_left = 2

    -- vim.g.neovide_floating_corner_radius = 0.5

    vim.g.neovide_floating_shadow = true
    vim.g.neovide_floating_z_height = 15
    vim.g.neovide_light_angle_degrees = 45
    vim.g.neovide_light_radius = 20

    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_remember_window_size = true

    vim.g.neovide_cursor_animation_length = 0.05
    vim.g.neovide_cursor_trail_size = 0.05

    vim.g.neovide_scroll_animation_length = 0.05
end

-- highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	pattern = "*",
	desc = "highlight selection on yank",
	callback = function()
		vim.highlight.on_yank({ timeout = 200, visual = true })
	end,
})

-- restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.api.nvim_win_set_cursor(0, mark)
			-- defer centering slightly so it's applied after render
			vim.schedule(function()
				vim.cmd("normal! zz")
			end)
		end
	end,
})

-- open help in vertical split
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	command = "wincmd L",
})

-- auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd("VimResized", {
	command = "wincmd =",
})

-- no auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("no_auto_comment", {}),
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- syntax highlighting for dotenv files
vim.api.nvim_create_autocmd("BufRead", {
	group = vim.api.nvim_create_augroup("dotenv_ft", { clear = true }),
	pattern = { ".env", ".env.*" },
	callback = function()
		vim.bo.filetype = "dosini"
	end,
})

-- ide like highlight when stopping cursor
vim.api.nvim_create_autocmd("CursorMoved", {
	group = vim.api.nvim_create_augroup("LspReferenceHighlight", { clear = true }),
	desc = "Highlight references under cursor",
	callback = function()
		-- Only run if the cursor is not in insert mode
		if vim.fn.mode() ~= "i" then
			local clients = vim.lsp.get_clients({ bufnr = 0 })
			local supports_highlight = false
			for _, client in ipairs(clients) do
				if client.server_capabilities.documentHighlightProvider then
					supports_highlight = true
					break -- Found a supporting client, no need to check others
				end
			end

			-- 3. Proceed only if an LSP is active AND supports the feature
			if supports_highlight then
				vim.lsp.buf.clear_references()
				vim.lsp.buf.document_highlight()
			end
		end
	end,
})

-- ide like highlight when stopping cursor
vim.api.nvim_create_autocmd("CursorMovedI", {
	group = "LspReferenceHighlight",
	desc = "Clear highlights when entering insert mode",
	callback = function()
		vim.lsp.buf.clear_references()
	end,
})
