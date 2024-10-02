local load_extension = function(extopts, extension)
    local opts = { extensions = {} }
    opts.extensions[extension] = extopts
    -- Calling telescope's setup from multiple specs does not hurt,
    -- it will happily merge the configs for us.
    require("telescope").setup(opts)
    require("telescope").load_extension(extension)
end

return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            enabled = vim.fn.executable "make" == 1,
            build = "make",
            config = function() load_extension({}, "fzf") end,
        },
        {
            "nvim-telescope/telescope-file-browser.nvim",
            keys = {
                {
                    "<leader>fe",
                    "<cmd>Telescope file_browser<cr>",
                    desc = "File Explorer",
                },
            },
            config = function() load_extension({}, "file_browser") end,
        },
        {
            "nvim-telescope/telescope-frecency.nvim",
            enabled = false,
            config = function() load_extension({}, "frecency") end,
            keys = {
                {
                    "<leader>fr",
                    function()
                        require("telescope").extensions.frecency.frecency {
                            workspace = "CWD",
                        }
                    end,
                    desc = "Frecent files",
                },
            },
        },
        {
            "GianniBYoung/chezmoi-telescope.nvim",
            enabled = false,
            config = function() load_extension({}, "chezmoi") end,
        },
        {
            "debugloop/telescope-undo.nvim",
            keys = {
                {
                    "<leader>fu",
                    "<cmd>Telescope undo<cr>",
                    desc = "undo history",
                },
            },
            config = function() load_extension({}, "undo") end,
        },
    },
    cmd = "Telescope",
    opts = function()
        local actions = require "telescope.actions"
        local get_icon = require("utils").get_icon

        local opts = {
            defaults = {
                color_devicons = true,
                sorting_strategy = "ascending",
                layout_strategy = "horizontal",
                prompt_prefix = get_icon("Search", 1), -- Telescope
                selection_caret = get_icon("Selected", 1),
                path_display = { "smart" },
                layout_config = {
                    horizontal = { prompt_position = "top", preview_width = 0.6 },
                    flex = { horizontal = { preview_width = 0.9 } },
                    vertical = { mirror = false },
                    width = 0.9,
                    height = 0.85,
                    preview_cutoff = 120,
                },
                mappings = {
                    i = {
                        ["<C-n>"] = actions.move_selection_next,
                        ["<C-p>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.cycle_history_next,
                        ["<C-k>"] = actions.cycle_history_prev,
                        ["<esc>"] = actions.close,
                    },
                    n = { q = actions.close },
                },
            },
            pickers = {
                find_files = { follow = true },
                buffers = {
                    path_display = { "smart" },
                    mappings = {
                        i = { ["<c-d>"] = actions.delete_buffer },
                        n = { ["d"] = actions.delete_buffer },
                    },
                },
            },
        }
        if vim.fn.executable "rg" == 1 then
            opts.defaults.vimgrep_arguments = {
                "rg",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
                "--no-messages",
                "--follow",
            }
        end
        return opts
    end,
    keys = {
        {
            "<leader><leader>",
            function()
                require("telescope.builtin").buffers(
                    require("telescope.themes").get_dropdown {
                        previewer = false,
                        sort_mru = true,
                        -- ignore_current_buffer = true,
                    }
                )
            end,
            desc = "Find Buffers",
        },
        {
            "<leader>,",
            function()
                require("telescope.builtin").current_buffer_fuzzy_find(
                    require("telescope.themes").get_dropdown { previewer = false }
                )
            end,
            desc = "Current Buffer Fuzzy Find",
        },
        {
            "<leader>m",
            function()
                require("telescope.builtin").current_buffer_fuzzy_find(
                    vim.tbl_extend(
                        "force",
                        require("telescope.themes").get_dropdown {
                            previewer = false,
                        },
                        { fuzzy = false, case_mode = "smart_case" }
                    )
                )
            end,
            desc = "Current Buffer Fuzzy Find",
        },
        {
            "<leader>gb",
            function()
                require("telescope.builtin").git_branches { use_file_path = true }
            end,
            desc = "Git branches",
        },
        {
            "<leader>gc",
            function()
                require("telescope.builtin").git_commits { use_file_path = true }
            end,
            desc = "Git commits (repository)",
        },
        {
            "<leader>gC",
            function()
                require("telescope.builtin").git_bcommits { use_file_path = true }
            end,
            desc = "Git commits (current file)",
        },
        {
            "<leader>gt",
            function()
                require("telescope.builtin").git_status { use_file_path = true }
            end,
            desc = "Git status",
        },
        {
            "<leader>f<CR>",
            function() require("telescope.builtin").resume() end,
            desc = "Resume previous search",
        },
        {
            "<leader>f'",
            function() require("telescope.builtin").marks() end,
            desc = "Find marks",
        },
        {
            "<leader>f/",
            function() require("telescope.builtin").current_buffer_fuzzy_find() end,
            desc = "Find words in current buffer",
        },
        {
            "<leader>fb",
            function() require("telescope.builtin").buffers() end,
            desc = "Find buffers",
        },
        {
            "<leader>fc",
            function() require("telescope.builtin").grep_string() end,
            desc = "Find word under cursor",
        },
        {
            "<leader>fC",
            function() require("telescope.builtin").commands() end,
            desc = "Find commands",
        },
        {
            "<leader>ff",
            function() require("telescope.builtin").find_files() end,
            desc = "Find files",
        },
        {
            "<leader>fa",
            function()
                require("telescope.builtin").find_files {
                    hidden = true,
                    no_ignore = true,
                }
            end,
            desc = "Find all files",
        },
        {
            "<leader>fh",
            function() require("telescope.builtin").help_tags() end,
            desc = "Find help",
        },
        {
            "<leader>fk",
            function() require("telescope.builtin").keymaps() end,
            desc = "Find keymaps",
        },
        {
            "<leader>fm",
            function() require("telescope.builtin").man_pages() end,
            desc = "Find man",
        },
        {
            "<leader>fo",
            function() require("telescope.builtin").oldfiles() end,
            desc = "Find history",
        },
        {
            "<leader>fR",
            function() require("telescope.builtin").registers() end,
            desc = "Find registers",
        },
        {
            "<leader>fT",
            function()
                require("telescope.builtin").colorscheme { enable_preview = true }
            end,
            desc = "Find themes",
        },
        {
            "<leader>fw",
            function() require("telescope.builtin").live_grep() end,
            desc = "Find words",
        },
        {
            "<leader>fW",
            function()
                require("telescope.builtin").live_grep {
                    additional_args = function(args)
                        return vim.list_extend(
                            args,
                            { "--hidden", "--no-ignore" }
                        )
                    end,
                }
            end,
            desc = "Find words in all files",
        },
        {
            "<leader>fl",
            function() require("telescope.builtin").highlights() end,
            desc = "Find Highlights",
        },
        {
            "<leader>ls",
            function()
                local aerial_avail, _ = pcall(require, "aerial")
                if aerial_avail then
                    require("telescope").extensions.aerial.aerial()
                else
                    require("telescope.builtin").lsp_document_symbols()
                end
            end,
            desc = "Search symbols",
        },
        {
            "<leader>lD",
            function() require("telescope.builtin").diagnostics() end,
            desc = "Search diagnostics",
        },
        {
            "gd",
            function() require("telescope.builtin").lsp_definitions() end,
            desc = "Show the definition of current symbol",
        },
        {
            "gI",
            function() require("telescope.builtin").lsp_implementations() end,
            desc = "Implementation of current symbol",
        },
        {
            "gr",
            function() require("telescope.builtin").lsp_references() end,
            desc = "References of current symbol",
        },
        {
            "gy",
            function() require("telescope.builtin").lsp_type_definitions() end,
            desc = "Definitions of current type",
        },
        {
            "<leader>lG",
            function()
                vim.ui.input({
                    prompt = "Symbol Query: (leave empty for word under cursor)",
                }, function(query)
                    if query then
                        -- word under cursor if given query is empty
                        if query == "" then query = vim.fn.expand "<cword>" end
                        require("telescope.builtin").lsp_workspace_symbols {
                            query = query,
                            prompt_title = ("Find word (%s)"):format(query),
                        }
                    end
                end)
            end,
            desc = "Search workspace symbols",
        },
    },
}
