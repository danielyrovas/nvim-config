local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local namespace = vim.api.nvim_create_namespace
autocmd("TextYankPost", {
    desc = "Highlight yanked text",
    group = augroup("yank_highlight", { clear = true }),
    pattern = "*",
    callback = function() vim.highlight.on_yank() end,
})

autocmd("FileType", {
    pattern = { "gitcommit", "markdown", "text", "plaintex" },
    group = augroup("auto_spell", { clear = true }),
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

vim.on_key(function(char)
    if vim.fn.mode() == "n" then
        local new_hlsearch = vim.tbl_contains(
            { "<CR>", "n", "N", "*", "#", "?", "/" },
            vim.fn.keytrans(char)
        )
        if vim.opt.hlsearch:get() ~= new_hlsearch then
            vim.opt.hlsearch = new_hlsearch
        end
    end
end, namespace "auto_hlsearch")

-- TODO: fix
autocmd("BufReadPre", {
    desc = "Disable certain functionality on very large files",
    group = augroup("large_buf", { clear = true }),
    callback = function(args)
        local ok, stats =
            pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
        vim.b[args.buf].large_buf = (
            ok
            and stats
            and stats.size > vim.g.max_file.size
        )
            or vim.api.nvim_buf_line_count(args.buf) > vim.g.max_file.lines
    end,
})

autocmd("BufWinEnter", {
    desc = "Make q close help, man, quickfix, dap floats",
    group = augroup("q_close_windows", { clear = true }),
    callback = function(args)
        local q_close_windows = { "help", "nofile", "quickfix" }
        local buftype =
            vim.api.nvim_get_option_value("buftype", { buf = args.buf })
        if
            vim.tbl_contains(q_close_windows, buftype)
            and vim.fn.maparg("q", "n") == ""
        then
            vim.keymap.set("n", "q", "<cmd>close<cr>", {
                desc = "Close window",
                buffer = args.buf,
                silent = true,
                nowait = true,
            })
        end
    end,
})
