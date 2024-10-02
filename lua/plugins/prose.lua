return {
    -- TODO: setup quartz to serve markdown files in a obsidian like
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            pipe_table = {
                style = "normal",
                -- cell = "raw",
            },
            checkbox = {
                -- position = "overlay",
                -- unchecked = { icon = "✘ " },
                -- checked = { icon = "✔ " },
                -- todo = { icon = "◯ " },
                -- custom = { todo = { rendered = "◯ " } },
            },
        },
        ft = "markdown",
    },
    {
        "Kicamon/markdown-table-mode.nvim",
        ft = "markdown",
        opts = {},
    },
    {
        "OXY2DEV/helpview.nvim",
        ft = "help",
    },
}
