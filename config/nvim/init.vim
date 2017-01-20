if filereadable(expand("~/.config/nvim/bundles.vim"))
  source ~/.config/nvim/bundles.vim
endif

if filereadable("/usr/local/bin/python")
  let g:python_host_prog = "/usr/local/bin/python"
end

let mapleader="\<Space>"

set inccommand=nosplit
set backspace=indent,eol,start
set colorcolumn=120
set complete=],.,b,u
set cursorline
set conceallevel=1
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

syntax on

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

autocmd BufRead,BufNewFile *.slim set filetype=slim
autocmd BufRead,BufNewFile *.ex,*.exs,*.eex set filetype=elixir
autocmd Filetype csv hi CSVColumnEven ctermfg=black ctermbg=lightgray
autocmd Filetype csv hi CSVColumnOdd  ctermfg=black
autocmd FileType markdown setlocal spell
autocmd FileType gitcommit setlocal spell
autocmd FileType eruby,html,slim setlocal cursorcolumn
autocmd BufWritePre * FixWhitespace
autocmd Filetype elm setlocal shiftwidth=4
autocmd BufWinEnter * nested if exists('syntax_on') && ! exists('b:current_syntax') | syntax enable | endif

command! Francais setlocal spell spelllang=fr_fr
command! British setlocal spell spelllang=en_gb
command! American setlocal spell spelllang=en_us

set splitbelow
set splitright

if filereadable(expand("~/.config/nvim/statusline.vim"))
  source ~/.config/nvim/statusline.vim
endif

" {{{ Mapping
noremap <left> <nop>
noremap <right> <nop>
noremap <up> <nop>
noremap <down> <nop>
inoremap <esc> <nop>
inoremap jk <esc>
nnoremap *`` *
nnoremap ** *

" {{{ Motions
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
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

" Abolish
let g:abolish_no_mappings = 1

" Ag
let g:ag_working_path_mode = "r"

" Ale
let g:ale_sign_column_always = 1
let g:ale_sign_error = '⊗'
let g:ale_sign_warning = '⚠'
let g:ale_statusline_format = ['⊗ %d', '⚠ %d', '✓']

" Elm
let g:elm_format_autosave = 1

" Deoplete
let g:deoplete#enable_at_startup = 1

" Test
let test#strategy = "dispatch"
let test#filename_modifier = ':p'

" Ultisnips
let g:UltiSnipsSnippetsDir = $HOME."/.config/nvim/UltiSnips"
let g:UltiSnipsSnippetDirectories = ["UltiSnips"]
let g:UltiSnipsExpandTrigger="<c-e>"

if filereadable("~/.vimrc.local")
  source ~/.vimrc.local
endif
