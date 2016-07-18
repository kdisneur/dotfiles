if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

let mapleader=","
set backspace=indent,eol,start
set diffopt+=vertical
set tabstop=4
set shiftwidth=2
set expandtab
set nocompatible
set nobackup
set nowritebackup
set noswapfile
set nowrap
set history=50
set showcmd
set nohlsearch
set incsearch
set laststatus=2
set cursorline
set ruler
set spellfile=$HOME/.vim-spell-en.utf-8.add
set colorcolumn=120
set number

autocmd Filetype csv hi CSVColumnEven ctermfg=black ctermbg=lightgray
autocmd Filetype csv hi CSVColumnOdd  ctermfg=black
autocmd FileType markdown setlocal spell
autocmd FileType gitcommit setlocal spell
autocmd FileType eruby,html,slim setlocal cursorcolumn

syntax on
highlight Search ctermfg=Black ctermbg=LightYellow cterm=NONE

set splitbelow
set splitright

noremap <left> <nop>
noremap <right> <nop>
noremap <up> <nop>
noremap <down> <nop>
inoremap <esc> <nop>
inoremap jk <esc>
inoremap ;; <esc>:w<cr>a
noremap ;; <esc>:w<cr>
nmap <silent> <leader>md :!mkdir -p %:p:h<CR>
map <leader>ec :e <c-r>=expand("%:p:h") . "/" <cr>
map <leader>eh :sp <c-r>=expand("%:p:h") . "/" <cr>
map <leader>ev :vsp <c-r>=expand("%:p:h") . "/" <cr>
noremap <leader>fef :normal! gg=G``<CR>

if filereadable("~/.vimrc.local")
  source ~/.vimrc.local
endif
