-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Load configuration
require("config.options")
require("config.keymaps")

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- Import plugins from lua/plugins/ directory
        { import = "plugins" },
    },
    defaults = {
        lazy = false,    -- should plugins be lazy-loaded?
        version = false, -- always use the latest git commit
    },
    install = { colorscheme = { "habamax" } },
    checker = { enabled = true }, -- automatically check for plugin updates
    change_detection = {
        enabled = true,           -- Enable automatic change detection
        notify = true,            -- Get a notification when changes are found
    },
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
