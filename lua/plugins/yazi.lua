return {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    enabled = vim.fn.executable "yazi" == 1,
    keys = {
        {
            "-",
            "<cmd>Yazi<cr>",
            desc = "Open yazi at the current file",
        },
        {
            "_",
            "<cmd>Yazi cwd<cr>",
            desc = "Open the file manager in nvim's working directory",
        },
        {
            "<leader>-",
            "<cmd>Yazi toggle<cr>",
            desc = "Resume the last yazi session",
        },
    },
    opts = {
        open_for_directories = true,
        keymaps = { show_help = "<f1>" },
        open_multiple_tabs = false,
    },
}
