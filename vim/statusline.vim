function! StatuslineMode(mode)
  return {
    \ 'n'  : 'NORMAL',
    \ 'no' : 'N·OPERATOR PENDING',
    \ 'v'  : 'VISUAL',
    \ 'V'  : 'V·LINE',
    \ '' : 'V·BLOCK',
    \ 's'  : 'SELECT',
    \ 'S'  : 'S·LINE',
    \ 'i'  : 'INSERT',
    \ 'R'  : 'REPLACE',
    \ 'Rv' : 'V·REPLACE',
    \ 'c'  : 'COMMAND',
    \ 'cv' : 'VIM EX',
    \ 'ce' : 'EX',
    \ 'r'  : 'PROMPT',
    \ 'rm' : 'MORE',
    \ 'r?' : 'CONFIRM',
    \ '!'  : 'SHELL',
    \ 't'  : 'TERMINAL'
  \}[a:mode]
endfunction

function! StatuslineIsReadOnly()
  if &readonly || !&modifiable
    return '🔒'
  else
    return ''
endfunction

function! StatuslineIsModified()
  if &modified
    return '+'
  else
    return ''
  endif
endfunction

set statusline=%#Error#\ %{StatuslineMode(mode())}\ %#statusLine#
set statusline+=\ %f%{StatuslineIsModified()}%{StatuslineIsReadOnly()}
set statusline+=%#StatusLine#%=%y\ \|
set statusline+=\ %{ALEGetStatusLine()}\ \|
set statusline+=\ %{(&fenc!=''?&fenc:&enc)}\[%{&ff}]
set statusline+=\ %l:%c/%L

