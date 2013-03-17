" File: ~\.vim\config\vim\mappings.vim
" Description: ViM key and command mappings
" Author: Malusi Gcakasi
" Last Modified:

" Close current buffer with saving
imap <C-w> <ESC>:x<cr>a
"Close current buffer without saving
imap <C-q> <ESC>:q!<cr>a

" Create new tabs using Ctrl-T
imap <silent> <C-t> <ESC>:tabnew<cr>a
" Move to next tab
map! <C-Tab> <ESC>:tabnext<cr>
" Move to previous tab
map! <C-S-Tab> <ESC>:tabprev<cr>

" Save current file (ctrl-s)
imap <C-s> <ESC>:w<cr>a

" Jump between place holders
imap <c-j> /<+.\{-1,}+><cr>c/+>/e<cr>
imap <c-j> <ESC>/<+.\{-1,}+><cr>c/+>/e<cr>

" Bind superclevertab() function to the tab key
imap <S-Tab> <C-R>=SuperCleverTab()<cr>
