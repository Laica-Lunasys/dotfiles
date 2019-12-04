call plug#begin('~/.config/nvim/plugged')

Plug 'airblade/vim-gitgutter'

Plug 'ujihisa/unite-colorscheme'
Plug 'tomasr/molokai'

" Custom Plug
Plug 'itchyny/lightline.vim'

Plug 'scrooloose/nerdtree'

Plug 'andrewstuart/vim-kubernetes'

Plug 'Chiel92/vim-autoformat'

Plug 'nsf/gocode', {'rtp': 'vim/'}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'

" JS
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/yajs.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/es.next.syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'Galooshi/vim-import-js'
Plug 'maxmellon/vim-jsx-pretty', { 'for': ['javascript', 'javascript.jsx'] }

" toml
Plug 'cespare/vim-toml'

" tf
Plug 'hashivim/vim-terraform'
let g:terraform_fmt_on_save = 1

Plug 'tpope/vim-endwise'

" html
Plug 'alvan/vim-closetag'

" lsp
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'whitelist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))

" LSP -> Python
Plug 'ryanolsonx/vim-lsp-python'
if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

" HTML
if executable('html-languageserver')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'html-languageserver',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'html-languageserver --stdio']},
    \ 'whitelist': ['html'],
  \ })
endif

" LSP -> Go
if executable('gopls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'gopls',
        \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
        \ 'whitelist': ['go'],
        \ })
    autocmd BufWritePre *.go "LspDocumentFormatSync<CR>"
endif
if executable('go-langserver')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'go-langserver',
        \ 'cmd': {server_info->['go-langserver', '-gocodecompletion']},
        \ 'whitelist': ['go'],
        \ })
    autocmd BufWritePre *.go "LspDocumentFormatSync<CR>"
endif

" rust
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'

let g:asyncomplete_auto_popup = 1

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Plug 'ervandew/supertab'
" Plug 'maralla/completor.vim'
" Plug 'Valloric/YouCompleteMe'
"let g:ycm_global_ycm_extra_conf = '${HOME}/.ycm_extra_conf.py'
"let g:ycm_auto_trigger = 1
"let g:ycm_min_num_of_chars_for_completion = 3
"let g:ycm_autoclose_preview_window_after_insertion = 1
"set splitbelow

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

if filereadable(expand("$HOME/.config/nvim/plugged/molokai/colors/molokai.vim"))
    colorscheme molokai
endif

highlight Normal ctermbg=none
