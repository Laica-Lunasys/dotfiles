" Enable Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'git://git.wincent.com/command-t.git'

"Plugin 'Shougo/neocomplete'

Plugin 'Shougo/unite.vim'
Plugin 'ujihisa/unite-colorscheme'
Plugin 'tomasr/molokai'

" Custom Plugin
Plugin 'itchyny/lightline.vim'

Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

Plugin 'scrooloose/nerdtree'

Plugin 'posva/vim-vue'

Plugin 'andrewstuart/vim-kubernetes'

Plugin 'Chiel92/vim-autoformat'

Plugin 'nsf/gocode', {'rtp': 'vim/'}
Plugin 'fatih/vim-go'

Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'

" toml
Plugin 'cespare/vim-toml'

Plugin 'tpope/vim-endwise'

" Plugin 'ervandew/supertab'
Plugin 'maralla/completor.vim'

Plugin 'haya14busa/is.vim'

" Syntax Highlight
Plugin 'w0rp/ale.git'

" Auto Fix Trailing White-Space
Plugin 'bronson/vim-trailing-whitespace'

" Auto Close
Plugin 'jiangmiao/auto-pairs'

call vundle#end()            " required
filetype plugin indent on    " required


" ------------------------------------
" colorscheme
" ------------------------------------
syntax on
colorscheme molokai
highlight Normal ctermbg=none
