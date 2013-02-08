" File: ~\.vim\config\vim\mappings.vim
" Description: ViM key and command mappings
" Author: Malusi Gcakasi
" Last Modified:


" Open new tab (Ctrl-n)
imap <silent> <C-n> <ESC>:tabnew<cr>a

" Close current tab (ctrl-w)
imap <silent> <C-w> <ESC>:tabclose<cr>a

" Save current file (ctrl-s)
imap <silent> <C-s> <ESC>:w<cr>a

" Place and unplace sign with code 1 on current line
map <F7> :exe ":sign place 100 line=" . line(".") ."name=highlightLine file=" . expand("%:p")<CR>
map <C-F7> :sign unplace<CR>

" Jump between place holders
nnoremap <c-j> /<+.\{-1,}+><cr>c/+>/e<cr>
inoremap <c-j> <ESC>/<+.\{-1,}+><cr>c/+>/e<cr>

" Bind superclevertab() function to the tab key
inoremap <S-Tab> <C-R>=SuperCleverTab()<cr>
