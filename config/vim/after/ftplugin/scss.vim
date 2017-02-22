function! s:ObsessiveCompulsiveDisorder() range
  exec a:firstline . ',' . a:lastline . 'sort'
  exec a:firstline . ',' . a:lastline . 'EasyAlign :'
endfunction

command! -range ObsessiveCompulsiveDisorder <line1>,<line2>call s:ObsessiveCompulsiveDisorder()
