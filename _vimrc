set nocompatible
source $home/abbreviations.vim
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

function ShortTabLine()
	let ret = ''
	for i in range(tabpagenr('$'))

		" select the color group for highlighting active tab
		if i + 1 == tabpagenr()
			let ret .= '%#errorMsg#'
		else
			let ret .= '%#TabLine#'
		endif

		" find the buffername for the tablabel
		let buflist = tabpagebuflist(i+1)
		let winnr = tabpagewinnr(i+1)
		let buffername = bufname(buflist[winnr - 1])
		let filename = fnamemodify(buffername, ':t')

		" check if there is no name
		if filename == ''
			let filename = 'noname'
		endif

		" only show the first six letters of the name and if the
		" filename is more than eight letters long
		if strlen(filename) >=8
			let ret .= '['. filename[0:5] .'..]'
		else
			let ret .= '['.filename.']'
		endif
	endfor

	" after the last tab fill with TabLineFill and reset tab page #
	let ret .= '%#TabLineFill#%T'
	return ret

endfunction

" set functions
set tabline=%!ShortTabLine()

set shell=powershell
set shellcmdflag=-command

set statusline=%F%<\ %=[TYPE=%Y]\ %=[%p%%]
set laststatus=2

set number
set numberwidth=3

set cursorline
highlight cursorline ctermbg=darkgray ctermfg=white

" open new tab (ctrl-n)
imap <silent> <C-n> <ESC>:tabnew<cr>a
" close current tab (ctrl-w)
imap <silent> <C-w> <ESC>:tabclose<cr>a
" save current file (ctrl-s)
imap <silent> <C-s> <ESC>:w<cr>a
" easier navigation with word wrap on
map <DOWN> gj
map <UP> gk
imap <UP> <ESC>gki
imap <DOWN> <ESC>gji

