-- better highlights / code navigation
return {
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
  },
  config = function()
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
  end
}
