" Remove Whitespace when Save
autocmd BufWritePre * :FixWhitespace

" Full-width Space (Zenkaku)
function! ZenkakuSpace()
 highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
 augroup ZenkakuSpace
   autocmd!
   autocmd ColorScheme * call ZenkakuSpace()
   autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
 augroup END
 call ZenkakuSpace()
endif
