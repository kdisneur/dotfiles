-- execute tests from neovim
return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',

    'nvim-neotest/neotest-go',
    'rouge8/neotest-rust',
    'nvim-neotest/neotest-plenary'
  },
  config = function()
    local neotest = require('neotest')

    neotest.setup({
      adapters = {
        require('neotest-go'),
        require('neotest-rust'),
        require('neotest-plenary')
      },
      output = {
        enabled = true,
        open_on_run = 'short'
      },
      run = {
        enabled = true
      },
      default_strategy = 'integrated',
      status = {
        enabled = true,
        signs = true,
        virtual_text = false
      },
      icons = {
        passed = '✓',
        running = '.',
        skipped = '/',
        unknown = '?',
        failed = 'x',
      },
      highlights = {
        passed = 'GitSignsAdd',
        failed = 'GitSignsDelete',
      }
    })

    vim.keymap.set('n', '<leader>tr', neotest.output.open, { desc = 'Open float window with test output' })
    vim.keymap.set('n', '<leader>tt', neotest.run.run, { desc = 'Run test under cursor' })
    vim.keymap.set('n', '<leader>tf', function() neotest.run.run(vim.fn.expand('%')) end,
      { desc = 'Run all test in current file' })
    vim.keymap.set('n', '<leader>ts', function() neotest.summary.toggle() end,
      { desc = 'Open/Close neotest summary window' })
    vim.keymap.set('n', ']n', function() neotest.jump.next({ status = 'failed' }) end,
      { desc = 'Move to next failing test' })
    vim.keymap.set('n', '[n', function() neotest.jump.prev({ status = 'failed' }) end,
      { desc = 'Move to previous failing test' })
  end
}
