return {
    { "MagicDuck/grug-far.nvim", opts = {}, cmd = "GrugFar" },
    {
        "chrisgrieser/nvim-rip-substitute",
        enabled = false,
        cmd = "RipSubstitute",
        opts = {},
        keys = {
            {
                "<leader>fs",
                function() require("rip-substitute").sub() end,
                mode = { "n", "x" },
                desc = " rip substitute",
            },
        },
    },
}
