local cmd = vim.api.nvim_create_user_command
local set_mappings = require("utils").set_mappings
local function resolve_lazy_spec(spec)
    if type(spec) ~= "table" then
        -- no need to do anything: there is no config/init fn
        return
    end

    local plugin_spec = {
        name = nil,
        opts = nil,
        config = function(plug, opts)
            if opts == nil then return end
            local plugin_name = vim.split(plug, "/")
            plugin_name = vim.iter(plugin_name):last()

            local status_ok, p = pcall(require, plugin_name)
            if not status_ok and plugin_name:match "%.nvim$" then
                status_ok, p = pcall(require, plugin_name:sub(1, -6))
            end
            if not status_ok and plugin_name:match "^nvim-" then
                status_ok, p = pcall(require, plugin_name:sub(6))
            end
            if not status_ok and plugin_name:match "-" then
                status_ok, p = pcall(require, plugin_name:gsub("-", "_"))
            end
            if status_ok then
                vim.notify("Executing plugin setup for " .. plugin_name)
                p.setup(opts)
            else
                vim.notify("could not execute setup for: " .. plug)
                vim.notify(
                    "tried: "
                        .. plugin_name:sub(1, -6)
                        .. ", "
                        .. plugin_name:sub(6)
                        .. " and "
                        .. plugin_name:gsub("[-]", "_")
                )
            end
        end,
        init = function() end,
        enabled = true,
        keys = {},
    }
    for key, value in pairs(spec) do
        if type(key) == "number" then
            -- vim.notify("resolving subspec for " .. key)
            if type(value) == "string" then
                plugin_spec.name = value
            else
                -- resolve subspec
                resolve_lazy_spec(value)
            end
        else
            if key == "config" then
                if
                    type(value) == "boolean"
                    and value
                    and plugin_spec.opts == nil
                then
                    plugin_spec.opts = {}
                else
                    plugin_spec.config = value
                end
            elseif key == "keys" then
                plugin_spec.keys = value
            elseif key == "opts" then
                if type(value) == "boolean" and value then
                    plugin_spec.opts = {}
                else
                    plugin_spec.opts = value
                end
            elseif key == "init" then
                plugin_spec.init = value
            elseif key == "enabled" then
                plugin_spec.enabled = value
            elseif key == "dependencies" then
                resolve_lazy_spec(value)
            else
            end
        end
    end
    if type(plugin_spec.enabled) == "function" then
        plugin_spec.enabled = plugin_spec.enabled()
    end
    if plugin_spec.enabled and plugin_spec.name ~= nil then
        if type(plugin_spec.opts) == "function" then
            plugin_spec.opts = plugin_spec.opts()
        end
        plugin_spec.init()
        plugin_spec.config(plugin_spec.name, plugin_spec.opts)
        -- TODO: check keys for lhs & rhs
        -- this call currently might fail due to lazy keys missing RHS
        pcall(set_mappings, plugin_spec.keys)
    end
end

cmd("SrcConfig", function()
    local bn = vim.fn.expand "%:p"
    if bn:match "%.vim$" then vim.cmd "source %" end
    if bn:match "%.lua$" then
        -- source file
        local potential_spec = dofile(bn)
        -- if return is a lazy spec, run the config/init function for each plugin
        if type(potential_spec) == "table" then
            resolve_lazy_spec(potential_spec)
        end
    end
end, {})

cmd("SrcLazy", function()
    require "config.lazy"
    vim.cmd [[ Lazy install ]]
end, {})
