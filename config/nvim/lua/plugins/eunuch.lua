-- some helpers to create / remove file and folders
return {
  'tpope/vim-eunuch',
  config = function()
    vim.keymap.set('n', '<leader>fR', ':Move <c-r>=expand("%:p:h")<cr>',
      { desc = 'Rename / Move current file', silent = true })
    vim.keymap.set('n', '<leader>fd', ':Mkdir!<bar>:update<cr>',
      { desc = 'Create parent folder of current file', silent = true })
    vim.keymap.set('n', '<leader>fD', ':Remove<cr>', { desc = 'Remove current file', silent = true })
  end
}
