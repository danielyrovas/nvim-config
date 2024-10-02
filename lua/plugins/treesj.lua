return {
    "Wansmer/treesj",
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    keys = {
        { "<leader>j", "<cmd>TSJToggle<cr>", desc = "Toggle split/join" },
    },
    opts = {
        use_default_keymaps = false,
        max_join_length = 420,
    },
}
