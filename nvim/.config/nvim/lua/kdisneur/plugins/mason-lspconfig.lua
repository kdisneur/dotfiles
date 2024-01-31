local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup()

---Common perf related flags for all the LSP servers
local flags = {
  allow_incremental_sync = true,
  debounce_text_changes = 200,
}

local function on_attach(_client, buf)
  local opts = { buffer = buf }

  vim.api.nvim_buf_set_option(buf, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- vim.keymap.set('n', '<leader>ld',  vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', '<C-h>', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>li', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, opts)
  vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
  -- vim.keymap.set('n', '<leader>wa',  vim.lsp.buf.add_workspace_folder, opts)
  -- vim.keymap.set('n', '<leader>wr',  vim.lsp.buf.remove_workspace_folder, opts)
  -- vim.keymap.set('n', '<leader>wl',  print(vim.inspect(vim.lsp.buf.list_workspace_folders(), opts)
  vim.keymap.set('n', '<leader>lc', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>lt', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<leader>lR', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']g', vim.diagnostic.goto_next, opts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

mason_lspconfig.setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name)
    require("lspconfig")[server_name].setup({
      flags = flags,
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,
  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `rust_analyzer`:
  -- ["rust_analyzer"] = function ()
  --   require("rust-tools").setup {}
  -- end
  ["rust_analyzer"] = function()
    require("lspconfig")["rust_analyzer"].setup({
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
