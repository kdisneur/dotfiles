setlocal shiftwidth=4

nnoremap <Plug>(ElmNextContainer) :call search('\<module\>', 'w')
nnoremap <Plug>(ElmNextFunction) :call search('^\w\+\(\w\\|\s\)\+=', 'w')
nnoremap <Plug>(ElmPreviousContainer) :call search('\<module\>', 'wb')
nnoremap <Plug>(ElmPreviousFunction) :call search('^\w\+\(\w\\|\s\)\+=', 'wb')

nmap <silent> <buffer> [m <Plug>(ElmPreviousFunction)<cr>
nmap <silent> <buffer> ]m <Plug>(ElmNextFunction)<cr>
nmap <silent> <buffer> [[ <Plug>(ElmPreviousContainer)<cr>
nmap <silent> <buffer> ]] <Plug>(ElmNextContainer)<cr>
