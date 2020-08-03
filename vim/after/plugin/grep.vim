if executable('ag')
  set grepprg=ag\ --hidden\ --case-sensitive\ --vimgrep\ --column\ $*
  set grepformat=%f:%l:%c:%m
endif
