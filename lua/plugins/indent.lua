return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile", "BufWritePost" },
    opts = {
        scope = {
            enabled = true,
            show_start = false,
            show_end = false,
            highlight = {
                "RainbowDelimiterRed",
                "RainbowDelimiterYellow",
                "RainbowDelimiterBlue",
                "RainbowDelimiterOrange",
                "RainbowDelimiterGreen",
                "RainbowDelimiterViolet",
                "RainbowDelimiterCyan",
            },
        },
        exclude = {
            filetypes = {
                "help",
                "startify",
                "aerial",
                "alpha",
                "dashboard",
                "lazy",
                "neogitstatus",
                "NvimTree",
                "oil",
                "fern",
                "neo-tree",
                "Trouble",
            },
            buftypes = {
                "nofile",
                "terminal",
            },
        },
    },
    config = function(_, opts)
        require("ibl").setup(opts)
        local hooks = require "ibl.hooks"
        hooks.register(
            hooks.type.SCOPE_HIGHLIGHT,
            hooks.builtin.scope_highlight_from_extmark
        )
    end,
}
