vim.o.termguicolors = true

vim.o.expandtab = true  -- Use correct number of spaces when pressing tab
vim.o.shiftwidth = 2    -- Number of spaces to use when indentating
vim.o.tabstop = 4       -- Number of spaces used to display tab

vim.o.ignorecase = true -- Use /C to force case
vim.o.smartcase = true  -- Case becomes sensitive if it contains an uppercase letter

vim.wo.signcolumn = 'yes'
vim.o.scrolloff = 999                  -- Keep cursor centered on screen

vim.o.incsearch = true                 -- Jump to the first match as typing
vim.o.hlsearch = false                 -- Do not highlight search results

vim.o.completeopt = 'menuone,noselect' -- Set completeopt to have a better completion experience

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

vim.g.netrw_keepdir = 0
