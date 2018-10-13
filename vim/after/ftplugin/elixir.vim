if exists('g:my_elixir_plugin')
  finish
endif

function s:hexdoc()
  let l:package = expand("<cword>")
  let l:url     = "https://hex.pm/packages/" . l:package
  call netrw#BrowseX(l:url, 0)
endfunction

function! s:scope(path)
  if isdirectory("apps")
    execute "CtrlP apps/*/" . a:path
  else
    execute "CtrlP " . a:path
  endif
endfunction

function! s:istestfile(filename)
  return match(a:filename, "_test.exs$") >= 0
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
    let l:sourcefile = substitute(substitute(a:filename, "test/", "lib/", ""), "_test.exs$", ".ex", "")
    call s:movetoalternate(l:sourcefile)
  else
    let l:testfile = substitute(substitute(a:filename, "\\\(web\\\|lib\\\)/", "test/", ""), ".ex$", "_test.exs", "")
    call s:movetoalternate(l:testfile)
  endif
endfunction

function! s:searchsyn(pattern, syn, flags, mode) abort
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

command! EController call s:controller()
command! ECommand call s:command()
command! EQuery call s:query()
command! EModel call s:model()
command! EService call s:service()
command! EView call s:view()
command! EAlternate call s:alternate(expand("%"))
command! HexDoc call s:hexdoc()
command! NextContainer silent! /\<defmodule\>\|\<defprotocol\>\|\<defimpl\>
command! NextFunction silent! /\<def\>\|\<defp\>\|\<defmacro\>\|\<defmacrop\>
command! PreviousFunction silent! ?\<def\>\|\<defp\>\|\<defmacro\>\|\<defmacrop\>
command! PreviousContainer silent! ?\<defmodule\>\|\<defprotocol\>\|\<defimpl\>

nnoremap <silent> fsa :EAlternate<cr>

let g:my_elixir_plugin = 1

nnoremap <silent> <buffer> [m :PreviousFunction<cr>
nnoremap <silent> <buffer> ]m :NextFunction<cr>
nnoremap <silent> <buffer> [[ :PreviousContainer<cr>
nnoremap <silent> <buffer> ]] :NextContainer<cr>
