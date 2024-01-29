require('luasnip').setup({})
require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/lua/kdisneur/plugins/luasnip/"})

vim.keymap.set({ 'i', 's' }, '<C-j>', '<CMD>lua require("luasnip").jump(1)<CR>')
vim.keymap.set({ 'i', 's' }, '<C-k>', '<CMD>lua require("luasnip").jump(-1)<CR>')
vim.keymap.set({ 'i', 's' }, '<C-e>', '<Plug>luasnip-next-choice')
