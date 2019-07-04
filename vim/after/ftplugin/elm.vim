setlocal shiftwidth=4

command! NextContainer silent! /\<module\>
command! NextFunction silent! /^\w\+\(\w\|\s\)\+=
command! PreviousContainer silent! ?\<module\>
command! PreviousFunction silent! ?^\w\+\(\w\|\s\)\+=

nnoremap <silent> <buffer> [m :PreviousFunction<cr>
nnoremap <silent> <buffer> ]m :NextFunction<cr>
nnoremap <silent> <buffer> [[ :PreviousContainer<cr>
nnoremap <silent> <buffer> ]] :NextContainer<cr>
