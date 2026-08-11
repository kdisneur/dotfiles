-- LSP Configuration
return {
  'neovim/nvim-lspconfig',
  config = function()
    vim.lsp.config('rust_analyzer', {
      settings = {
        ['rust-analyzer'] = {
          check = { command = 'clippy' }, -- run clippy instead of cargo check on save
          cargo = { targetDir = true },   -- keep LSP artifacts out of target/ to avoid lock contention
        },
      },
    })

    vim.cmd [[autocmd BufWritePre * :lua vim.lsp.buf.format()]]

    vim.lsp.enable({ 'clangd', 'gopls', 'rust_analyzer' })
  end
}
