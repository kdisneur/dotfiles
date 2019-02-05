call plug#begin('~/.vim/plugged')

Plug 'kana/vim-textobj-user'

Plug 'andyl/vim-textobj-elixir'
Plug 'chaoren/vim-wordmotion'
Plug 'christoomey/vim-sort-motion'
Plug 'def-lkb/ocp-indent-vim'
Plug 'dyng/ctrlsf.vim'
Plug 'elmcast/elm-vim'
Plug 'elixir-editors/vim-elixir'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'godlygeek/tabular'
Plug 'janko-m/vim-test'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'junegunn/vim-easy-align'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'NLKNguyen/papercolor-theme'
Plug 'ntpeters/vim-better-whitespace'
Plug 'plasticboy/vim-markdown'
Plug 'rizzatti/dash.vim'
Plug 'rking/ag.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'sheerun/vim-polyglot'
Plug 'slashmili/alchemist.vim'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --go-completer --ts-completer' }
endif
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-syntastic/syntastic'
Plug 'w0rp/ale'
Plug 'wellle/targets.vim'

call plug#end()
