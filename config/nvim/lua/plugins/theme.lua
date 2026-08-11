-- theme
return {
  'Mofiqul/vscode.nvim',
  lazy = false,
  priority = 1000, -- load before everything else so no other plugin renders unthemed
  config = function()
    require('vscode').setup({
      transparent = true,
      italic_comments = true,
    })

    vim.cmd.colorscheme('vscode')
  end
}
