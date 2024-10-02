return {
    {
        "Darazaki/indent-o-matic",
        event = { "BufReadPre", "BufNewFile" },
        cmd = "IndentOMatic",
        opts = {},
    },
    {
        "nmac427/guess-indent.nvim",
        enabled = false,
        cmd = "GuessIndent",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("guess-indent").setup()
            vim.api.nvim_create_autocmd({ "BufReadPost" }, {
                callback = function() vim.cmd "silent GuessIndent" end,
            })
        end,
    },
}
