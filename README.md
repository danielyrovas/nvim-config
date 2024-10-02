## Structure

```bash
🗀 .
├── 🗀 lua
│  ├──🗀 config
│  │  ├── 🖹 lazy.lua
│  ├── 🗀 plugins       # Lazy.nvim plugin specifications
│  ├── 🗀 snippets      # snippets loaded by Luasnip
│  └── 🗀 utils
├── 🗀 plugin           # vim will source these in order see :h load-plugins
│  ├── 🖹 autocmds.lua  # event callbacks
│  ├── 🖹 cmds.lua      # custom :Commands
│  ├── 🖹 mappings.lua  # custom keybinds
│  └── 🖹 options.lua   # vim.opt
├── 🗀 spell            # thesaurus & dictionary
└── 🖹 init.lua
```
