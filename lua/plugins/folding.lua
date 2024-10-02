return {
    "kevinhwang91/nvim-ufo",
    enabled = true,
    -- event = { "VeryLazy" },
    event = { "InsertEnter", "BufReadPost", "BufNewFile", "BufWritePost" },
    keys = {
        {
            "zR",
            function() require("ufo").openAllFolds() end,
            desc = "Open all folds",
        },
        {
            "zM",
            function() require("ufo").closeAllFolds() end,
            desc = "Close all folds",
        },
        {
            "zr",
            function() require("ufo").openFoldsExceptKinds() end,
            desc = "Fold less",
        },
        {
            "zm",
            function() require("ufo").closeFoldsWith() end,
            desc = "Fold more",
        },
        {
            "zp",
            function() require("ufo").peekFoldedLinesUnderCursor() end,
            desc = "Peek fold",
        },
    },
    dependencies = {
        "kevinhwang91/promise-async",
        { "OXY2DEV/foldtext.nvim", enabled = false },
        {
            "chrisgrieser/nvim-origami",
            event = "BufReadPost", -- later or on keypress would prevent saving folds
            enabled = false,
            opts = {},
        },
    },
    opts = {
        open_fold_hl_timeout = 400,
        close_fold_kinds_for_ft = { default = { "imports" } },
        preview = {
            win_config = {
                border = { "", "─", "", "", "", "─", "", "" },
                winblend = 0,
            },
            mappings = {
                scrollB = "<C-b>",
                scrollF = "<C-f>",
                scrollU = "<C-u>",
                scrollD = "<C-d>",
                jumpTop = "[",
                jumpBot = "]",
            },
        },
        provider_selector = function(_, filetype, buftype)
            local function handleFallbackException(bufnr, err, providerName)
                if type(err) == "string" and err:match "UfoFallbackException" then
                    return require("ufo").getFolds(bufnr, providerName)
                else
                    return require("promise").reject(err)
                end
            end

            return (filetype == "" or buftype == "nofile") and "indent" -- only use indent until a file is opened
                or function(bufnr)
                    return require("ufo")
                        .getFolds(bufnr, "lsp")
                        :catch(
                            function(err)
                                return handleFallbackException(
                                    bufnr,
                                    err,
                                    "treesitter"
                                )
                            end
                        )
                        :catch(
                            function(err)
                                return handleFallbackException(
                                    bufnr,
                                    err,
                                    "indent"
                                )
                            end
                        )
                end
        end,
    },
}
