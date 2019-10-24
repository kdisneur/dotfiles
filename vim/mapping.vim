nnoremap * *``
nnoremap ** *
nnoremap gp `[v`]

" Ale Mapping
nnoremap <silent> <leader>aj :ALENext<cr>
nnoremap <silent> <leader>ak :ALEPrevious<cr>


" Search
nnoremap <leader>s :silent! grep!<space>

" File Management
nnoremap <leader>fd :Mkdir! <bar> :write <cr>
nnoremap <leader>ff :edit <c-r>=expand("%:p:h") . "/" <cr>
nnoremap <leader>fj :edit <c-r>= '~/.vim/junks/' . strftime('%Y%m%d') . '.' <cr>
nnoremap <leader>fD :Remove<cr>
nnoremap <leader>fR :Move <c-r>=expand("%:p:h")<cr>
