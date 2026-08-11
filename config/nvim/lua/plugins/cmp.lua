-- autocompletion
return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    { 'L3MON4D3/LuaSnip', opts = {} },
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
  },
  config = function()
    require('luasnip.loaders.from_lua').load({ paths = vim.fn.stdpath('config') .. '/luasnip/' })

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
  end
}
