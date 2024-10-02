local M = {}

M.icons = require "utils.icons"

function M.bool2str(bool) return bool and "enabled" or "disabled" end
function M.format_notify(str, b) vim.notify(string.format(str, b)) end
function M.format_notify_bool(str, b)
    vim.notify(string.format(str, M.bool2str(b)))
end

--- Check if a plugin is defined in lazy. Useful with lazy loading when a plugin is not necessarily loaded yet
function M.is_available(plugin)
    local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
    return lazy_config_avail and lazy_config.spec.plugins[plugin] ~= nil
end

function M.get_icon(kind, padding)
    local icon = M.icons[kind]
    return icon and icon .. string.rep(" ", padding or 0) or ""
end

local keymap_set = function(k)
    local opts = {}
    if k.silent then opts.silent = k.silent end
    if k.expr then opts.expr = k.expr end
    if k.desc then opts.desc = k.desc end
    vim.keymap.set(k.mode or "n", k[1], k[2], opts)
end

function M.set_mappings(mappings)
    for _, keymap in pairs(mappings) do
        keymap_set(keymap)
    end
end

return M
