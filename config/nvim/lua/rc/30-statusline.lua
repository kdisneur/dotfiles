function RenderStatusLine()
  return '%f%m%r'
end

vim.o.statusline = "%!luaeval('RenderStatusLine()')"
