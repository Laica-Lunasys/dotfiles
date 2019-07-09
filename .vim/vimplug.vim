call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'git://git.wincent.com/command-t.git'

"Plug 'Shougo/neocomplete'

Plug 'Shougo/unite.vim'
Plug 'ujihisa/unite-colorscheme'
Plug 'tomasr/molokai'

" Custom Plug
Plug 'itchyny/lightline.vim'

Plug 'rstacruz/sparkup', {'rtp': 'vim/'}

Plug 'scrooloose/nerdtree'

Plug 'posva/vim-vue'

Plug 'andrewstuart/vim-kubernetes'

Plug 'Chiel92/vim-autoformat'

Plug 'nsf/gocode', {'rtp': 'vim/'}
Plug 'fatih/vim-go'

Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'

" JS
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/yajs.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/es.next.syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
augroup Vimrc
  autocmd!
  autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END

Plug 'maxmellon/vim-jsx-pretty', { 'for': ['javascript', 'javascript.jsx'] }

Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'], 'do': 'npm install' }

" toml
Plug 'cespare/vim-toml'

" tf
Plug 'hashivim/vim-terraform'
let g:terraform_fmt_on_save = 1

Plug 'tpope/vim-endwise'

" html
Plug 'alvan/vim-closetag'

" lsp
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/async.vim'

" Plug 'ervandew/supertab'
Plug 'maralla/completor.vim'
" Plug 'Valloric/YouCompleteMe'
let g:ycm_global_ycm_extra_conf = '${HOME}/.ycm_extra_conf.py'
let g:ycm_auto_trigger = 1
let g:ycm_min_num_of_chars_for_completion = 3
let g:ycm_autoclose_preview_window_after_insertion = 1
set splitbelow

Plug 'haya14busa/is.vim'

" Syntax Highlight
Plug 'w0rp/ale'

" Auto Fix Trailing White-Space
Plug 'bronson/vim-trailing-whitespace'

" Auto Close
Plug 'jiangmiao/auto-pairs'

" Comment
Plug 'tpope/vim-commentary'


call plug#end()

" ------------------------------------
" colorscheme
" ------------------------------------
syntax on

if filereadable(expand("$HOME/.vim/plugged/molokai/colors/molokai.vim"))
    colorscheme molokai
endif

highlight Normal ctermbg=none
