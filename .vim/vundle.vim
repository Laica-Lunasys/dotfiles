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

Plugin 'Chiel92/vim-autoformat'

Plugin 'nsf/gocode', {'rtp': 'vim/'}
Plugin 'fatih/vim-go'

Plugin 'ervandew/supertab'

"if has('nvim')
"  Plugin 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"else
"  Plugin 'Shougo/deoplete.nvim'
"endif
"Plugin 'roxma/nvim-yarp'
"Plugin 'roxma/vim-hug-neovim-rpc'

Plugin 'zchee/deoplete-go', { 'do': 'make' }


call vundle#end()            " required
filetype plugin indent on    " required
