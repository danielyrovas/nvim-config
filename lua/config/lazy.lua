local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    -- stylua: ignore
    local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath, }
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
    vim.notify "Could not load lazy.nvim, no plugins will be loaded."
    return
end

lazy.setup {
    spec = { { import = "plugins" } },
    defaults = { lazy = true, version = false },
    rocks = { enabled = false },
    change_detection = { enabled = false },
    install = { colorscheme = { "default" } },
    performance = {
        cache = { enabled = true },
        reset_packpath = true, -- reset the package path to improve startup time
        rtp = {
            reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
            paths = {}, -- add any custom paths here that you want to include in the rtp
            disabled_plugins = {
                "2html_plugin",
                "tohtml",
                "getscript",
                "getscriptPlugin",
                "gzip",
                "logipat",
                "netrw",
                "netrwPlugin",
                "netrwSettings",
                "netrwFileHandlers",
                "matchit",
                "tar",
                "tarPlugin",
                "zip",
                "zipPlugin",
                "tutor",
                "rplugin",
                "compiler",
                "bugreport",
            },
        },
    },
    readme = {
        enabled = true,
        root = vim.fn.stdpath "state" .. "/lazy/readme",
        files = { "README.md", "lua/**/README.md" },
        skip_if_doc_exists = true,
    },
    build = {
        -- Plugins can provide a `build.lua` file that will be executed when the plugin is installed
        -- or updated. When the plugin spec also has a `build` command, the plugin's `build.lua` not be
        -- executed. In this case, a warning message will be shown.
        warn_on_override = true,
    },
}
