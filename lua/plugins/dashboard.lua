return {
    -- "nvimdev/dashboard-nvim",
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
        require("alpha").setup(require("alpha.themes.startify").config)
    end,
}
