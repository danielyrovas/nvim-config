return {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    keys = {
        { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "TODOs" },
        { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },
    },
    opts = {
        highlight = {
            multiline = false,
            after = "",
        },
        search = {
            command = "rg",
            args = {
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
                "--no-messages",
                "--follow",
            },
        },
    },
    config = function(_, opts)
        require("todo-comments").setup(opts)
        require("telescope").load_extension "todo-comments"
    end,
}
