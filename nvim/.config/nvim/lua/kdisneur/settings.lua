-- vim.g: for things I would "let" in vimscript
-- vim.o: for things I would "set" in vimscript

vim.g.mapleader = ' '
vim.o.termguicolors = true
vim.o.background = 'light'

vim.o.expandtab = true -- Use correct number of spaces when pressing tab
vim.o.shiftwidth = 2 -- Number of spaces to use when indentating
vim.o.tabstop = 4 -- Number of spaces used to display tab

vim.wo.signcolumn = 'yes'
vim.o.scrolloff = 999 -- Keep cursor centered on screen

vim.o.incsearch = true -- Jump to the first match as typing
vim.o.hlsearch = false -- Do not highlight search results

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.backup = false
vim.o.writebackup = false

