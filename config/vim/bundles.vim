call plug#begin('~/.config/vim/plugged')

Plug 'kana/vim-textobj-user'

Plug 'AndrewRadev/splitjoin.vim'
Plug 'airblade/vim-gitgutter'
Plug 'andyl/vim-textobj-elixir'
Plug 'ap/vim-css-color', { 'for': 'css' }
Plug 'bronson/vim-trailing-whitespace'
Plug 'chriskempson/base16-vim'
Plug 'dyng/ctrlsf.vim'
Plug 'elmcast/elm-vim'
Plug 'godlygeek/tabular'
Plug 'janko-m/vim-test'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'junegunn/vim-easy-align'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'rizzatti/dash.vim'
Plug 'rking/ag.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'sheerun/vim-polyglot'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
  Plug 'larrylv/ycm-elixir' " Hijack YouCompleteMe to make Elixir work
endif
Plug 'slashmili/alchemist.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-utils/vim-line'
Plug 'wellle/targets.vim'
Plug 'w0rp/ale'

call plug#end()
