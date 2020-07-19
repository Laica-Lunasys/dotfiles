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

" TypeScript
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" Svelte
Plug 'evanleck/vim-svelte'

" toml
Plug 'cespare/vim-toml'

" tf
Plug 'hashivim/vim-terraform'
let g:terraform_fmt_on_save = 1

Plug 'tpope/vim-endwise'

" html
Plug 'alvan/vim-closetag'

" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

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

" LSP -> C/CPP
if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd', '-background-index']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif

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

" LSP -> Java
let s:lombok_path = $HOME . '/lsp/lombok.jar'
if executable('java') && filereadable(expand('~/lsp/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.5.700.v20200207-2156.jar')) && filereadable(expand(s:lombok_path))

    " ale の設定
    let g:ale_java_javac_options = "-cp " . s:lombok_path

    " vim-lsp の設定
    au User lsp_setup call lsp#register_server({
        \ 'name': 'eclipse.jdt.ls',
        \ 'cmd': {server_info->[
        \     'java',
        \     '-javaagent:' . s:lombok_path,
        \     '-Xbootclasspath/a:' . s:lombok_path,
        \     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        \     '-Dosgi.bundles.defaultStartLevel=4',
        \     '-Declipse.product=org.eclipse.jdt.ls.core.product',
        \     '-Dlog.level=ALL',
        \     '-noverify',
        \     '-Dfile.encoding=UTF-8',
        \     '-Xmx1G',
        \     '-jar',
        \     expand('~/lsp/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_1.5.700.v20200207-2156.jar'),
        \     '-configuration',
        \     expand('~/lsp/eclipse.jdt.ls/config_linux'),
        \     '-data',
        \     getcwd()
        \ ]},
        \ 'whitelist': ['java'],
        \ })
endif

" Markdown
if executable('prettier')
    " [markdown] configure formatprg
    autocmd FileType markdown set formatprg=prettier\ --parser\ markdown

    " [markdown] format on save
    autocmd! BufWritePre *.md call s:mdfmt()
    function s:mdfmt()
        let l:curw = winsaveview()
        silent! exe "normal! a \<bs>\<esc>" | undojoin |
            \ exe "normal gggqG"
        call winrestview(l:curw)
    endfunction
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

" mattn's vim config
Plug 'mattn/vim-lsp-settings'


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
