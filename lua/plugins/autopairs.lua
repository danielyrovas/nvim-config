return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
        fast_wrap = {},
    },
    init = function() vim.g.autopairs_enabled = true end,
    --     check_ts = true,
    --     ts_config = { java = false },
    --     fast_wrap = {
    --         map = "<M-e>",
    --         chars = { "{", "[", "(", '"', "'" },
    --         pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
    --         offset = 0,
    --         end_key = "$",
    --         keys = "qwertyuiopzxcvbnmasdfghjkl",
    --         check_comma = true,
    --         highlight = "PmenuSel",
    --         highlight_grey = "LineNr",
    --     },
    -- },
}
