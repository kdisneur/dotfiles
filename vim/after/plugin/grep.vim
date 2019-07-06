if executable('ag')
  set grepprg =ag\ --vimgrep\ --column
  set grepformat=%f:%l:%c:%m
endif

function s:Grep(...) abort
  execute 'silent grep! ' . join(a:000, ' ') . ' | cwindow | redraw!'
endfunction

command -complete=dir -nargs=+ Grep call s:Grep(<q-args>)
