" Copy
vmap <C-c> "+y

" Cut
vmap <C-x> x

" Select All
map <C-a> <ESC>:goto<CR>VG<CR>
imap <C-a> <C-o>:goto<CR><C-o>VG<CR>

" Replace
imap <C-h> <C-o>:%s/from/to/g

" NERD Tree
nnoremap <silent><C-e> :NERDTreeToggle<CR>
