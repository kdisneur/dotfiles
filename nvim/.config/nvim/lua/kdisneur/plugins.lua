vim.api.nvim_create_autocmd('BufWritePost', {
  group = vim.api.nvim_create_augroup('PACKER', { clear = true }),
  pattern = 'plugins.lua',
  command = 'source <afile> | PackerCompile',
})

return require('packer').startup({
  function(use)
    -- Package Manager
    use('wbthomason/packer.nvim')

    -- Required plugins
    use('nvim-lua/plenary.nvim')

    -- Treesitter: Better Highlights
    use({
      {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
          require('kdisneur.plugins.treesitter')
        end
      },
      { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },
    })

    -- Editing and Navigation
    use({'gpanders/editorconfig.nvim'})

    use({
      'tpope/vim-surround',
      event = 'BufRead',
      requires = {{ 'tpope/vim-repeat', event = 'BufRead', }}
    })

    use({
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end
    })


    use({'tpope/vim-eunuch'})

    use({
      'chaoren/vim-wordmotion',
      config = function()
        vim.g.wordmotion_prefix = 'g'
      end
    })

    use({ 'nvim-telescope/telescope.nvim',
      requires={
        {'nvim-lua/plenary.nvim'},
        {'nvim-telescope/telescope-ui-select.nvim'}
      },
      config = function()
        require('kdisneur.plugins.telescope')
      end,
    })

    use({ 'wellle/targets.vim', event = 'BufRead' })

    use {
      'nvim-neotest/neotest',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'antoinemadec/FixCursorHold.nvim',
        "nvim-neotest/neotest-go",
        'nvim-neotest/neotest-jest',
        'rouge8/neotest-rust',

      },
      config = function()
        require('kdisneur.plugins.neotest')
      end,
    }

    -- LSP, Completions and Snippet
    use {
      "williamboman/mason.nvim",
      config = function()
        require('kdisneur.plugins.mason')
      end,
    }

    use {
      "williamboman/mason-lspconfig.nvim",
      config = function()
        require('kdisneur.plugins.mason-lspconfig')
      end,
      after = "mason",
    }

    use({
      'neovim/nvim-lspconfig',
      event = 'BufRead',
      config = function()
        require('kdisneur.plugins.lsp-servers')
      end,
      requires = {{ 'hrsh7th/cmp-nvim-lsp' }},
      after = "mason-lspconfig",
    })

    use({
      "nvimtools/none-ls.nvim",
      config = function()
        require("kdisneur.plugins.none-ls")
      end,
      requires = { "nvim-lua/plenary.nvim" },
    })


    use({
      {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        config = function()
          require('kdisneur.plugins.nvim-cmp')
        end,
        requires = {
          {
            'L3MON4D3/LuaSnip',
            event = 'InsertEnter',
            config = function()
              require('kdisneur.plugins.luasnip')
            end,
          },
        },
      },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
    })

    -- Theme
    use({
       'Mofiqul/vscode.nvim',
       config = function()
         require('kdisneur.plugins.vscode')
       end
     })
  end
})
