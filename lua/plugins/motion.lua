return {
    {
        "ggandor/flit.nvim",
        keys = function()
            local ret = {}
            for _, key in ipairs { "f", "F", "t", "T" } do
                ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
            end
            return ret
        end,
        opts = { multiline = false, labeled_modes = "nxo" },
        dependencies = {
            "ggandor/leap.nvim",
            keys = {
                { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
                { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
                { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
            },
            config = function(_, opts)
                local leap = require "leap"
                for k, v in pairs(opts) do
                    leap.opts[k] = v
                end
                leap.add_default_mappings(true)
            end,
            dependencies = { "tpope/vim-repeat" },
        },
    },
    {
        "chrisgrieser/nvim-spider",
        enabled = false,
        -- stylua: ignore
        keys = {
            { "e", "<cmd>lua require('spider').motion('e')<cr>", mode = { "n", "o", "x" }, desc = "Spider e" },
            { "w", "<cmd>lua require('spider').motion('w')<cr>", mode = { "n", "o", "x" }, desc = "Spider w" },
            { "b", "<cmd>lua require('spider').motion('b')<cr>", mode = { "n", "o", "x" }, desc = "Spider b" },
        },
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        enabled = false,
        opts = {},
        -- stylua: ignore
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
    },
}
