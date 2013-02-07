" File: ~\.vim\config\vim\functions.vim
" Description: Functions used through out vimrc files
" Author: Malusi Gcakasi
" Last Modified: Feb 07, 2013 01:25 PM

" Truncates tabs to first six letters of name only for easier navigation.
function! ShortTabLine()
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

" Augments autocomplete functionality on tab button to allow for
" auto completion of words based on words used as well as internal
" dictionary
function! SuperCleverTab()
	" Check if at beginning of line or after a spae
	if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
		return "\<Tab>"
	else
		" Do we have an omni completion available
		if &omnifunc != ''
			" Use omni-completion 1. priority
			return "\<C-X>\<C-O>"
		elseif &dictionary != ''
			" No omni completion, try dictionary completion
			return "\<C-K>"
		else
			" Use omni completion or dictionary completion
			" Use known-word completion
			return "\<C-N>"
		endif
	endif
endfunction

" Loads templates for newly created files based on extension.
" Set in autocommands file.
function! LoadTemplate(extension)
	silent! :execute '0r $HOME/.vim/templates/'. a:extension. '.tpl'
	silent! execute 'source $HOME/.vim/templates/'.a:extension.'.patterns.tpl'
endfunction

" Automatically updates any "Last Modified:" in the first 20 lines of any
" file. Set in autocommand file.
function! LastModified()
	if &modified
		let save_cursor = getpos(".")
		let n = min([20, line("$")])
		keepjumps exe '1,' . n . 's#^\(.\{,10}Last Modified: \).*#\1' . strftime('%b %d, %Y %I:%M %p') . '#e'
		call histdel('search', -1)
		call setpos('.', save_cursor)
	endif
endfunction

" Displays the number of lines inside a folded fold
function! MyFoldFunction()
	let line = getline(v:foldstart)
	" Cleanup unwanted things in first line
	let sub = substitute(line, '/\*\|\*/\|^\s+','','g')
	" Calculate lines in folded text
	let lines = v:foldend - v:foldstart + 1
	return v:folddashes.sub.'...'.lines.' Lines...'.getline(v:foldend)
endfunction

" Provides a crude bullet list function for cli vim
function! BulletList()
	let lineno = line(".")
	call setline(lineno, "<Tab>'> '" .getline(lineno))
endfunction

" Provides a crude number list function for cli vim.
function! NumberList() range
	" Set line numbers in front of lines
	let beginning = line("'<")
	let ending = line("'>")
	let difsize= ending - beginning + 1
	let pre=' '
	while(beginning <= ending)
		if match(difsize, '^9*$') == 0
			let pre = pre . ' '
		endif
		call setline(ending, pre . difsize . "\t" . getline(ending))
		let ending = ending - 1
		let difsize = difsize - 1
	endwhile
endfunction
