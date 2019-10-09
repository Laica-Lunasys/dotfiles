let mapleader = "\<Space>"

" Clipboard
nnoremap y "+y
nnoremap Y "+Y
vnoremap y "+y
vnoremap Y "+Y

nnoremap p "+p
nnoremap P "+P
vnoremap p "+p
vnoremap P "+P

nnoremap c "+c
vnoremap c "+c

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

" Improve Quickfix List
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
