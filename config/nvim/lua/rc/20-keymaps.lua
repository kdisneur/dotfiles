vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true }) -- space is the leader key so it should never move the cursor
vim.keymap.set('n', '*', '*``', { silent = true })
vim.keymap.set('n', '**', '*', { silent = true })
vim.keymap.set(
  'n',
  '<leader>fj',
  ':edit <c-r>="~/.junks/" . strftime("%Y%m%d") . "." <cr>',
  { desc = 'open junk folder', silent = true }
)
vim.keymap.set('n', '[<space>', 'O<esc>j', { desc = 'insert a new line before current line', silent = true })
vim.keymap.set('n', ']<space>', 'o<esc>k', { desc = 'insert a new line after current line', silent = true })
vim.keymap.set('n', '<leader>w', ':update<cr>', { desc = 'save current buffer' })
vim.keymap.set('n', '<leader>q', ':quit<cr>', { desc = 'close current window' })
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, { desc = 'go to previous diagnostic' })
vim.keymap.set('n', ']g', vim.diagnostic.goto_next, { desc = 'go to next diagnostic' })
vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float, { desc = 'open float window to see full diagnostic' })
vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist, { desc = 'fill loclist with diagnostic' })
vim.keymap.set('n', '<C-w>t', ':tab split<cr>', { desc = 'copy current buffer in the new tab instead of moving it' })
vim.keymap.set('n', '<leader>ff', ':edit <c-r>=expand("%:p:h") . "/" <cr>',
  { desc = 'Move to another file in same folder' })
