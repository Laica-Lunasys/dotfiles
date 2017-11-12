set number

if has('nvim')
    " Neovim specific commands
    set mouse=a
else
    " Standard vim specific command
    set mouse=a
    set ttymouse=xterm2
endif

set clipboard+=unnamed
nnoremap x "_x
nnoremap d "_d
nnoremap D "_D

set tabstop=4
set autoindent
set expandtab
set shiftwidth=4

set laststatus=2

set backspace=indent,eol,start

" Enable Syntax Highlight
syntax on

" Setup Vundle
filetype plugin indent on    " required

nnoremap <silent><C-e> :NERDTreeToggle<CR>

source ~/.vim/keymap.vim
source ~/.vim/vundle.vim
source ~/.vim/settings.vim

" ColorScheme
colorscheme molokai
