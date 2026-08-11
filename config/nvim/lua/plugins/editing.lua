return {
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

  -- ability to edit quickfix list and still jump to files
  'itchyny/vim-qfedit',
}
