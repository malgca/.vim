" File: ~\.vim\config\gvim\functions.vim
" Description: Functions used through out gvimrc files
" Author: Malusi Gcakasi
" Last Modified: 

" Truncates tabs to first six letters of name only for easier
" navigation
function ShortTabLabel()
	let bufnrlist = tabpagebuflist(v:lnum)

	" show only the first six letters of the name + ..
	let label = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
	let filename = fnamemodify(label, ':t')

	" only add .. if string is more than 8 characters long.
	if strlen(filename) >=8
		let ret=filename[0:5].'..'
	else
		let ret=filename
	endif

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

" Display information information on a specific gui tab
function! InfoGuiTooltip()
	" get window count
	let wincount = tabpagewinnr(tabpagenr(), '$')
	let bufferlist=''

	" get name of active buffers in windows
	for i in tabpagebuflist()
		let bufferlist .= '['.fnamemodify(bufname(i), ':t').'] '
	endfor

		return bufname($).' windows: '.wincount.' '.bufferlist.' '
endfunction

" Display's more terse information on GVim balloon folds, as well as
" giving spelling alternatives in folds.
function FoldSpellBalloon()
	let foldstart = foldclosed(v:beval_lnum)
	let foldEnd = foldclosedend(v:beval_lnum)
	let lines = []

	" detect if we are in a fold.
	if foldstart < 0
		" detect if we are on a misspelled word
		let lines = spellsuggest(spellbadword(v:beval_text)[0], 5, 0)
	else
		" we are in a fold
		let numLines = foldEnd - foldstart + 1

		" if we have too many lines in fold, show only the first 14 and the last 14 lines
		if(numLines > 31)
			let lines = getline(foldstart, foldstart + 14)
			let lines += ['-- Snipped ' . (numLines - 30) . ' lines --']
			let lines += getline(foldEnd - 14, foldEnd)
		else
			" less than 30 lines, lets show all of them
			let lines = getline(foldstart, foldEnd)
		endif
	endif

	" return result
	return join(lines, has("balloon_multiline") ? "\n" : " ")
endfunction

" Loads templates for newly created files based on extension.
" Set in autocommands file.
function! LoadTemplate(extension)
	silent! :execute '0r $HOME/vim/templates/'. a:extension. '.tpl'
	silent! execute 'source $HOME/vim/templates/'.a:extension.'.patterns.tpl'
endfunction

" Automatically updates any "Last Modified:" in the first 20 lines of 
" any file. Set in autocommands file.
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

" Provides a crude bullet list function for gvim
function! BulletList()
	let lineno = line(".")
	call setline(lineno, "<Tab>'> '" .getline(lineno))
endfunction

" Provides a crude number list function for gvim.
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
