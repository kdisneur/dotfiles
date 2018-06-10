if filereadable(expand("~/.vim/bundles.vim"))
  source ~/.vim/bundles.vim
endif

if executable("opam")
  let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
  let s:opamindent = g:opamshare . "/ocp-indent/vim"
  let s:opammerlin = g:opamshare . "/merlin/vim"
  set rtp^=s:opamindent
  set rtp^=s.opammerlin
endif

if filereadable("/usr/local/bin/python")
  let g:python_host_prog = "/usr/local/bin/python"
end

let mapleader="\<Space>"

if has("nvim")
  set inccommand=nosplit
endif

set backspace=indent,eol,start
set complete=],.,b,u
set conceallevel=0
set diffopt+=vertical
set expandtab
set formatoptions-=t "prevent auto word wrapping
set history=500
set incsearch
set laststatus=2
set nobackup
set nocompatible
set nocursorcolumn
set nocursorline
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
set tabstop=2
set textwidth=120
set wildmode=full

colorscheme sobre
syntax enable

if filereadable(expand("~/.vim/statusline.vim"))
  source ~/.vim/statusline.vim
endif

autocmd BufWritePre * StripWhitespace
autocmd BufWritePost *.ex,*.exs silent !mix format %
autocmd BufRead,BufNewFile Dockerfile.* set filetype=dockerfile
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

command! American setlocal spell spelllang=en_us
command! British setlocal spell spelllang=en_gb
command! Francais setlocal spell spelllang=fr_fr

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

" Motions
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" File management - f
nnoremap <silent> <leader>fd :!mkdir -p "%:p:h"<cr>
nnoremap <leader>ff :edit <c-r>=expand("%:p:h") . "/" <cr>
nnoremap <leader>fj :edit <c-r>= '~/.vim/junks/' . strftime('%Y%m%d') . '.' <cr>
nnoremap <leader>fD :Remove<cr>
nnoremap <leader>fR :Move <c-r>=expand("%:p:h")<cr>

" Code - c
nmap <leader>cd <Plug>DashSearch

" Tests & Texts - t
nmap <leader>tsg <Plug>CtrlSFQuickfixPrompt
nmap <leader>tsc <Plug>CtrlSFQuickfixPwordPath
nmap <leader>trg <Plug>CtrlSFPrompt
nmap <leader>trc <Plug>CtrlSFCwordPath
nnoremap <silent> <leader>ttt :TestNearest<cr>
nnoremap <silent> <leader>ttb :TestFile<cr>
nnoremap <silent> <leader>tta :TestSuite<cr>
nnoremap <silent> <leader>ttr :TestLast<cr>
nnoremap <silent> <leader>ttg :TestVisit<cr>
onoremap il :normal ^vg_<cr>
onoremap al :normal ^v$<cr>
xnoremap il :normal ^vg_<cr>
xnoremap al :normal ^v$<cr>

if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

" Abolish
let g:abolish_no_mappings = 1

" Ag
let g:ag_working_path_mode = "r"

" Elm
let g:elm_format_autosave = 1
let g:elm_setup_keybindings = 0

" Deoplete
let g:deoplete#enable_at_startup = 1
"
" Markdown
let g:markdown_fenced_languages = ['html', 'js']
let g:markdown_syntax_conceal = 0
let g:markdown_minlines = 100

" Test
let test#strategy = "dispatch"
let test#filename_modifier = ':p'

" Ultisnips
let g:UltiSnipsSnippetsDir = $HOME."/.vim/UltiSnips"
let g:UltiSnipsSnippetDirectories = ["UltiSnips"]
let g:UltiSnipsExpandTrigger="<c-e>"

" Wordmotion
let g:wordmotion_prefix = 'g'

if filereadable("~/.vimrc.local")
  source ~/.vimrc.local
endif

function! CurrentHighlightGroups()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction
