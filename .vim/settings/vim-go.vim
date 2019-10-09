let g:go_fmt_command = "goimports"

" Add go-info auto navigate
autocmd FileType go nmap <Leader>i <Plug>(go-info)
let g:go_auto_type_info = 1
set updatetime=100

" Highlight
let g:go_highlight_types = 1
let g:go_highlight_functions = 1
