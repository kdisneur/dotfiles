command! NextContainer silent! /\<class\>
command! NextFunction silent! /\<function\>\|=>
command! PreviousFunction silent! ?\<function\>\|=>
command! PreviousContainer silent! ?\<class\>

nnoremap <silent> <buffer> [m :PreviousFunction<cr>
nnoremap <silent> <buffer> ]m :NextFunction<cr>
nnoremap <silent> <buffer> [[ :PreviousContainer<cr>
nnoremap <silent> <buffer> ]] :NextContainer<cr>
