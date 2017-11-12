set number
set mouse=a
set ttymouse=xterm2
"set clipboard+=unnamed

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

source ~/.vim/vundle.vim
source ~/.vim/settings.vim

" ColorScheme
colorscheme molokai
