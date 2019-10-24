nmap <silent> <buffer> <leader>do <Plug>(DockerfileOpenImage)<cr>
nnoremap <buffer> <Plug>(DockerfileOpenImage) :call <SID>dockerOpen()

if exists('g:my_dockerfile_plugin_loaded')
  finish
end

function! s:dockerOpen()
  let l:line       = getline('.')
  let l:repository = substitute(l:line, "[ ]*FROM[ ]\\\+\\\([^: ]\\\+\\\).*", "\\1", "")
  if matchstr(l:repository, '/') == ''
    let l:repository = '_/' . l:repository
  end

  let l:url        = "https://hub.docker.com/r/" . l:repository
  call netrw#BrowseX(l:url, 0)
endfunction

let g:my_dockerfile_plugin_loaded = 1
