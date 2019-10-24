if exists('g:my_prose_plugin_loaded')
  finish
end

function Prose()
  setlocal wrap " soft wrap content
  setlocal breakindent " follow indentation when wrapping
  setlocal linebreak " only breaks on specific characters
  setlocal textwidth=0 wrapmargin=0 " do not insert newlines automatically on insert mode

  " force top correction on most recent misspelling
  nnoremap <buffer> <c-s> [s1z=<c-o>
  inoremap <buffer> <c-s> <c-g>u<Esc>[s1z=`]A<c-g>u
endfunction

command! American setlocal spell spelllang=en_us
command! British setlocal spell spelllang=en_gb
command! Francais setlocal spell spelllang=fr_fr

let g:my_prose_plugin_loaded = 1
