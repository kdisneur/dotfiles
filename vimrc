call plug#begin('~/.vim/plugged')
Plug 'kana/vim-textobj-user'

Plug 'andyl/vim-textobj-elixir'
Plug 'chaoren/vim-wordmotion'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'google/vim-jsonnet'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'itchyny/vim-qfedit'
Plug 'mileszs/ack.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'ntpeters/vim-better-whitespace'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'sheerun/vim-polyglot'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --go-completer --ts-completer' }
endif
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'reedes/vim-litecorrect'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-syntastic/syntastic'
Plug 'w0rp/ale'
Plug 'wellle/targets.vim'
call plug#end()

if filereadable("/usr/local/bin/python")
  let g:python_host_prog = "/usr/local/bin/python"
end

if has('python3')
  " Hide annoying warning
  silent! python3 1
endif

let mapleader="\<Space>"

if has("nvim")
  set inccommand=nosplit
endif

set backspace=indent,eol,start " allow backspace key every time
set complete=],.,b,u " autocomplete with tag, current buffer, other buffers (loaded and unloaded)
set conceallevel=0 " do not use conceal
set diffopt+=vertical
set expandtab " use the right number of spaces when pressing tab
set formatoptions-=t "prevent auto word wrapping
set history=500 "history of commands to keep in memory
set incsearch " jump to the first match as typing
set laststatus=2 " always display the status line
set nobackup
set nocompatible
set nocursorcolumn
set nocursorline
set nohlsearch " do not highlight search results
set nomodeline " do not enable vim executable commentary in files (i.e. /* vim: set ft=ruby*/)
set noswapfile
set nowrap " do not use softwrap
set nowritebackup
set path=.,** " search from current folder and sub folders
set wildignore+=**/.git/**
set wildignore+=**/_build/**
set wildignore+=**/deps/**
set wildignore+=**/node_modules/**
set wildignore+=**/*.jpg,**/*.JPG,**/*.png,**/*.PNG,**/*.pdf,**/*.PDF
set relativenumber " display relative number
set ruler
set shiftwidth=2 " number of spaces to use on indentation
set showcmd
set spellfile=$HOME/.vim-spell-en.utf-8.add
set tabstop=2 " number of spaces used to display tabs
set textwidth=120 " max line before breaking lines
set wildmode=full

set background=light
colorscheme PaperColor
syntax enable
" automatically initialize buffer by file type

" invoke manually by command for other file types
autocmd BufRead,BufNewFile Dockerfile,Dockerfile.* set filetype=dockerfile
autocmd BufRead,BufNewFile *.avsc set filetype=json
autocmd BufRead,BufNewFile *.dot.m4 set filetype=dot
autocmd BufReadPost,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.slim set filetype=slim
autocmd BufRead,BufNewFile mix.lock set filetype=elixir
autocmd FileType csv hi CSVColumnEven ctermfg=black ctermbg=lightgray
autocmd FileType csv hi CSVColumnOdd  ctermfg=black
autocmd FileType markdown setlocal spell
autocmd FileType gitcommit setlocal spell
autocmd FileType eruby,html,slim setlocal cursorcolumn cursorline
autocmd FileType elm setlocal shiftwidth=4
autocmd FileType Makefile setlocal autoindent noexpandtab tabstop=4 shiftwidth=4
autocmd FileType markdown,mkd,text,asciidoc call Prose()

" Autoclose preview popup
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

command! American setlocal spell spelllang=en_us
command! British setlocal spell spelllang=en_gb
command! Francais setlocal spell spelllang=fr_fr
command! Prose call Prose()

set splitbelow
set splitright

" Mapping
noremap <left> <nop>
noremap <right> <nop>
noremap <up> <nop>
noremap <down> <nop>
inoremap <esc> <nop>
inoremap jk <esc>
nnoremap * *``
nnoremap ** *
nnoremap gp `[v`]

" Ale Mapping
nnoremap <silent> <leader>aj :ALENext<cr>
nnoremap <silent> <leader>ak :ALEPrevious<cr>
nnoremap <silent> <leader>an :ALEGoToDefinition<cr>

" File management - f
nnoremap <silent> <leader>fd :!mkdir -p "%:p:h"<cr>
nnoremap <leader>ff :edit <c-r>=expand("%:p:h") . "/" <cr>
nnoremap <leader>fj :edit <c-r>= '~/.vim/junks/' . strftime('%Y%m%d') . '.' <cr>
nnoremap <leader>fD :Remove<cr>
nnoremap <leader>fR :Move <c-r>=expand("%:p:h")<cr>

" Tests & Texts - t
onoremap il :normal ^vg_<cr>
onoremap al :normal ^v$<cr>
xnoremap il :normal ^vg_<cr>
xnoremap al :normal ^v$<cr>

" Ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Ale
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_cursor_detail = 0
let g:ale_elixir_elixir_ls_release = $HOME . '/Workspace/JakeBecker/elixir-ls/rel'
let g:ale_elixir_credo_strict = 1
let g:ale_go_langserver_executable = 'gopls'
let g:ale_keep_list_window_open = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_set_loclist = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>'
let g:ale_sign_warning = '-'
let g:ale_linters = {
\  'elixir': ['credo', 'elixir-ls'],
\  'javascript': ['eslint'],
\  'typescript': ['eslint', 'tsserver'],
\}

let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'elixir': ['mix_format'],
\  'go': ['gofmt'],
\  'javascript': ['eslint'],
\  'typescript': ['eslint'],
\}

" Ctlp
let g:ctrlp_working_path_mode = 0
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

" Deoplete
let g:deoplete#enable_at_startup = 1
"
" Syntastic
let g:syntastic_elixir_checkers = ['elixir']
let g:syntastic_enable_elixir_checker = 1

" Ultisnips
let g:UltiSnipsSnippetsDir = $HOME."/.vim/UltiSnips"
let g:UltiSnipsSnippetDirectories = ["UltiSnips"]
let g:UltiSnipsExpandTrigger="<c-e>"

" Wordmotion
let g:wordmotion_prefix = 'g'

if filereadable("~/.vimrc.local")
  source ~/.vimrc.local
endif

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

set statusline=\ %f%{StatuslineIsModified()}%{StatuslineIsReadOnly()}

function! CurrentHighlightGroups()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

function! Prose()
  call litecorrect#init()

  setlocal wrap " soft wrap content
  setlocal linebreak " only breaks on specific characters
  setlocal textwidth=0 wrapmargin=0 " do not insert newlines automatically on insert mode

  " manual reformatting shortcuts
  nnoremap <buffer> <silent> Q gqap
  xnoremap <buffer> <silent> Q gq
  nnoremap <buffer> <silent> <leader>Q vapJgqap

  " force top correction on most recent misspelling
  nnoremap <buffer> <c-s> [s1z=<c-o>
  inoremap <buffer> <c-s> <c-g>u<Esc>[s1z=`]A<c-g>u

  " check list mark
  nnoremap <buffer> - :MarkdownCheckTask<cr>
endfunction
