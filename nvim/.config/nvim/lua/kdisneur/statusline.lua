function renderStatusLine()
  return '%f%m%r'
end

vim.o.statusline = "%!luaeval('renderStatusLine()')"
