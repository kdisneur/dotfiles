nnoremap <Plug>(NextContainer) :call search('/\<class\>', 'w')
nnoremap <Plug>(NextFunction) :call search('/\<function\>\\|=>', 'w')
nnoremap <Plug>(PreviousFunction) :call search('\<function\>\\|=>', 'wb')
nnoremap <Plug>(PreviousContainer) :call search('\<class\>', 'wb')

nmap <silent> <buffer> [m <Plug>(PreviousFunction)<cr>
nmap <silent> <buffer> ]m <Plug>(NextFunction)<cr>
nmap <silent> <buffer> [[ <Plug>(PreviousContainer)<cr>
nmap <silent> <buffer> ]] <Plug>(NextContainer)<cr>
nnoremap <silent> <buffer> <C-]> :ALEGoToDefinition<cr>
