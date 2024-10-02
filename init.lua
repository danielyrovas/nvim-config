local default_providers = {
    "node",
    "perl",
    "python3",
    "ruby",
}

for _, provider in ipairs(default_providers) do
    vim.g["loaded_" .. provider .. "_provider"] = 0
end

vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.max_file = { size = 1024 * 50, lines = 5000 } -- set global limits for large files

require "config.lazy"

vim.cmd "colorscheme tokyonight"
