nnoremap <buffer> <Plug>(ElixirAlternateFile) :call <SID>alternate(expand("%"))
nnoremap <buffer> <Plug>(ElixirNextContainer) :call search('\<defmodule\>\\|\<defprotocol\>\\|\<defimpl\>', 'w')
nnoremap <buffer> <Plug>(ElixirNextFunction) :call search('\<def\>\\|\<defp\>\\|\<test\>\\|\<defmacro\>\\|\<defmacrop\>', 'w')
nnoremap <buffer> <Plug>(ElixirPreviousContainer) :call search('\<defmodule\>\\|\<defprotocol\>\\|\<defimpl\>', 'wb')
nnoremap <buffer> <Plug>(ElixirPreviousFunction) :call search('\<def\>\\|\<defp\>\\|\<test\>\\|\<defmacro\>\\|\<defmacrop\>', 'wb')

nmap <buffer> <leader>fsa <Plug>(ElixirAlternateFile)<cr>

nmap <silent> <buffer> [m <Plug>(ElixirPreviousFunction)<cr>
nmap <silent> <buffer> ]m <Plug>(ElixirNextFunction)<cr>
nmap <silent> <buffer> [[ <Plug>(ElixirPreviousContainer)<cr>
nmap <silent> <buffer> ]] <Plug>(ElixirNextContainer)<cr>
nnoremap <silent> <buffer> <C-]> :ALEGoToDefinition<cr>
nnoremap <silent> <buffer> <C-W><C-]> :ALEGoToDefinitionInVSplit<cr>

if exists('g:my_elixir_plugin_loaded')
  finish
end

function s:alternate(filename)
  if s:istestfile(a:filename)
    let l:sourcefile = substitute(substitute(a:filename, "test/", "lib/", ""), "_test.exs$", ".ex", "")
    call s:movetoalternate(l:sourcefile)
  else
    let l:testfile = substitute(substitute(a:filename, "\\\(web\\\|lib\\\)/", "test/", ""), ".ex$", "_test.exs", "")
    call s:movetoalternate(l:testfile)
  endif
endfunction

function s:scope(path)
  if isdirectory("apps")
    execute "CtrlP apps/*/" . a:path
  else
    execute "CtrlP " . a:path
  endif
endfunction

function s:istestfile(filename)
  return match(a:filename, "_test.exs$") >= 0
endfunction

function s:movetoalternate(filename)
  if filereadable(a:filename)
    execute "edit " . a:filename
  else
    echom "No alternative file found: " . a:filename
  endif
endfunction

function s:searchsyn(pattern, syn, flags, mode) abort
  let cnt = v:count1
  norm! m'
  if a:mode ==# 'v'
    norm! gv
  endif
  let i = 0
  while i < cnt
    let i = i + 1
    let line = line('.')
    let col  = col('.')
    let pos = search(a:pattern,'W'.a:flags)
    while pos != 0 && s:synname() !~# a:syn
      let pos = search(a:pattern,'W'.a:flags)
    endwhile
    if pos == 0
      call cursor(line,col)
      return
    endif
  endwhile
endfunction

function! s:synname() abort
  return synIDattr(synID(line('.'),col('.'),0),'name')
endfunction

let g:my_elixir_plugin_loaded = 1
