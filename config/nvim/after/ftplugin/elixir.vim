function! s:scope(path)
  if isdirectory("apps")
    execute "CtrlP apps/*/" . a:path
  else
    execute "CtrlP " . a:path
  endif
endfunction

function! s:command()
  call s:scope("web/commands")
endfunction

function! s:controller()
  call s:scope("web/controllers")
endfunction

function! s:model()
  call s:scope("web/models")
endfunction
function! s:query()
  call s:scope("web/queries")
endfunction

function! s:view()
  call s:scope("web/views")
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
command! EView call s:view()

nnoremap <silent> fsc :EController<cr>
nnoremap <silent> fsk :ECommand<cr>
nnoremap <silent> fsq :EQuery<cr>
nnoremap <silent> fsm :EModel<cr>
nnoremap <silent> fsv :EView<cr>

nnoremap <silent> <buffer> [m :<C-U>call <SID>searchsyn('\<\%(def\<Bar>defp\<Bar>defmacro\<Bar>defmacrop\)\>','elixirDefine\<Bar>elixirPrivateDefine\<Bar>elixirMacroDefine\<Bar>elixirPrivateMacroDefine','b','n')<CR>
nnoremap <silent> <buffer> ]m :<C-U>call <SID>searchsyn('\<\%(def\<Bar>defp\<Bar>defmacro\<Bar>defmacrop\)\>','elixirDefine\<Bar>elixirPrivateDefine\<Bar>elixirMacroDefine\<Bar>elixirPrivateMacroDefine','','n')<CR>
nnoremap <silent> <buffer> [[ :<C-U>call <SID>searchsyn('\<\%(defmodule\<Bar>defprotocol\<Bar>defimpl\)\>','elixirModuleDefine\<Bar>elixirProtocolDefine\<Bar>elixirImplDefine','b','n')<CR>
nnoremap <silent> <buffer> ]] :<C-U>call <SID>searchsyn('\<\%(defmodule\<Bar>defprotocol\<Bar>defimpl\)\>','elixirModuleDefine\<Bar>elixirProtocolDefine\<Bar>elixirImplDefine','','n')<CR>
