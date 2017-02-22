function! s:plugOpen()
  let l:line       = getline('.')
  let l:repository = substitute(l:line, "[ ]*Plug[ ]\\\+['\"]\\\([^'\"]\\\+\\\).*", "\\1", "")
  let l:url        = "https://github.com/" . l:repository
  call netrw#BrowseX(l:url, 0)
endfunction

command! PlugOpen call s:plugOpen()
