function! StatuslineIsReadOnly()
  if &readonly || !&modifiable
    return '🔒'
  else
    return ''
endfunction

function! StatuslineIsModified()
  if &modified
    return '+'
  else
    return ''
  endif
endfunction

set statusline=\ %f%{StatuslineIsModified()}%{StatuslineIsReadOnly()}
