if exists('g:my_vimpack_plugin_loaded')
  finish
end

function s:packOpen()
  let l:line       = getline('.')
  let l:repository = substitute(l:line, "[ ]*\\\(onstart\\\|ondemand\\\)[ ]\\\+['\"]\\\([^'\"]\\\+\\\).*", "\\2", "")
  let l:url        = "https://github.com/" . l:repository
  call netrw#BrowseX(l:url, 0)
endfunction

command PackOpen call <SID>packOpen()

let g:my_vimpack_plugin_loaded = 1
