augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

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
colorscheme badwolf
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
nmap <F4> :set invpaste<cr>:set paste?<cr>
imap <F4> <esc>:set invpaste<cr>:set paste?<cr>
inoremap ;; <esc>:w<cr>a
noremap ;; <esc>:w<cr>
inoremap "" <esc>:q<cr>
noremap "" <esc>:q<cr>
inoremap \\ <esc>:x<cr>
noremap \\ <esc>:x<cr>
nmap <leader>pr :CodeReview https://github.com/
nmap <silent> <leader>md :!mkdir -p %:p:h<CR>
map <leader>ec :e <c-r>=expand("%:p:h") . "/" <cr>
map <leader>eh :sp <c-r>=expand("%:p:h") . "/" <cr>
map <leader>ev :vsp <c-r>=expand("%:p:h") . "/" <cr>
nmap <leader>rmc :RailsMigrationInPlace <c-r>=expand("%:p:h") . "/"<cr>
nmap <leader>rmh :RailsMigrationHorizontalSplit <c-r>=expand("%:p:h") . "/"<cr>
nmap <leader>rmv :RailsMigrationVerticalSplit <c-r>=expand("%:p:h") . "/"<cr>
nnoremap <leader>c :VimuxPromptCommand<cr>
noremap <leader>fef :normal! gg=G``<CR>
nnoremap <leader>\ :Ag<space>
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
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
let g:ctrlp_use_caching = 0
let g:ctrlp_working_path_mode = 'a'
" }}}

" NERDTree {{{
let NERDTreeShowHidden=1
map <Leader>n :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" }}}

" Numbers {{{
let g:enable_numbers = 0
nnoremap <F3> :NumbersToggle<CR>
" }}}

" Trailing Whitespace {{{
autocmd BufWritePre * :FixWhitespace
let g:DeleteTrailingWhitespace = 1
let g:DeleteTrailingWhitespace_Action = 'delete'
" }}}

" Syntastic {{{
let g:syntastic_check_on_open=1
" }}}

" Vroom {{{
let g:vroom_use_vimux = 1
" }}}

if filereadable("~/.vimrc.local")
  source ~/.vimrc.local
endif
