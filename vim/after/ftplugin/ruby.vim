function! s:BuildRailsMigrationPath(...)
  return a:1 . "/" . strftime("%Y%m%d%H%M%S") . "_" . a:2 . ".rb"
endfunction

command! Debug :normal! mqOrequire 'pry'<cr>binding.pry<esc>`q:write<cr>
command! -complete=dir -nargs=+ RailsMigrationInPlace         execute "edit " . s:BuildRailsMigrationPath(<f-args>)
command! -complete=dir -nargs=+ RailsMigrationVerticalSplit   execute "rightbelow vsplit " . s:BuildRailsMigrationPath(<f-args>)
command! -complete=dir -nargs=+ RailsMigrationHorizontalSplit execute "split " . s:BuildRailsMigrationPath(<f-args>)

noremap <Leader>ro :s/:\([a-zA-Z-0-9_]\+\)\s*=>/\1:/g<cr>
