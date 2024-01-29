local function map(mode, key, value)
	vim.keymap.set(mode, key, value, {silent = true})
end

map('n', '*', '*``')
map('n', '**', '*')
map('n', '<leader>ff', ':edit <c-r>=expand("%:p:h") . "/" <cr>') -- change to another file in same folder
map('n', '<leader>fj', ':edit <c-r>="~/.junks/" . strftime("%Y%m%d") . "." <cr>') -- open junk folder
map('n', '<leader>fR', ':Move <c-r>=expand("%:p:h")<cr>') -- rename/move file
map('n', '<leader>fd', ':Mkdir!<bar>:update<cr>') -- create parent folders
map('n', '<leader>fD', ':Remove<cr>') -- remove current file
map('n', '[<space>', 'O<esc>j') -- insert line above
map('n', ']<space>', 'o<esc>k') -- insert line below
map('n', '<leader>w', ':update<cr>')
