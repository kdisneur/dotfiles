-- finder
return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-ui-select.nvim' },
  config = function()
    local actions = require('telescope.actions')

    require('telescope').setup({
      defaults = {
        mappings = {
          i = {
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
          }
        }
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown {},
        }
      }
    })
    require('telescope').load_extension('ui-select')

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Search files' })
    vim.keymap.set('n', '<leader>s', builtin.live_grep, { desc = 'Search content in files' })
    vim.keymap.set('n', '<leader>e', builtin.diagnostics, { desc = 'Search in diagnostics' })
    vim.keymap.set('n', '<C-f>', function()
      builtin.lsp_document_symbols({ symbols = { 'function', 'method' } })
    end, { desc = 'Search all function/methods in buffer' })
    vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = 'Search content in current buffer' })
  end
}
