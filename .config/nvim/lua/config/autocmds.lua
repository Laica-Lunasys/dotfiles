vim.cmd([[
    filetype plugin on
    filetype indent on
    autocmd FileType javascript setlocal sw=2 sts=2 ts=2 et
    autocmd FileType typescript setlocal sw=2 sts=2 ts=2 et
    autocmd FileType typescript.tsx setlocal sw=2 sts=2 ts=2 et
    autocmd FileType typescriptreact setlocal sw=2 sts=2 ts=2 et
    autocmd FileType yaml setlocal sw=2 sts=2 ts=2 et
    autocmd FileType helm setlocal sw=2 sts=2 ts=2 et
    autocmd FileType tf setlocal sw=2 sts=2 ts=2 et
    autocmd FileType terraform setlocal sw=2 sts=2 ts=2 et
    autocmd FileType tfvars setlocal sw=2 sts=2 ts=2 et
]])
