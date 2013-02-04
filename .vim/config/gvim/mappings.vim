" key mappings:
" maximize text area (ctrl-f2)
map <silent> <C-F2> :if &guioptions =~# 'T' <Bar>
			\set guioptions-=T <Bar>
			\set guioptions-=m <bar>
		\else <Bar>
			\set guioptions+=T <Bar>
			\set guioptions+=m <Bar>
		\endif<CR>

" open new tab (ctrl-n)
imap <silent> <C-n> <ESC>:tabnew<cr>a
" close current tab (ctrl-w)
imap <silent> <C-w> <ESC>:tabclose<cr>a
" save current file (ctrl-s)
imap <silent> <C-s> <ESC>:w<cr>a

" easier navigation with word wrap on.
map <DOWN> gj
map <UP> gk
imap <UP> <ESC>gki
imap <DOWN> <ESC>gji
