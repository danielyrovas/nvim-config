return {
    -- NOTE: choose between snipe or rabbit
    {
        "voxelprismatic/rabbit.nvim",
        enabled = false,
        keys = { { "<leader>H", desc = "Rabbit Buffers" } },
        opts = {
            default_keys = {
                close = { "<Esc>", "q", "<leader>" },
                open = { "<leader>h" },
            },
        },
    },
    {
        "leath-dub/snipe.nvim",
        enabled = true,
        keys = {
            {
                "<leader>h",
                function() require("snipe").open_buffer_menu() end,
                desc = "Open Snipe buffer menu",
            },
        },
        opts = {},
    },
}
