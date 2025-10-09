-- Snacks.nvim with dashboard and utilities
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    dependencies = { "nvim-mini/mini.sessions" },
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        notifier = {
            enabled = true,
            timeout = 3000,
            style = "compact", -- Use compact style for cleaner look
        },
        quickfile = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        input = {
            icon = " ",
            icon_hl = "SnacksInputIcon",
            icon_pos = "left",
            prompt_pos = "title",
            win = { style = "input" },
            expand = true,
        },
        styles = {
            notification = {
                border = "none", -- Remove borders completely
                wo = { 
                    wrap = true,
                    winblend = 0, -- Remove transparency
                }
            },
            notification_history = {
                border = "none", -- Remove borders completely
                zindex = 100,
                width = 0.6,
                height = 0.6,
                minimal = false,
                title = " Notification History ",
                title_pos = "center",
                ft = "markdown",
                bo = { filetype = "snacks_notif_history", modifiable = false },
                wo = { 
                    winhighlight = "Normal:SnacksNotifierHistory",
                    winblend = 0, -- Remove transparency
                },
                keys = { q = "close" },
            },
            input = {
                backdrop = false,
                position = "float",
                border = "rounded", -- No borders as requested
                title_pos = "center",
                height = 1,
                width = 60,
                relative = "editor",
                noautocmd = true,
                row = 2,
                wo = {
                    winhighlight = "NormalFloat:SnacksInputNormal,FloatBorder:SnacksInputBorder,FloatTitle:SnacksInputTitle",
                    cursorline = false,
                },
                bo = {
                    filetype = "snacks_input",
                    buftype = "prompt",
                },
                b = {
                    completion = false, -- disable blink completions in input
                },
                keys = {
                    n_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "n", expr = true },
                    i_esc = { "<esc>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
                    i_cr = { "<cr>", { "cmp_accept", "confirm" }, mode = { "i", "n" }, expr = true },
                    i_tab = { "<tab>", { "cmp_select_next", "cmp" }, mode = "i", expr = true },
                    i_ctrl_w = { "<c-w>", "<c-s-w>", mode = "i", expr = true },
                    i_up = { "<up>", { "hist_up" }, mode = { "i", "n" } },
                    i_down = { "<down>", { "hist_down" }, mode = { "i", "n" } },
                    q = "cancel",
                },
            }
        },
        dashboard = {
            enabled = true,
            width = 60,
            row = nil, -- center
            col = nil, -- center
            pane_gap = 4,
            autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",

            -- Use telescope for all picker operations
            preset = {
                pick = function(cmd, opts)
                    -- Use telescope for all operations
                    if cmd == 'files' then
                        if opts and opts.cwd then
                            require("telescope.builtin").find_files({ cwd = opts.cwd })
                        else
                            require("telescope.builtin").find_files()
                        end
                    elseif cmd == 'live_grep' then
                        require("telescope.builtin").live_grep()
                    elseif cmd == 'oldfiles' then
                        require("telescope.builtin").oldfiles()
                    else
                        -- Fallback to telescope's generic picker for other commands
                        local telescope_builtin = require("telescope.builtin")
                        if telescope_builtin[cmd] then
                            telescope_builtin[cmd](opts)
                        else
                            vim.notify("Unknown picker command: " .. cmd, vim.log.levels.WARN)
                        end
                    end
                end,

                -- Custom header
                header = [[
⢦⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⡤
⠘⣿⣿⣿⣷⣦⣄⣀⠀⢠⠔⠀⢀⡼⠿⠿⢆⠀⠀⠲⣄⠀⣀⣠⣴⣾⣿⣿⣿⠇
⠀⠈⠉⠉⠛⠛⠻⠿⢿⣿⠀⢀⣾⣷⡀⢀⣾⣷⡀⠀⣿⡿⠿⠿⠛⠛⠉⠉⠁⠀
⠀⠀⣤⣤⣶⣶⣶⣶⣶⣿⣆⠈⠉⠉⠉⠉⠉⠉⠉⢠⣿⣶⣶⣶⣶⣶⣤⣤⠀⠀
⠀⠀⠘⣿⡿⠟⠛⠉⣡⣿⣿⣷⣤⠀⢠⣆⠀⣤⣶⣿⣿⣬⡉⠛⠻⠿⣿⠇⠀⠀
⠀⠀⠀⠀⠀⢀⣴⣿⡿⢋⣿⣿⠛⢠⣿⣿⡄⠛⢿⣿⡘⢿⣿⣦⣀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠉⠻⠏⠀⣸⣿⡇⢀⠻⣿⣿⠟⣀⠸⣿⣇⠀⠙⠟⠋⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢠⡟⠁⣿⣿⠀⠻⣆⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠘⢟⠉⠙⠓⠀⠘⠏⠀⠘⠟⠉⡻⠋⠀⠀⠀⠀⠀⠀⠀⠀
        ]],

                -- Custom keymaps for the dashboard
                keys = {
                    { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                    { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                    { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                    { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                    { icon = " ", key = "e", desc = "Load Session", action = function()
                        -- Use telescope sessions picker instead of custom implementation
                        require('telescope').extensions.sessions_picker.sessions_picker()
                    end },
                    { icon = " ", key = "G", desc = "Git Status", action = ":Git" },
                    { icon = " ", key = "L", desc = "Lazy", action = ":Lazy" },
                    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                },
            },

            -- Dashboard sections
            sections = {
                { section = "header" },
                {
                    pane = 2,
                    section = "terminal",
                    cmd = "pokemon-colorscripts --no-title --name mudkip",
                    height = 10,
                    padding = 1,
                },
                { section = "keys", gap = 1, padding = 1 },
                {
                    pane = 2,
                    icon = " ",
                    title = "Recent Files",
                    section = "recent_files",
                    indent = 2,
                    padding = 1,
                },
                {
                    pane = 2,
                    icon = " ",
                    title = "Projects",
                    section = "projects",
                    indent = 2,
                    padding = 1,
                    limit = 10,
                },
                { section = "startup" },
            },
        },
    },
    keys = {
        {
            "<leader>.",
            function()
                Snacks.dashboard()
            end,
            desc = "Dashboard",
        },
        {
            "<leader>bd",
            function()
                Snacks.bufdelete()
            end,
            desc = "Delete Buffer",
        },
        {
            "<leader>cR",
            function()
                Snacks.rename.rename_file()
            end,
            desc = "Rename File",
        },
        {
            "<leader>gB",
            function()
                Snacks.git.blame_line()
            end,
            desc = "Git Blame Line",
        },
        {
            "<leader>nd",
            function()
                Snacks.notifier.hide()
            end,
            desc = "Hide All Notifications",
        },
        {
            "<leader>un",
            function()
                Snacks.notifier.show_history()
            end,
            desc = "Show Notification History",
        },
        {
            "]]",
            function()
                Snacks.words.jump(vim.v.count1)
            end,
            desc = "Next Reference",
            mode = { "n", "t" },
        },
        {
            "[[",
            function()
                Snacks.words.jump(-vim.v.count1)
            end,
            desc = "Prev Reference",
            mode = { "n", "t" },
        },
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd -- Override print to use snacks for `:=` command

                -- Create some toggle mappings
                Snacks.toggle.option("spell", { name = "spelling" }):map("<leader>us")
                Snacks.toggle.option("wrap", { name = "wrap" }):map("<leader>uw")
                Snacks.toggle.option("relativenumber", { name = "relative number" }):map("<leader>uL")
                Snacks.toggle.diagnostics():map("<leader>ud")
                Snacks.toggle.line_number():map("<leader>ul")
                Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
                Snacks.toggle.treesitter():map("<leader>uT")
                Snacks.toggle.option("background", { off = "light", on = "dark", name = "dark background" }):map("<leader>ub")
                Snacks.toggle.inlay_hints():map("<leader>uh")
            end,
        })
    end,
}

