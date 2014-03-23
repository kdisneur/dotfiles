augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END

let mapleader=","
set backspace=indent,eol,start
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
set incsearch
set laststatus=2
set cursorline
set ruler
set colorcolumn=120
set number
set term=xterm-256color
autocmd Filetype csv hi CSVColumnEven   ctermfg=black       ctermbg=lightgray
autocmd Filetype csv hi CSVColumnOdd    ctermfg=black

syntax on
highlight Search ctermfg=Black ctermbg=LightYellow cterm=NONE

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

noremap <left> <nop>
noremap <right> <nop>
noremap <up> <nop>
noremap <down> <nop>
inoremap <esc> <nop>
inoremap jk <esc>
nmap <silent> <F4> :set invpaste<CR>:set paste?<CR>
imap <silent> <F4> <ESC>:set invpaste<CR>:set paste?<CR>
nmap <leader>pr :CodeReview https://github.com/
nmap <leader>hs :set hlsearch! hlsearch?<CR>
nmap <silent> <leader>md :!mkdir -p %:p:h<CR>
nmap <silent> <leader>fc <esc>/\v^[<=>]{7}( .*\|$)<cr>
map <leader>ec :e <c-r>=expand("%:p:h") . "/" <cr>
map <leader>eh :sp <c-r>=expand("%:p:h") . "/" <cr>
map <leader>ev :vsp <c-r>=expand("%:p:h") . "/" <cr>
nnoremap <leader>fef :normal! gg=G``<CR>
map <Leader>/ :TComment<cr>
vmap <Leader>/ :TComment<cr>gv<esc>

inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

inoremap (      ()<Left>
inoremap (<CR>  (<CR>)<Esc>O
inoremap ((     (
inoremap ()     ()

inoremap [      []<Left>
inoremap [<CR>  [<CR>]<Esc>O
inoremap [[     [
inoremap []     []

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Airline {{{
let g:airline_powerline_fonts = 1
" }}}

" GitGutter {{{
highlight clear SignColumn
let g:gitgutter_escape_grep = 1
highlight GitGutterAdd ctermfg=28
highlight GitGutterChange ctermfg=100
highlight GitGutterDelete ctermfg=131

" }}}

" CtrlP  {{{
let g:ctrlp_dotfiles = 1
let g:ctrlp_follow_symlinks = 2
" }}}

" NERDTree {{{
let NERDTreeShowHidden=1
map <Leader>n :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" }}}

" Trailing Whitespace {{{
autocmd BufWritePre * :FixWhitespace
let g:DeleteTrailingWhitespace = 1
let g:DeleteTrailingWhitespace_Action = 'delete'
" }}}

" Syntastic {{{
let g:syntastic_check_on_open=1
" }}}

if filereadable("~/.vimrc.local")
  source ~/.vimrc.local
endif
