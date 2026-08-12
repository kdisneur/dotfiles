-- LSP Configuration
return {
  'neovim/nvim-lspconfig',
  -- capabilities below come from this; naming it here rather than relying on
  -- lazy loading it through the require keeps the ordering explicit
  dependencies = { 'hrsh7th/cmp-nvim-lsp' },
  config = function()
    local flags = {
      allow_incremental_sync = true,
      debounce_text_changes = 200,
    }

    -- <C-f> for document symbols is a global mapping in telescope.lua, so it is
    -- deliberately not repeated here
    local function on_attach(_, buf)
      vim.bo[buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    end

    -- Without this servers are never told about nvim-cmp's extras, snippet
    -- support in particular, and completion is quietly degraded.
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    vim.lsp.config('*', {
      flags = flags,
      on_attach = on_attach,
      capabilities = capabilities,
    })

    vim.lsp.config('rust_analyzer', {
      settings = {
        ['rust-analyzer'] = {
          check = { command = 'clippy' }, -- run clippy instead of cargo check on save
          cargo = { targetDir = true },   -- keep LSP artifacts out of target/ to avoid lock contention
        },
      },
    })

    vim.cmd [[autocmd BufWritePre * :lua vim.lsp.buf.format()]]

    -- update-system installs all of these on every machine, so they are enabled
    -- everywhere. Names are nvim-lspconfig's, not the binary names. A server
    -- whose binary is absent simply never attaches. shellcheck is missing on
    -- purpose: it is a linter bashls shells out to, not a language server.
    vim.lsp.enable({
      'bashls',
      'clangd',
      'golangci_lint_ls',
      'gopls',
      'lua_ls',
      'pylsp',
      'rust_analyzer',
    })

    vim.api.nvim_create_autocmd({ 'LspAttach' }, {
      -- This is due to how configurations are merged. The on_attach function
      -- is the one from lspconfig instead of mine
      -- https://www.reddit.com/r/neovim/comments/1k6lq7q/vimlspconfig_on_attach_on_attach_doesnt_work_with/
      -- nvim-lspconfig's own lsp/clangd.lua sets on_attach, which wins over the
      -- one in vim.lsp.config('*'), so this stays.
      pattern = { '*.c', '*.h' },
      callback = function(args)
        on_attach(0, args.buf)
      end,
    })
  end
}
