local opt = vim.opt

opt.shortmess:append { s = true, I = true } -- disable `hit enter` prompts
opt.viewoptions:remove "curdir" -- disable saving current directory with views
opt.backspace:append { "nostop" } -- don't stop backspace at insert
opt.diffopt:append "linematch:60" -- enable linematch diff algorithm
-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
-- opt.whichwrap:append "<>[]hl"
opt.breakindent = true -- wrap indent to match  line start
opt.clipboard = "unnamedplus"
opt.cmdheight = 1
opt.completeopt = { "menu", "menuone", "noselect" } -- Options for insert mode completion
opt.copyindent = true -- copy the previous indentation on autoindenting
opt.cursorline = true -- highlight the text line of the cursor
opt.expandtab = true -- enable the use of space in tab
-- TODO: why set this?
-- opt.fileencoding = "utf-8" -- file content encoding for the buffer
opt.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldclose:"
opt.foldenable = true -- enable fold for nvim-ufo
opt.foldlevel = 99 -- set high foldlevel for nvim-ufo
opt.foldlevelstart = 99 -- start with all code unfolded
opt.foldcolumn = "0"
opt.history = 100
opt.ignorecase = true
opt.infercase = true
opt.laststatus = 3 -- global statusline
opt.linebreak = true -- wrap lines at 'breakat'
opt.mouse = "a" -- enable mouse support
opt.mousemodel = "extend" -- remove dog menu
opt.number = true -- show numberline
opt.preserveindent = true -- preserve indent structure as much as possible
opt.pumheight = 10 -- height of the pop up menu
opt.relativenumber = false -- no trashy line number flickering
opt.scrolloff = 8 -- number of lines to keep above and below the cursor
opt.shiftwidth = 4 -- number of space inserted for indentation
opt.showmode = false -- disable showing modes in command line
opt.showtabline = 1
opt.sidescrolloff = 4 -- number of columns to keep at the sides of the cursor
opt.signcolumn = "yes" -- always show the sign column
opt.smartcase = true -- case sensitive searching
opt.splitbelow = true -- splitting a new window below the current one
opt.splitright = true -- splitting a new window at the right of the current one
opt.tabstop = 4 -- number of space in a tab
opt.softtabstop = -1 -- follow shiftwidth
opt.termguicolors = true -- enable 24-bit RGB color in the TUI
opt.timeoutlen = 500 -- shorten key timeout length a little bit for which-key
opt.undofile = true -- enable persistent undo
opt.updatetime = 250 -- length of time to wait before triggering the plugin
opt.virtualedit = "block" -- allow going past end of line in visual block mode
opt.wrap = false -- disable wrapping of lines longer than the width of window
opt.writebackup = false -- disable making a backup before overwriting a file
opt.sessionoptions = "buffers,curdir,folds,help,globals,tabpages,winpos,winsize"
opt.inccommand = "split"
opt.smartindent = true
opt.spell = false
opt.spelllang = "en_gb,en_au"
opt.spellfile = vim.fn.stdpath "config" .. "/spell/en.utf-8.add"
opt.thesaurus = vim.fn.stdpath "config" .. "/spell/thesaurus.txt"
opt.swapfile = false
opt.list = true -- show whitespace characters
opt.listchars = {
    -- tab = "│ →",
    tab = "│ ",
    extends = "⟩",
    precedes = "⟨",
    trail = "·",
    nbsp = "␣",
}
opt.showbreak = "↪ "
vim.diagnostic.config { virtual_text = false }

if vim.g.neovide then
    vim.g.neovide_transparency = 0.0
    vim.g.transparency = 0.0
    -- vim.o.guifont = "JetBrains\\ Mono,Hack:h27"
    vim.g.neovide_scale_factor = 1.4
end
