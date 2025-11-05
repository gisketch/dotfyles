-- Movement and editing
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set({ "n", "v" }, "<leader>h", "^")
vim.keymap.set({ "n", "v" }, "<leader>l", "$")
-- use left arrow and right arrow keys instead of h and l
vim.keymap.set({ "n", "v" }, "<leader><Left>", "^")
vim.keymap.set({ "n", "v" }, "<leader><Right>", "$")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Clipboard operations
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Insert mode escape
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Location list navigation
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Command mode paste
-- vim.keymap.set("c", "<C-v>", '<C-r>"')
-- add key paste from system clipboard
-- vim.keymap.set("n", "<leader>pp", 'a<C-r>+<Esc>')


-- Search and replace
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])

-- File permissions
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Source current file
vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)

-- Theme picker
vim.keymap.set("n", "<leader>ct", function()
	_G.ThemeManager.theme_picker()
end, { desc = "Change theme" })

-- macOS clipboard integration
-- change to ctrl shift v instead of D v
vim.api.nvim_set_keymap("", "<C-S-v>", '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-S-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-S-v>", '"+p', { noremap = true, silent = true })

-- Session management
local function save_session()
	local session_name = vim.fn.input("Enter session name: ")
	if session_name ~= "" then
		local cmd = "mksession! ~/.vim/sessions/" .. session_name
		vim.cmd(cmd)
		print("Session saved as: " .. session_name)
	else
		print("No session name provided. Session not saved.")
	end
end

vim.api.nvim_set_keymap("n", "<leader>S", ":lua save_session()<CR>", { noremap = true, silent = true })

-- Terminal mappings
vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

-- Split management
vim.api.nvim_set_keymap("n", "<M-v>", ":vsplit<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<M-s>", ":split<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<M-v>", "<C-\\><C-n>:vsplit<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<M-s>", "<C-\\><C-n>:split<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<D-v>", '<C-\\><C-o>"+p', { noremap = true, silent = true })

-- Window navigation
vim.api.nvim_set_keymap("n", "<C-f>", "<C-w>w", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Left>", "<C-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Down>", "<C-w>j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Up>", "<C-w>k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Right>", "<C-w>l", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-f>", [[<C-\><C-n><C-w>w]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-Left>", [[<C-\><C-n><C-w>h]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-Down>", [[<C-\><C-n><C-w>j]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-Up>", [[<C-\><C-n><C-w>k]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-Right>", [[<C-\><C-n><C-w>l]], { noremap = true, silent = true })

-- Window resizing
vim.api.nvim_set_keymap("n", "<C-S-Left>", ":vertical resize -2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-S-Down>", ":resize +2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-S-Up>", ":resize -2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-S-Right>", ":vertical resize +2<CR>", { noremap = true, silent = true })

-- Buffer management
vim.api.nvim_set_keymap("n", "<M-x>", "ZZ", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<M-x>", [[<C-\><C-n>ZZ]], { noremap = true, silent = true })

-- Tab management
vim.api.nvim_set_keymap("n", "<M-n>", ":tabnew<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-S-l>", ":tabnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-S-h>", ":tabprevious<CR>", { noremap = true, silent = true })

-- Code block utility function
function _G.surround_with_backticks()
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
	local language = vim.fn.input("Enter language: ")
	local surrounded_text = "```" .. language .. "\n" .. table.concat(lines, "\n") .. "\n```"
	local new_lines = {}
	for s in surrounded_text:gmatch("[^\r\n]+") do
		table.insert(new_lines, s)
	end
	vim.api.nvim_buf_set_lines(0, start_pos[2] - 1, end_pos[2], false, new_lines)
end

vim.api.nvim_set_keymap("x", "<leader>cb", ":lua surround_with_backticks()<CR>", { noremap = true, silent = true })
