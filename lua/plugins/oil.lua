return {
    "stevearc/oil.nvim",
    lazy = true,
    enabled = true,
    opts = {
        default_file_explorer = false,
        columns = {
            "icon",
            -- "permissions",
            -- "size",
            -- "mtime",
        },
        -- Buffer-local options to use for oil buffers
        buf_options = {
            buflisted = false,
            bufhidden = "hide",
        },
        -- Window-local options to use for oil buffers
        win_options = {
            wrap = false,
            signcolumn = "no",
            cursorcolumn = false,
            foldcolumn = "0",
            spell = false,
            list = false,
            conceallevel = 3,
            concealcursor = "nvic",
        },
        restore_win_options = true,
        skip_confirm_for_simple_edits = false,
        delete_to_trash = false,
        trash_command = "trash-put",
        prompt_save_on_select_new_entry = true,
        keymaps = {
            ["g?"] = "actions.show_help",
            ["<CR>"] = "actions.select",
            ["<C-s>"] = "actions.select_vsplit",
            ["<C-h>"] = "actions.select_split",
            ["<C-t>"] = "actions.select_tab",
            ["<C-p>"] = "actions.preview",
            ["<C-c>"] = "actions.close",
            ["<C-l>"] = "actions.refresh",
            ["q"] = "actions.close",
            ["-"] = "actions.parent",
            ["_"] = "actions.open_cwd",
            ["`"] = "actions.cd",
            ["~"] = "actions.tcd",
            ["gs"] = "actions.change_sort",
            ["gx"] = "actions.open_external",
            ["g."] = "actions.toggle_hidden",
            ["g\\"] = "actions.toggle_trash",
        },
        use_default_keymaps = true,
        view_options = {
            -- Show files and directories that start with "."
            show_hidden = false,
            -- This function defines what is considered a "hidden" file
            is_hidden_file = function(name, bufnr)
                return vim.startswith(name, ".")
            end,
            -- This function defines what will never be shown, even when `show_hidden` is set
            is_always_hidden = function(name, bufnr) return false end,
        },
        float = {
            -- Padding around the floating window
            padding = 2,
            max_width = 90,
            max_height = 0,
            -- border = "rounded",
            win_options = {
                winblend = 0,
            },
        },
    },
    cmd = "Oil",
    keys = {
        {
            "<leader>=",
            function() require("oil").open() end,
            desc = "Open folder in Oil",
        },
    },
}
