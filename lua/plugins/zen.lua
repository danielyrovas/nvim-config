return {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
    opts = {
        window = {
            options = {
                signcolumn = "no",
                cursorline = false,
                number = false,
                foldcolumn = "0",
            },
        },
        plugins = {
            options = {
                laststatus = 3,
                ruler = false,
            },
            todo = { enabled = true },
        },
        on_open = function(_)
            -- vim.cmd "IBLDisable"
            if require("utils").is_available "fidget.nvim" then
                require("fidget").notification.suppress(true)
            end
            if require("utils").is_available "lualine.nvim" then
                vim.o.laststatus = 2
                require("lualine").hide()
            end
        end,
        on_close = function()
            -- vim.cmd "IBLEnable"
            if require("utils").is_available "fidget.nvim" then
                require("fidget").notification.suppress(false)
            end
            if require("utils").is_available "lualine.nvim" then
                vim.o.laststatus = 3
                require("lualine").hide { unhide = true }
            end
        end,
    },
}
