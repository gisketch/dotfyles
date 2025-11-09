return {
    -- dir = [[F:\devfiles\nvim-plugins\triforce.nvim]],
    "gisketch/triforce.nvim",
    dependencies = {
        'nvzone/volt',
    },
    config = function()
        require('triforce').setup({
            keymap = {
                show_profile = "<leader>tp", -- Set to nil to disable default keymap
            },
        })
    end,
}
