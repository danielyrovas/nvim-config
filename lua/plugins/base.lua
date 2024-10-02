return {
    "nvim-lua/plenary.nvim",
    {
        "cenk1cenk2/jq.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "grapp-dev/nui-components.nvim",
        },
        cmd = { "Jq" },
        enabled = vim.fn.executable "jq" == 1,
        config = function()
            vim.api.nvim_create_user_command(
                "Jq",
                function() require("jq").run { toggle = true } end,
                {}
            )
        end,
    },
}
