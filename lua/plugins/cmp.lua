local format_notify_bool = require("utils").format_notify_bool

return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "f3fora/cmp-spell",
        "hrsh7th/cmp-nvim-lua",
        "lukas-reineke/cmp-rg",
    },
    event = "InsertEnter",
    keys = {
        {
            "<leader>uc",
            function()
                vim.g.cmp_enabled = not vim.g.cmp_enabled
                format_notify_bool("Global completion %s", vim.g.cmp_enabled)
            end,
            desc = "Toggle autocompletion",
        },
        {
            "<leader>uC",
            function()
                local bufnr = 0
                local old_val = vim.b[bufnr].cmp_enabled
                if old_val == nil then old_val = vim.g.cmp_enabled end
                vim.b[bufnr].cmp_enabled = not old_val
                format_notify_bool("Buffer complete %s", vim.b[bufnr].cmp_enabled)
            end,
            desc = "Toggle autocompletion (buffer)",
        },
    },
    init = function() vim.g.cmp_enabled = true end,
    opts = function()
        local cmp = require "cmp"
        local border_opts = {
            border = "rounded",
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        }
        local icons = require("utils").icons
        -- local function has_words_before()
        --     local line, col = (unpack or table.unpack)(
        --         vim.api.nvim_win_get_cursor(0)
        --     )
        --     return col ~= 0
        --         and vim.api
        --                 .nvim_buf_get_lines(0, line - 1, line, true)[1]
        --                 :sub(col, col)
        --                 :match "%s"
        --             == nil
        -- end

        return {
            sources = cmp.config.sources {
                -- { name = "nvim_lsp_signature_help", priority = 2000 },
                { name = "luasnip", priority = 1000 },
                { name = "nvim_lsp", priority = 1000 },
                { name = "nvim_lua", priority = 750 },
                { name = "buffer", priority = 500, keyword_length = 2 },
                { name = "rg", priority = 400, keyword_length = 3 },
                { name = "path", priority = 250 },
                {
                    name = "spell",
                    priority = 250,
                    keyword_length = 5,
                    option = {
                        keep_all_entries = false,
                        enable_in_context = function()
                            return require("cmp.config.context").in_treesitter_capture "spell"
                        end,
                    },
                },
            },
            enabled = function()
                if
                    vim.api.nvim_get_option_value("buftype", { buf = 0 })
                    == "prompt"
                then
                    return false
                end
                if vim.b[0].cmp_enabled == nil then return vim.g.cmp_enabled end
                return vim.b[0].cmp_enabled
            end,
            preselect = cmp.PreselectMode.None,
            snippet = {
                expand = function(args) vim.snippet.expand(args.body) end,
            },
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    vim_item.kind = string.format("%s", icons[vim_item.kind])
                    -- vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
                    vim_item.menu = ({
                        nvim_lsp = "[LSP]",
                        nvim_lua = "[NVIM]",
                        luasnip = "[Snip]",
                        buffer = "[Buf]",
                        rg = "[RG]",
                        path = "[Path]",
                        spell = "[Spell]",
                    })[entry.source.name]
                    return vim_item
                end,
            },
            -- duplicates = {
            --     nvim_lsp = 1,
            --     luasnip = 1,
            --     buffer = 1,
            --     path = 1,
            -- },
            confirm_opts = {
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            },
            window = {
                completion = cmp.config.window.bordered(border_opts),
                documentation = cmp.config.window.bordered(border_opts),
            },
            mapping = {
                ["<C-p>"] = cmp.mapping.select_prev_item {
                    behavior = cmp.SelectBehavior.Insert,
                },
                ["<C-n>"] = cmp.mapping.select_next_item {
                    behavior = cmp.SelectBehavior.Insert,
                },

                ["<C-u>"] = cmp.mapping(
                    cmp.mapping.scroll_docs(-4),
                    { "i", "c" }
                ),
                ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
                ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                ["<C-y>"] = cmp.mapping.confirm { select = true },
                ["<C-e>"] = cmp.mapping {
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                },
                ["<CR>"] = vim.NIL,
                ["<Tab>"] = vim.NIL,
                ["<S-Tab>"] = vim.NIL,
            },
        }
    end,
}
