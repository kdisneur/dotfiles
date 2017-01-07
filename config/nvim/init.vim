if filereadable(expand("~/.config/nvim/bundles.vim"))
  source ~/.config/nvim/bundles.vim
endif

if filereadable("/usr/local/bin/python")
  let g:python_host_prog = "/usr/local/bin/python"
end

let mapleader="\<Space>"

set backspace=indent,eol,start
set colorcolumn=120
" https://robots.thoughtbot.com/vim-you-complete-me#the-configurations
set complete=.,b,u,]
set cursorline
set diffopt+=vertical
set expandtab
set formatoptions-=t "prevent auto word wrapping
set history=500
set incsearch
set laststatus=2
set nobackup
set nocompatible
set nohlsearch
set noswapfile
set nowrap
set nowritebackup
set path=.,**
set wildignore+=**/.git/**
set wildignore+=**/_build/**
set wildignore+=**/deps/**
set wildignore+=**/node_modules/**
set wildignore+=**/*.jpg,**/*.JPG,**/*.png,**/*.PNG,**/*.pdf,**/*.PDF
set relativenumber
set ruler
set shiftwidth=2
set showcmd
set spellfile=$HOME/.vim-spell-en.utf-8.add
set tabstop=4
set textwidth=120
set wildmode=full

colorscheme one

autocmd BufRead,BufNewFile *.slim set filetype=slim
autocmd Filetype csv hi CSVColumnEven ctermfg=black ctermbg=lightgray
autocmd Filetype csv hi CSVColumnOdd  ctermfg=black
autocmd FileType markdown setlocal spell
autocmd FileType gitcommit setlocal spell
autocmd FileType eruby,html,slim setlocal cursorcolumn
autocmd BufWritePre * FixWhitespace
autocmd BufWritePost * Neomake
autocmd BufEnter * Neomake
autocmd Filetype elm setlocal shiftwidth=4

command! FRSpelling setlocal spell spelllang=fr_fr
command! GBSpelling setlocal spell spelllang=en_gb
command! USSpelling setlocal spell spelllang=en_us

syntax on
highlight Search ctermfg=Black ctermbg=LightYellow cterm=NONE

set splitbelow
set splitright

" {{{ Mapping
mapclear

noremap <left> <nop>
noremap <right> <nop>
noremap <up> <nop>
noremap <down> <nop>
inoremap <esc> <nop>
inoremap jk <esc>
nnoremap *`` *
nnoremap ** *

" {{{ motions
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" }}}

" {{{ File management - f
  nnoremap <silent> <leader>fd :!mkdir -p %:p:h<cr>
  nnoremap <leader>ff :edit <c-r>=expand("%:p:h") . "/" <cr>
  nnoremap <leader>fj :edit <c-r>= '~/.config/nvim/junks/' . strftime('%Y%m%d') . '.' <cr>
  nnoremap <leader>fD :Remove<cr>
  nnoremap <leader>fR :Move <c-r>=expand("%:p:h")<cr>
" }}}

" {{{ Code - c
  noremap <leader>cc :Commentary<cr>
  nmap <leader>cd <Plug>DashSearch
" }}}

" {{{ Tests & Texts - t
  nmap <leader>tsg <Plug>CtrlSFQuickfixPrompt
  nmap <leader>tsc <Plug>CtrlSFQuickfixPwordPath
  nmap <leader>trg <Plug>CtrlSFPrompt
  nmap <leader>trc <Plug>CtrlSFCwordPath
  nnoremap <silent> <leader>ttt :TestNearest<cr>
  nnoremap <silent> <leader>ttb :TestFile<cr>
  nnoremap <silent> <leader>tta :TestSuite<cr>
  nnoremap <silent> <leader>ttr :TestLast<cr>
  nnoremap <silent> <leader>ttg :TestVisit<cr>
" }}}

if executable('ag')
  " let grepprg = 'ag --nogroup --nocolor'
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

" Abolish
let g:abolish_no_mappings = 1

" Airline
let g:airline_theme = 'one'
let g:airline_left_sep = ' '
let g:airline_right_sep = ' '

" Ag
let g:ag_working_path_mode = "r"

" Elm
let g:elm_format_autosave = 1

" Neomake
function! neomake#makers#ft#elixir#credo() abort
  return {
    \ 'exe': 'mix',
    \ 'args': ['credo', 'list', '%:p', '--format=oneline'],
    \ 'errorformat': '[%t] %. %f:%l:%c %m'
    \ }
endfunction
function! neomake#makers#ft#elixir#mix() abort
  return {
    \ 'exe' : 'neomake_mix_compile',
    \ 'args': [],
    \ 'cwd': getcwd(),
    \ 'errorformat':
      \ '%Wwarning: %m,%Z%f:%l'
    \ }
endfunction
let g:neomake_error_sign = { 'text': '⊗', 'texthl': 'ErrorMsg' }
let g:neomake_warning_sign = { 'text': '⚠', 'texthl': 'WarningMsg' }
let g:neomake_elixir_enabled_makers = ['mix', 'credo', 'dogma']

" Test
let test#strategy = "dispatch"
let test#filename_modifier = ':p'

" Markdown
let g:vim_markdown_folding_disabled = 1

" Syntastic
let g:syntastic_always_populate_loc_list = 1

" Ultisnips
let g:UltiSnipsSnippetsDir = $HOME."/.config/nvim/UltiSnips"
let g:UltiSnipsSnippetDirectories = ["UltiSnips"]
let g:UltiSnipsExpandTrigger="<c-e>"

" YouCompleteMe
let g:ycm_use_ultisnips_completer = 1

if filereadable("~/.vimrc.local")
  source ~/.vimrc.local
endif
