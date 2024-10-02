return {
    {
        "rebelot/heirline.nvim",
        dependencies = { "Zeioth/heirline-components.nvim" },
        enabled = false,
        event = "VeryLazy",
        config = function()
            local heirline = require "heirline"
            local opts = function() require("config.status").opts() end
            local heirline_components = require "heirline-components.all"

            -- Setup
            heirline_components.init.subscribe_to_events()
            heirline.load_colors(heirline_components.hl.get_colors())
            heirline.setup(opts)
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        enabled = true,
        opts = {
            -- function()
            -- require "lualine"
            options = {
                theme = "palenight",
                globalstatus = true,
                disabled_filetypes = {
                    statusline = { "dashboard", "alpha", "ministarter" },
                },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch" },
                lualine_c = {
                        -- stylua: ignore
                        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                    "filename",
                },
                lualine_x = {
                    -- { function() require "config.status.codecompanion" end },
                },
            },
        },
        event = "VimEnter",
    },
}
