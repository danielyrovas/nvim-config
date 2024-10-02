local get_icon = require("utils").get_icon
return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    enabled = true,
    opts = {
        preset = "helix",
        icons = {
            group = "",
            separator = get_icon "Separator",
        },
        disable = { filetypes = { "TelescopePrompt" } },
        spec = {
            { "<leader>b", group = "Buffers" },
            { "<leader>f", group = "Find" },
            { "<leader>g", group = "Git" },
            {
                "<leader>l",
                mode = { "n", "v" },
                icon = get_icon("ActiveLSP", 1),
                group = "LSP",
            },
            {
                "<leader>p",
                icon = get_icon("Package", 1),
                group = "Packages",
            },
            { "<leader>r", group = "Firefly" },
            { "<leader>u", group = "UI/UX" },
            {
                "<leader>x",
                icon = get_icon("Diagnostic", 1),
                group = "Trouble",
            },
        },
    },
    keys = {
        {
            "<leader>k?",
            function() require("which-key").show { global = false } end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
