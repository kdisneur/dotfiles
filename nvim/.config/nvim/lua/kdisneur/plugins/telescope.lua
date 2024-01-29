local actions = require('telescope.actions')
require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] =  actions.move_selection_previous,
      }
    }
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {},
    }
  }
})

require("telescope").load_extension("ui-select")

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>s', builtin.live_grep, {})
vim.keymap.set('n', '<leader>e', '<cmd>Telescope diagnostics<CR>', {})
vim.keymap.set('n', '<C-f>', ":lua require('telescope.builtin').lsp_document_symbols({symbols={'function', 'method'}})<CR>", {})
