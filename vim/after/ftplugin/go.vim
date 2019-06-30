if exists('g:my_go_plugin')
  finish
endif

function! s:gomodimport()
  let l:base=system("~/.bin/current_go_import.sh")
  let l:cleanedBase=substitute(l:base, '\n', "", "g")
  return printf('%s/', l:cleanedBase)
endfunction

function! s:istestfile(filename)
  return match(a:filename, "_test.go$") >= 0
endfunction

function! s:movetoalternate(filename)
  if filereadable(a:filename)
    execute "edit " . a:filename
  else
    echom "No alternative file found: " . a:filename
  endif
endfunction

function! s:alternate(filename)
  if s:istestfile(a:filename)
    let l:sourcefile = substitute(a:filename, "_test.go$", ".go", "")
    call s:movetoalternate(l:sourcefile)
  else
    let l:testfile = substitute(a:filename, ".go$", "_test.go", "")
    call s:movetoalternate(l:testfile)
  endif
endfunction

command! GAlternate call s:alternate(expand("%"))

let g:my_go_plugin = 1

nnoremap <silent> fsa :GAlternate<cr>
nnoremap <leader>gi :GoImport
nnoremap <leader>gI :GoImport <c-r>=<SID>gomodimport()<cr>
nnoremap <silent> <buffer> <C-]> :ALEGoToDefinition<cr>
