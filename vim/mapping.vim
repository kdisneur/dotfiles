inoremap jk <esc>
nnoremap * *``
nnoremap ** *
nnoremap gp `[v`]

" Ale Mapping
nnoremap <silent> <leader>aj :ALENext<cr>
nnoremap <silent> <leader>ak :ALEPrevious<cr>

" File management
nnoremap <silent> <leader>fd :!mkdir -p "%:p:h"<cr>
nnoremap <leader>ff :edit <c-r>=expand("%:p:h") . "/" <cr>
nnoremap <leader>fj :edit <c-r>= '~/.vim/junks/' . strftime('%Y%m%d') . '.' <cr>
nnoremap <leader>fD :Remove<cr>
nnoremap <leader>fR :Move <c-r>=expand("%:p:h")<cr>

" Tests & Texts
onoremap il :normal ^vg_<cr>
onoremap al :normal ^v$<cr>
xnoremap il :normal ^vg_<cr>
xnoremap al :normal ^v$<cr>
