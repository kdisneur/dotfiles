-- Setup leader key first to be sure all plugins will have access to it
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install plugin manager and plugins
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable',
    lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Every lua/plugins/*.lua is a plugin spec. Other dotfiles directories (work,
-- ...) drop extra files in the same folder and they are picked up from here.
require('lazy').setup({ { import = 'plugins' } }, {})

-- Every lua/rc/*.lua is sourced in alphabetical order, like ~/.zsh/rc.d/*.zsh
for _, file in ipairs(vim.fn.glob(vim.fn.stdpath('config') .. '/lua/rc/*.lua', false, true)) do
  dofile(file)
end
