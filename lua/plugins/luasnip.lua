return {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    event = "VeryLazy",
    build = "make install_jsregexp",
    opts = {
        history = true,
        delete_check_events = "TextChanged",
        region_check_events = "CursorMoved",
        store_selection_keys = "<C-x>",
        -- enable_autosnippets = true,
    },
    keys = {
        {
            "<c-l>",
            function()
                return vim.snippet.active { direction = 1 }
                    and vim.snippet.jump(1)
            end,
            mode = { "i", "s" },
            desc = "Luasnip jump next",
        },
        {
            "<c-h>",
            function()
                return vim.snippet.active { direction = -1 }
                    and vim.snippet.jump(-1)
            end,
            mode = { "i", "s" },
            desc = "Luasnip jump previous",
        },
    },
    cmd = { "LuaSnipEdit", "LuaSnipReload" },

    config = function(_, opts)
        local ls = require "luasnip"
        vim.api.nvim_create_user_command(
            "LuaSnipEdit",
            function() require("luasnip.loaders").edit_snippet_files() end,
            {}
        )

        ls.config.setup(opts)

        require("luasnip.loaders.from_vscode").lazy_load {
            exclude = { "lua", "ruby" },
        }

        -- load custom snippets with Lua Loader
        require("luasnip.loaders.from_lua").lazy_load {
            paths = vim.fn.stdpath "config" .. "/lua/snippets",
        }

        -- TJ snippet setup: override native snippet engine with luasnip
        vim.snippet.expand = ls.lsp_expand

        ---@diagnostic disable-next-line: duplicate-set-field
        vim.snippet.active = function(filter)
            filter = filter or {}
            filter.direction = filter.direction or 1

            if filter.direction == 1 then
                return ls.expand_or_jumpable()
            else
                return ls.jumpable(filter.direction)
            end
        end
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.snippet.jump = function(direction)
            if direction == 1 then
                if ls.expandable() then
                    return ls.expand_or_jump()
                else
                    return ls.jumpable(1) and ls.jump(1)
                end
            else
                return ls.jumpable(-1) and ls.jump(-1)
            end
        end

        vim.snippet.stop = ls.unlink_current

        ls.config.set_config {
            history = true,
            updateevents = "TextChanged,TextChangedI",
            override_builtin = true,
        }
    end,
}
