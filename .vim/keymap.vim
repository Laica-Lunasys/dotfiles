" Copy
vmap <C-c> y

" Paste
"map <C-v> <ESC>p
"imap <C-v> <C-o>p

" Cut
vmap <C-x> x

" Select All
map <C-a> <ESC>:goto<CR>VG<CR>
imap <C-a> <C-o>:goto<CR><C-o>VG<CR>

" Replace
imap <C-h> <C-o>:%s/from/to/g

" Undo
"imap <C-z> <C-o>:undo<CR>
"imap <C-y> <C-o>:redo<CR>