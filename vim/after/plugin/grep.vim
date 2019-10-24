if executable('ag')
  set grepprg=ag\ --case-sensitive\ --vimgrep\ --column\ $*
  set grepformat=%f:%l:%c:%m
endif
