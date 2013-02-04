" My vim cli key mappings
" open new tab (ctrl-n)
imap <silent> <C-n> <ESC>:tabnew<cr>a
" close current tab (ctrl-w)
imap <silent> <C-w> <ESC>:tabclose<cr>a
" save current file (ctrl-s)
imap <silent> <C-s> <ESC>:w<cr>a
" place sign under current line
map <F7> :exe ":sign place 123 line=" . line(".") ."name=information file=" . expand("%:p")<CR>
map <C-F7> :sign unplace<CR>
" jump between place holders
nnoremap <c-j> /<+.\{-1,}+><cr>c/+>/e<cr>
inoremap <c-j> <ESC>/<+.\{-1,}+><cr>c/+>/e<cr>
" bind superclevertab() function to the tab key
inoremap <S-Tab> <C-R>=SuperCleverTab()<cr>
