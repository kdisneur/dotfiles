local lsp = require('lspconfig')

local function mappings(buf)
  local opts = { buffer = buf }

  vim.api.nvim_buf_set_option(buf, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- vim.keymap.set('n', '<leader>ld',  vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', '<leader>ld',  vim.lsp.buf.definition, opts)
  vim.keymap.set('n', '<C-h>',  vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>li',  vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<leader>lr',  vim.lsp.buf.references, opts)
  vim.keymap.set('i', '<C-h>',  vim.lsp.buf.signature_help, opts)
  -- vim.keymap.set('n', '<leader>wa',  vim.lsp.buf.add_workspace_folder, opts)
  -- vim.keymap.set('n', '<leader>wr',  vim.lsp.buf.remove_workspace_folder, opts)
  -- vim.keymap.set('n', '<leader>wl',  print(vim.inspect(vim.lsp.buf.list_workspace_folders(), opts)
  vim.keymap.set('n', '<leader>lc',  vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>lt',  vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<leader>lR',  vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>le',  vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[g',  vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']g',  vim.diagnostic.goto_next, opts)
end

---Common perf related flags for all the LSP servers
local flags = {
  allow_incremental_sync = true,
  debounce_text_changes = 200,
}

local function on_attach(client, buf)
  mappings(buf)
end

---Common capabilities including lsp snippets and autocompletion
-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lsp.rust_analyzer.setup({
  flags = flags,
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = {'rust-analyzer'},
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
  },
})

local servers = {
  'golangci_lint_ls', -- Go linter
  'gopls', -- Go
  'clangd', -- C
  'tsserver', -- Typescript
}


local conf = {
  flags = flags,
  capabilities = capabilities,
  on_attach = on_attach,
}


for _, server in ipairs(servers) do
  lsp[server].setup(conf)
end
vim.cmd [[autocmd BufWritePre * :lua vim.lsp.buf.format()]]
