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
  'neovim/nvim-lspconfig',

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
    branch = 'main', -- master is frozen, the rewrite lives on main
    lazy = false,    -- the rewrite does not support lazy-loading
    build = ':TSUpdate',
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
        init = function()
          vim.g.no_plugin_maps = true -- built-in ftplugins map [[, ]], ... and would win
        end
      }
    }
  },

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
  { 'wellle/targets.vim', event = 'BufRead' },

  -- some helpers to create / remove file and folders
  'tpope/vim-eunuch',

  -- finder
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-ui-select.nvim' }
  },

  -- execute tests from neovim
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',

      'nvim-neotest/neotest-go',
      'rouge8/neotest-rust',
      'nvim-neotest/neotest-plenary'
    }
  },

  -- theme
  'Mofiqul/vscode.nvim',
  -- ability to edit quickfix list and still jump to files
  'itchyny/vim-qfedit'
}, {})

-- LSP server settings
vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      check = { command = 'clippy' }, -- run clippy instead of cargo check on save
      cargo = { targetDir = true },   -- keep LSP artifacts out of target/ to avoid lock contention
    },
  },
})

-- global settings
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
vim.keymap.set('n', '<leader>ff', ':edit <c-r>=expand("%:p:h") . "/" <cr>',
  { desc = 'Move to another file in same folder' })

-- status line
function RenderStatusLine()
  return '%f%m%r'
end

vim.o.statusline = "%!luaeval('RenderStatusLine()')"

-- setup LSP
vim.cmd [[autocmd BufWritePre * :lua vim.lsp.buf.format()]]

-- setup snippet
require('luasnip.loaders.from_lua').load({ paths = '~/.config/nvim/lua/REDACTED_SHORT_USERNAME/plugins/luasnip/' })

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
require('nvim-treesitter').install({
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
})

-- highlight and indent are provided by neovim itself, they only need to be
-- turned on for the buffers having a parser installed
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local language = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
    if not language or not pcall(vim.treesitter.start, args.buf, language) then
      return
    end

    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
})

-- setup treesitter textobjects
require('nvim-treesitter-textobjects').setup({
  select = {
    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
  },
  move = {
    set_jumps = true, -- whether to set jumps in the jumplist
  }
})

local ts_select = require('nvim-treesitter-textobjects.select')
local ts_move = require('nvim-treesitter-textobjects.move')

local function select_textobject(query)
  return function() ts_select.select_textobject(query, 'textobjects') end
end

local function move_textobject(direction, query)
  return function() ts_move[direction](query, 'textobjects') end
end

vim.keymap.set({ 'x', 'o' }, 'af', select_textobject('@function.outer'), { desc = 'a function' })
vim.keymap.set({ 'x', 'o' }, 'if', select_textobject('@function.inner'), { desc = 'inner function' })
vim.keymap.set({ 'x', 'o' }, 'aa', select_textobject('@parameter.outer'), { desc = 'a parameter' })
vim.keymap.set({ 'x', 'o' }, 'ia', select_textobject('@parameter.inner'), { desc = 'inner parameter' })

vim.keymap.set({ 'n', 'x', 'o' }, ']m', move_textobject('goto_next_start', '@function.outer'),
  { desc = 'go to next function start' })
vim.keymap.set({ 'n', 'x', 'o' }, ']]', move_textobject('goto_next_start', '@class.outer'),
  { desc = 'go to next class start' })
vim.keymap.set({ 'n', 'x', 'o' }, ']M', move_textobject('goto_next_end', '@function.outer'),
  { desc = 'go to next function end' })
vim.keymap.set({ 'n', 'x', 'o' }, '][', move_textobject('goto_next_end', '@class.outer'),
  { desc = 'go to next class end' })
vim.keymap.set({ 'n', 'x', 'o' }, '[m', move_textobject('goto_previous_start', '@function.outer'),
  { desc = 'go to previous function start' })
vim.keymap.set({ 'n', 'x', 'o' }, '[[', move_textobject('goto_previous_start', '@class.outer'),
  { desc = 'go to previous class start' })
vim.keymap.set({ 'n', 'x', 'o' }, '[M', move_textobject('goto_previous_end', '@function.outer'),
  { desc = 'go to previous function end' })
vim.keymap.set({ 'n', 'x', 'o' }, '[]', move_textobject('goto_previous_end', '@class.outer'),
  { desc = 'go to previous class end' })

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

vim.cmd.colorscheme('vscode')

-- setup LSP
vim.lsp.enable({ 'clangd', 'gopls', 'rust_analyzer' })
