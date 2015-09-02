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

colorscheme soda

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
nmap <leader>rmc :RailsMigrationInPlace <c-r>=expand("%:p:h") . "/"<cr>
nmap <leader>rmh :RailsMigrationHorizontalSplit <c-r>=expand("%:p:h") . "/"<cr>
nmap <leader>rmv :RailsMigrationVerticalSplit <c-r>=expand("%:p:h") . "/"<cr>
nnoremap <leader>rcpc :RConvertPostConditional<cr>
vnoremap <leader>rec  :RExtractConstant<cr>
vnoremap <leader>rrlv :RRenameLocalVariable<cr>
vnoremap <leader>rem  :RExtractMethod<cr>
nnoremap <leader>c :VimuxPromptCommand<cr>
noremap <leader>fef :normal! gg=G``<CR>
nnoremap <leader>\ :Ag<space>
map <Leader>/ :TComment<cr>
vmap <Leader>/ :TComment<cr>gv<esc>
vmap <Leader>t <Plug>(EasyAlign)
vmap <Leader>ocd :ObsessiveCompulsiveDisorder<cr>
noremap <Leader>ro :OldToNewHash<cr>
nmap <silent> <leader>tt :TestNearest<CR>
nmap <silent> <leader>tT :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>

" Test {{{
let test#strategy = "dispatch"
let test#ruby#minitest#file_pattern = '_spec\.rb\|test\.rb$'
" }}}

" Airline {{{
let g:airline_theme = "powerlineish"
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
let g:ctrlp_working_path_mode = 'ra'
" }}}

" Trailing Whitespace {{{
autocmd BufWritePre * :FixWhitespace
let g:DeleteTrailingWhitespace = 1
let g:DeleteTrailingWhitespace_Action = 'delete'
" }}}

" Syntastic {{{
let g:syntastic_check_on_open=1
" }}}

" Vim Markdown {{{
au BufNewFile,BufReadPost *.md.erb set filetype=markdown
au BufNewFile,BufReadPost *.md set filetype=markdown
let g:vim_markdown_folding_disabled=1
let g:markdown_fenced_languages = ['coffee', 'css', 'erb=eruby', 'http', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'shell', 'xml', 'html']
" }}}

" Vim Rooter {{{
let g:rooter_patterns = ['Rakefile', '.git/']
let g:rooter_silent_chdir = 1
" }}}

if filereadable("~/.vimrc.local")
  source ~/.vimrc.local
endif
