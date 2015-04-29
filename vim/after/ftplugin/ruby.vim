function! s:BuildRailsMigrationPath(...)
  return a:1 . "/" . strftime("%Y%m%d%H%M%S") . "_" . a:2 . ".rb"
endfunction

function! s:ObsessiveCompulsiveDisorder() range
  exec a:firstline . ',' . a:lastline . 'OldToNewHash'
  exec a:firstline . ',' . a:lastline . 'EasyAlign :'
endfunction

command! Debug :normal! mqOrequire 'pry'<cr>binding.pry<esc>`q:write<cr>
command! -complete=dir -nargs=+ RailsMigrationInPlace         execute "edit " . s:BuildRailsMigrationPath(<f-args>)
command! -complete=dir -nargs=+ RailsMigrationVerticalSplit   execute "rightbelow vsplit " . s:BuildRailsMigrationPath(<f-args>)
command! -complete=dir -nargs=+ RailsMigrationHorizontalSplit execute "split " . s:BuildRailsMigrationPath(<f-args>)

command! -range OldToNewHash <line1>,<line2>s/:\([a-zA-Z-0-9_]\+\)\s*=>/\1:/g
command! -range ObsessiveCompulsiveDisorder <line1>,<line2>call s:ObsessiveCompulsiveDisorder()
