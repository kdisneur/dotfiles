local function move_to_file(filename)
  if vim.fn.filereadable(filename) ~= 0 then
    vim.cmd("edit " .. filename)
  else
    print("alternative file not found: " .. filename)
  end
end

function find_alternative_file(filename)
  if string.match(filename, "_test.go$") then
    local sourcefile = string.gsub(filename, "_test.go$", ".go")
    move_to_file(sourcefile)
  else
    local testfile = string.gsub(filename, ".go$", "_test.go")
    move_to_file(testfile)
  end
end

vim.keymap.set('n', '<leader>fsa', function() find_alternative_file(vim.fn.expand("%")) end)
