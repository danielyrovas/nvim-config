local ts_spec = {
    [1] = "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/playground",
    },
    event = { "BufReadPost", "BufNewFile", "BufWritePost" },
    cmd = {
        "TSBufDisable",
        "TSBufEnable",
        "TSBufToggle",
        "TSDisable",
        "TSEnable",
        "TSToggle",
        "TSInstall",
        "TSInstallInfo",
        "TSInstallSync",
        "TSModuleInfo",
        "TSUninstall",
        "TSUpdate",
        "TSUpdateSync",
    },
    build = ":TSUpdate",
    opts = {
        highlight = {
            enable = true,
            disable = function(_, bufnr) return vim.b[bufnr].large_buf end,
        },
        ensure_installed = "all",
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<CR>",
                node_incremental = "<CR>",
                scope_incremental = "\\",
                node_decremental = "<BS>",
            },
        },
        indent = { enable = true },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["ak"] = { query = "@block.outer", desc = "around block" },
                    ["ik"] = { query = "@block.inner", desc = "inside block" },
                    ["ac"] = { query = "@class.outer", desc = "around class" },
                    ["ic"] = { query = "@class.inner", desc = "inside class" },
                    ["a?"] = {
                        query = "@conditional.outer",
                        desc = "around conditional",
                    },
                    ["i?"] = {
                        query = "@conditional.inner",
                        desc = "inside conditional",
                    },
                    ["af"] = {
                        query = "@function.outer",
                        desc = "around function ",
                    },
                    ["if"] = {
                        query = "@function.inner",
                        desc = "inside function ",
                    },
                    ["al"] = { query = "@loop.outer", desc = "around loop" },
                    ["il"] = { query = "@loop.inner", desc = "inside loop" },
                    ["aa"] = {
                        query = "@parameter.outer",
                        desc = "around argument",
                    },
                    ["ia"] = {
                        query = "@parameter.inner",
                        desc = "inside argument",
                    },
                },
            },
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = {
                    ["]k"] = {
                        query = "@block.outer",
                        desc = "Next block start",
                    },
                    ["]f"] = {
                        query = "@function.outer",
                        desc = "Next function start",
                    },
                    ["]a"] = {
                        query = "@parameter.inner",
                        desc = "Next argument start",
                    },
                },
                goto_next_end = {
                    ["]K"] = {
                        query = "@block.outer",
                        desc = "Next block end",
                    },
                    ["]F"] = {
                        query = "@function.outer",
                        desc = "Next function end",
                    },
                    ["]A"] = {
                        query = "@parameter.inner",
                        desc = "Next argument end",
                    },
                },
                goto_previous_start = {
                    ["[k"] = {
                        query = "@block.outer",
                        desc = "Previous block start",
                    },
                    ["[f"] = {
                        query = "@function.outer",
                        desc = "Previous function start",
                    },
                    ["[a"] = {
                        query = "@parameter.inner",
                        desc = "Previous argument start",
                    },
                },
                goto_previous_end = {
                    ["[K"] = {
                        query = "@block.outer",
                        desc = "Previous block end",
                    },
                    ["[F"] = {
                        query = "@function.outer",
                        desc = "Previous function end",
                    },
                    ["[A"] = {
                        query = "@parameter.inner",
                        desc = "Previous argument end",
                    },
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    [">K"] = {
                        query = "@block.outer",
                        desc = "Swap next block",
                    },
                    [">F"] = {
                        query = "@function.outer",
                        desc = "Swap next function",
                    },
                    [">A"] = {
                        query = "@parameter.inner",
                        desc = "Swap next argument",
                    },
                },
                swap_previous = {
                    ["<K"] = {
                        query = "@block.outer",
                        desc = "Swap previous block",
                    },
                    ["<F"] = {
                        query = "@function.outer",
                        desc = "Swap previous function",
                    },
                    ["<A"] = {
                        query = "@parameter.inner",
                        desc = "Swap previous argument",
                    },
                },
            },
        },
    },
    config = function(_, opts)
        vim.filetype.add { extension = { mdx = "mdx" } }
        vim.filetype.add { extension = { http = "http" } }
        vim.treesitter.language.register("markdown", "mdx")
        require("nvim-treesitter.configs").setup(opts)
        require("ts_context_commentstring").setup {
            enable_autocmd = false,
            languages = {
                typescript = "// %s",
            },
        }
    end,
}

-- local get_nix_ts_path = function()
--     local tspath = vim.fn.stdpath "data" .. "/nix/nvim-treesitter"
--     if vim.uv.fs_stat(tspath) then
--         return tspath
--     else
--         return nil
--     end
-- end
-- local nix_ts_path = get_nix_ts_path()
--
-- -- NOTE: uses dir conditionally: if Nix has already installed TS locally
-- if nix_ts_path ~= nil then
--     ts_spec[1] = nil
--     ts_spec.dir = nix_ts_path
-- end

return {
    ts_spec,
    { "nushell/tree-sitter-nu", ft = "nu" },
    {
        "windwp/nvim-ts-autotag",
        enabled = true,
        opts = {},
        ft = { "html", "astro", "jsx" },
    },
}
