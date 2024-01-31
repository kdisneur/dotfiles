local lsp = require('lspconfig')
vim.cmd [[autocmd BufWritePre * :lua vim.lsp.buf.format()]]
