return {
    {
        "j-hui/fidget.nvim",
        event = "VeryLazy",
        opts = {
            notification = {
                window = { winblend = 0 },
                override_vim_notify = true,
            },
        },
    },
    {
        "stevearc/dressing.nvim",
        init = function()
            vim.ui.select = function(...)
                require("lazy").load { plugins = { "dressing.nvim" } }
                return vim.ui.select(...)
            end
            vim.ui.input = function(...)
                require("lazy").load { plugins = { "dressing.nvim" } }
                return vim.ui.input(...)
            end
        end,
        opts = {
            input = {
                insert_only = false,
                win_options = { winblend = 0 },
                mappings = {
                    n = {
                        ["<Esc>"] = "Close",
                        ["<CR>"] = "Confirm",
                    },
                    i = {
                        ["<CR>"] = "Confirm",
                        ["<C-u>"] = "HistoryPrev",
                        ["<C-e>"] = "HistoryNext",
                    },
                },
            },
        },
    },
    {
        "hiphish/rainbow-delimiters.nvim",
        event = "VeryLazy", -- { "BufReadPost", "BufNewFile", "BufWritePost" },
    },
    {
        "gelguy/wilder.nvim",
        event = "VeryLazy",
        config = function()
            local wilder = require "wilder"
            -- also override search with popup prompt { ":" "/", "?" }
            wilder.setup { modes = { ":" } }
            wilder.set_option(
                "renderer",
                wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
                    highlights = { border = "Normal" },
                    border = "rounded",
                })
            )
        end,
    },
}
