" File: ~\.vim\config\gvim\mappings.vim
" Description: GVim key and command mappings
" Author: Malusi Gcakasi
" Last Modified:

" Open new tab (ctrl-t)
imap <silent> <C-t> <ESC>:tabnew<cr>a

" Save and close current Window
imap <C-w> <ESC>:x<cr>a
" Close current window without saving
imap <C-q> <ESC>:q!<cr>a

" Save current file (ctrl-s)
imap <C-s> <ESC>:w<cr>a

" Jump between place holders
nnoremap <c-j> /<+.\{-1,}+><cr>c/+>/e<cr>
inoremap <c-j> <ESC>/<+.\{-1,}+><cr>c/+>/e<cr>

" Bind SuperCleverTab function to the tab key
inoremap <S-Tab> <C-R>=SuperCleverTab()<cr>

" Maximize text area (Ctrl-f2)
map <silent> <C-F2> :if &guioptions =~# 'T' <Bar>
			\set guioptions-=T <Bar>
			\set guioptions-=m <bar>
		\else <Bar>
			\set guioptions+=T <Bar>
			\set guioptions+=m <Bar>
		\endif<CR>

" Place and unplace sign with code 1 on current line
map <F7> :exe ":sign place 1 line=" . line(".") ."name=highlightLine file=" . expand("%:p")<CR>
map <C-F7> :sign unplace<CR>

" Open NERDTree
map <silent> <C-F3> <ESC>:NERDTree<cr>a
