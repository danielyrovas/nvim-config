local utils = require "utils"
local bool2str = utils.bool2str
local format_notify_bool = utils.format_notify_bool
local format_notify = utils.format_notify
local set_mappings = utils.set_mappings

local mappings = {
    -- Stay in indent mode
    { "<S-Tab>", "<gv", mode = "v", desc = "Unindent line" },
    { "<Tab>", ">gv", mode = "v", desc = "Indent line" },
    {
        "<leader>rc",
        "JVyu",
        mode = "v",
        desc = "Copy selection without newlines",
    },

    { "q;", ":q", mode = { "n", "v" } },
    { "q:", ":q", mode = { "n", "v" } },
    { ",", "zA", desc = "Quick toggle folds" },
    { ";", ":", mode = { "n", "v" }, desc = "Easy CMD mode" },
    { ":", ";", mode = { "n", "v" }, desc = "Hard semicolon mode" },
    { "<leader>bm", "<cmd>%s///gn<cr>", desc = "Count Matches" },
    { "<leader>c", "<cmd>bp|bd #<cr>", desc = "Stably delete buffer" },

    -- TODO: extend to arrow keys for Colemak hardware keyboard
    { "j", "v:count == 0 ? 'gj' : 'j'", expr = true, desc = "Move cursor down" },
    { "k", "v:count == 0 ? 'gk' : 'k'", expr = true, desc = "Move cursor up" },
    { "<leader>w", "<cmd>w<cr>", desc = "Save" },
    { "<leader>q", "<cmd>confirm qa<cr>", desc = "Quit" },
    { "<leader>n", "<cmd>enew<cr>", desc = "New File" },
    { "<C-s>", "<cmd>w!<cr>", desc = "Force write" },
    { "<C-c>", "<cmd>%y<cr>", desc = "Copy buffer" },
    { "ygb", "<cmd>%y<cr>", desc = "Copy buffer" },
    { "|", "<cmd>vsplit<cr>", desc = "Vertical Split" },
    { "\\", "<cmd>split<cr>", desc = "Horizontal Split" },
    {
        "<C-h>",
        function() vim.lsp.buf.signature_help() end,
        mode = { "i" },
        desc = "Show LSP signature help",
    },

    -- Toggle various UI or behaviour functionality
    {
        "<leader>ug",
        function()
            if vim.wo.signcolumn ~= "no" then
                vim.wo.signcolumn = "no"
            else
                vim.wo.signcolumn = "yes"
            end
            format_notify("signcolumn=%s", vim.wo.signcolumn)
        end,
        desc = "Toggle signcolumn",
    },
    {
        "<leader>ui",
        function()
            local input_avail, input = pcall(vim.fn.input, "Set indent value: ")
            if input_avail then
                local indent = tonumber(input)
                if not indent or indent <= 0 then return end
                vim.bo.tabstop = indent
                vim.bo.softtabstop = indent
                vim.bo.shiftwidth = indent
                format_notify("indent=%d", indent)
            end
        end,
        desc = "Change indent setting",
    },
    {
        "<leader>ue",
        function()
            vim.bo.expandtab = not vim.bo.expandtab
            vim.notify(vim.bo.expandtab and "expandtab" or "noexpandtab")
        end,
        desc = "Toggle expandtab",
    },
    {
        "<leader>ul",
        function()
            local laststatus = vim.opt.laststatus:get()
            local status
            if laststatus == 0 then
                vim.opt.laststatus = 2
                status = "local"
            elseif laststatus == 2 then
                vim.opt.laststatus = 3
                status = "global"
            elseif laststatus == 3 then
                vim.opt.laststatus = 0
                status = "off"
            end
            format_notify("statusline %s", status)
        end,
        desc = "Toggle statusline",
    },
    {
        "<leader>us",
        function()
            vim.wo.spell = not vim.wo.spell
            format_notify_bool("spell %s", vim.wo.spell)
        end,
        desc = "Toggle spellcheck",
    },
    {
        "<leader>uS",
        function()
            vim.opt.conceallevel = vim.opt.conceallevel:get() == 0 and 2 or 0
            format_notify_bool("conceal %s", vim.opt.conceallevel:get() == 2)
        end,
        desc = "Toggle conceal",
    },
    {
        "<leader>ut",
        function()
            vim.opt.showtabline = vim.opt.showtabline:get() == 0 and 2 or 0
            format_notify_bool("tabline %s", vim.opt.showtabline:get() == 2)
        end,
        desc = "Toggle tabline",
    },
    {
        "<leader>uw",
        function()
            vim.wo.wrap = not vim.wo.wrap
            format_notify_bool("wrap %s", vim.wo.wrap)
        end,
        desc = "Toggle wrap",
    },
    {
        "<leader>un",
        function()
            local number = vim.wo.number
            local relativenumber = vim.wo.relativenumber
            if not number and not relativenumber then
                vim.wo.number = true
            elseif number and not relativenumber then
                vim.wo.relativenumber = true
            elseif number and relativenumber then
                vim.wo.number = false
            else
                vim.wo.relativenumber = false
            end
            vim.notify(
                string.format(
                    "number %s, relativenumber %s",
                    bool2str(vim.wo.number),
                    bool2str(vim.wo.relativenumber)
                )
            )
        end,
        desc = "Change line numbering",
    },
    {
        "<leader>uh",
        function()
            if vim.wo.foldcolumn ~= "0" then
                vim.wo.foldcolumn = "0"
            else
                vim.wo.foldcolumn = "1"
            end
        end,
        desc = "Toggle foldcolumn",
    },
    {
        "<leader>up",
        function()
            vim.opt.paste = not vim.opt.paste:get()
            format_notify_bool("paste %s", vim.opt.paste:get())
        end,
        desc = "Toggle paste mode",
    },
    {
        "<leader>uL",
        function()
            vim.g.codelens_enabled = not vim.g.codelens_enabled
            if not vim.g.codelens_enabled then vim.lsp.codelens.clear() end
            format_notify_bool("CodeLens %s", vim.g.codelens_enabled)
        end,
        desc = "Toggle CodeLens",
    },

    -- Firefly Script mappings
    {
        "<leader>rr",
        "<cmd>%s/\\.tmp-/\\/tmp\\/<cr><cmd>%s/puts/logger.info<cr>",
        desc = "set for firefly",
    },
    {
        "<leader>ri",
        "<cmd>%s/\\/tmp\\//\\.tmp-/<cr><cmd>%s/logger.info/puts<cr>",
        desc = "set for local (from info)",
    },
    {
        "<leader>rp",
        "<cmd>%s/\\.tmp-/\\/tmp\\/<cr><cmd>%s/puts/logger.debug<cr>",
        desc = "set for firefly (to debug)",
    },
    {
        "<leader>rd",
        "<cmd>%s/\\/tmp\\//\\.tmp-/<cr><cmd>%s/logger.debug/puts<cr>",
        desc = "set for local (from debug)",
    },
    { "<leader>rc", "vipJVyu", desc = "Copy paragraph without newlines" },
    { "<leader>rb", "GVggJVyu", desc = "Copy buffer without newlines" },

    -- TODO: fix these keymaps or use smart-splits
    { "<C-h>", "<C-w>h", desc = "Move to left split" },
    { "<C-j>", "<C-w>j", desc = "Move to below split" },
    { "<C-k>", "<C-w>k", desc = "Move to above split" },
    { "<C-l>", "<C-w>l", desc = "Move to right split" },
    { "<C-Up>", "<cmd>resize -2<CR>", desc = "Resize split up" },
    { "<C-Down>", "<cmd>resize +2<CR>", desc = "Resize split down" },
    { "<C-Left>", "<cmd>vertical resize -2<CR>", desc = "Resize split left" },
    { "<C-Right>", "<cmd>vertical resize +2<CR>", desc = "Resize split right" },
}

set_mappings(mappings)
-- Smart Splits
-- if is_available "smart-splits.nvim" then
--     maps.n["<C-h>"] = {
--         function() require("smart-splits").move_cursor_left() end,
--         desc = "Move to left split",
--     }
--     maps.n["<C-j>"] = {
--         function() require("smart-splits").move_cursor_down() end,
--         desc = "Move to below split",
--     }
--     maps.n["<C-k>"] = {
--         function() require("smart-splits").move_cursor_up() end,
--         desc = "Move to above split",
--     }
--     maps.n["<C-l>"] = {
--         function() require("smart-splits").move_cursor_right() end,
--         desc = "Move to right split",
--     }
--     maps.n["<C-Up>"] = {
--         function() require("smart-splits").resize_up() end,
--         desc = "Resize split up",
--     }
--     maps.n["<C-Down>"] = {
--         function() require("smart-splits").resize_down() end,
--         desc = "Resize split down",
--     }
--     maps.n["<C-Left>"] = {
--         function() require("smart-splits").resize_left() end,
--         desc = "Resize split left",
--     }
--     maps.n["<C-Right>"] = {
--         function() require("smart-splits").resize_right() end,
--         desc = "Resize split right",
--     }
