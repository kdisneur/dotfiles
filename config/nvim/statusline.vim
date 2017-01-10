function! StatuslineMode(mode)
  return {
    \ 'n'  : 'NORMAL',
    \ 'no' : 'N·OPERATOR PENDING',
    \ 'v'  : 'V',
    \ 'V'  : 'V·LINE',
    \ '^V' : 'V·BLOCK',
    \ 's'  : 'SELECT',
    \ 'S'  : 'S·LINE',
    \ '^S' : 'S·BLOCK',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
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

set statusline=[%{StatuslineMode(mode())}]\ %f%{StatuslineIsReadOnly()}%=%y\ \|\ %{ALEGetStatusLine()}\ \|\ %{(&fenc!=''?&fenc:&enc)}\[%{&ff}]\ %l/%L

