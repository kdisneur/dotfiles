autocmd BufWritePost,BufRead *.sh silent !ctags %

nnoremap <Plug>(BashNextFunction) :call search('^\([a-zA-Z0-9_]\+()\\|function [a-zA-Z0-9]\+\(()\)\{0,1\}\)\s\+{', 'w')
nnoremap <Plug>(BashPreviousFunction) :call search('^\([a-zA-Z0-9_]\+()\\|function [a-zA-Z0-9]\+\(()\)\{0,1\}\)\s\+{', 'wb')

nmap <silent> ]m <Plug>(BashNextFunction)<cr>
nmap <silent> [m <Plug>(BashPreviousFunction)<cr>
