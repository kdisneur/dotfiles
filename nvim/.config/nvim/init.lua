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

require('lazy').setup({
  -- LSP Configuration
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'j-hui/fidget.nvim',

      -- additional lua configuration to makes neovim plugins
      { 'folke/neodev.nvim',       config = {} },
    }
  },

  -- autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      { 'L3MON4D3/LuaSnip', config = {} },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    }
  },

  -- better highlights / code navigation
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    build = ':TSUpdate'
  },

  -- consistent spacing / encoding practices
  'gpanders/editorconfig.nvim',

  -- un/comment code
  { 'numToStr/Comment.nvim', opts = {} },

  -- additional text object to manipulate surrounding quote, parentheses,...
  {
    'tpope/vim-surround',
    event = 'BufRead',
    dependencies = { { 'tpope/vim-repeat', event = 'BufRead', } }
  },

  -- additional motion to move to next camelCase/PascalCase words
  {
    'chaoren/vim-wordmotion',
    init = function()
      vim.g.wordmotion_prefix = 'g'
    end
  },

  --  additional text objects to work inside quotes, parentheses, comma,..
  --  use({ 'wellle/targets.vim', event = 'BufRead' })

  -- some helpers to create / remove file and folders
  'tpope/vim-eunuch',

  -- finder
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-ui-select.nvim' }
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' }
  },

  -- execute tests from neovim
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',

      'nvim-neotest/neotest-go',
      'rouge8/neotest-rust',
      'nvim-neotest/neotest-plenary'
    }
  },

  -- theme
  'Mofiqul/vscode.nvim'
}, {})

-- global settings
vim.o.termguicolors = true
vim.o.background = 'light'

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

-- global keybindings
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

-- status line
function RenderStatusLine()
  return '%f%m%r'
end

vim.o.statusline = "%!luaeval('RenderStatusLine()')"

-- setup LSP
vim.cmd [[autocmd BufWritePre * :lua vim.lsp.buf.format()]]

local flags = {
  allow_incremental_sync = true,
  debounce_text_changes = 200,
}

local function on_attach(_, buf)
  local opts = { buffer = buf }

  vim.api.nvim_buf_set_option(buf, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', '<C-h>', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, opts)
  vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<leader>lc', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>lt', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<leader>lR', vim.lsp.buf.rename, opts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason-lspconfig').setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name)
    require('lspconfig')[server_name].setup({
      flags = flags,
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,
  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `rust_analyzer`:
  -- ['rust_analyzer'] = function ()
  --   require('rust-tools').setup {}
  -- end
  ['rust_analyzer'] = function()
    require('lspconfig')['rust_analyzer'].setup({
      flags = flags,
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = { 'rust-analyzer' },
      settings = {
        ['rust-analyzer'] = {
          diagnostics = {
            enable = true,
          },
          cargo = {
            allFeatures = true,
          },
          checkOnSave = {
            allFeatures = true,
            command = 'clippy',
          },
          procMacro = {
            enabled = false,
            ignored = {
              ['async-trait'] = { 'async_trait' },
              ['napi-derive'] = { 'napi' },
              ['async-recursion'] = { 'async_recursion' },
            },
          },
        },
      }
    })
  end
}

-- setup snippet
require('luasnip.loaders.from_lua').load({ paths = '~/.config/nvim/lua/kdisneur/plugins/luasnip/' })

vim.keymap.set({ 'i', 's' }, '<C-j>', function() require('luasnip').jump(1) end, {})
vim.keymap.set({ 'i', 's' }, '<C-k>', function() require('luasnip').jump(-1) end, {})
vim.keymap.set({ 'i', 's' }, '<C-e>', '<Plug>luasnip-next-choice')

local cmp = require('cmp')
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-e>'] = cmp.config.disable,
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true
    }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

-- setup treesitter
require('nvim-treesitter.configs').setup({
  auto_install = false,
  ensure_installed = {
    'bash',
    'go',
    'html',
    'json',
    'lua',
    'markdown',
    'rust',
    'toml',
    'vim',
    'vimdoc',
    'yaml',
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = false,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
      }
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  }
})

-- setup eunuch
vim.keymap.set('n', '<leader>fR', ':Move <c-r>=expand("%:p:h")<cr>',
  { desc = 'Rename / Move current file', silent = true })
vim.keymap.set('n', '<leader>fd', ':Mkdir!<bar>:update<cr>',
  { desc = 'Create parent folder of current file', silent = true })
vim.keymap.set('n', '<leader>fD', ':Remove<cr>', { desc = 'Remove current file', silent = true })

-- setup telescope
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
    },
    file_browser = {
      disable_devicons = true,
      git_status = false,
      display_stat = false,
    }
  }
})
require('telescope').load_extension('ui-select')
require('telescope').load_extension('file_browser')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Search files' })
vim.keymap.set('n', '<leader>s', builtin.live_grep, { desc = 'Search content in files' })
vim.keymap.set('n', '<leader>e', builtin.diagnostics, { desc = 'Search in diagnostics' })
vim.keymap.set('n', '<C-f>', function()
  builtin.lsp_document_symbols({ symbols = { 'function', 'method' } })
end, { desc = 'Search all function/methods in buffer' })
vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = 'Search content in current buffer' })
vim.keymap.set('n', '<space>ff',
  function()
    require('telescope').extensions.file_browser.file_browser({
      path = require('telescope.utils').buffer_dir(),
      select_buffer = true
    })
  end,
  { desc = 'Open current folder and allow creating/deleting/renaming files' })

-- setup neovim
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
vim.keymap.set('n', '<leader>ts', function() neotest.summary.toggle() end, { desc = 'Open/Close neotest summary window' })
vim.keymap.set('n', ']n', function() neotest.jump.next({ status = 'failed' }) end, { desc = 'Move to next failing test' })
vim.keymap.set('n', '[n', function() neotest.jump.prev({ status = 'failed' }) end,
  { desc = 'Move to previous failing test' })

-- setup vscode theme
require('vscode').setup({
  transparent = true,
  italic_comments = true,
})

require('vscode').load()
