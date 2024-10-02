return {
    "nat-418/boole.nvim",
    cmd = "Boole",
    keys = {
        {
            "<leader>lt",
            "<cmd>Boole increment<cr>",
            mode = "n",
            desc = "Increment Values",
        },
        {
            "<leader>lT",
            "<cmd>Boole decrement<cr>",
            mode = "n",
            desc = "Decrement Values",
        },
    },
    opts = { mappings = {} },
}
