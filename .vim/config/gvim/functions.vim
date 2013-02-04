" function definitions
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

function! LoadTemplate(extension)
	silent! :execute '0r $HOME/vim/templates/'. a:extension. '.tpl'
	silent! execute 'source $HOME/vim/templates/'.a:extension.'.patterns.tpl'
endfunction

function! MyFoldFunction()
	let line = getline(v:foldstart)
	" Cleanup unwanted things in first line
	let sub = substitute(line, '/\*\|\*/\|^\s+','','g')
	" Calculate lines in folded text
	let lines = v:foldend - v:foldstart + 1
	return v:folddashes.sub.'...'.lines.' Lines...'.getline(v:foldend)
endfunction

function! BulletList()
	let lineno = line(".")
	call setline(lineno, "<Tab>'> '" .getline(lineno))
endfunction

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

" set functions
set guitablabel=%{ShortTabLabel()}
set guitabtooltip=%!InfoGuiTooltip()

set balloonexpr=FoldSpellBalloon()
set ballooneval

set foldtext=%!MyFoldFunction()

