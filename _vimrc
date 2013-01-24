set nocompatible
source $home/.vim/abbreviations.vim
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

function! LoadTemplate(extension)
	silent! :execute '0r $HOME/.vim/templates/'. a:extension. '.tpl'
	silent! execute 'source $HOME/.vim/templates/'.a:extension.'.patterns.tpl'
endfunction

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
set tabline=%!ShortTabLine()
set shiftwidth=4
set tabstop=4

set foldtext=MyFoldFunction()

set shell=powershell
set shellcmdflag=-command

set statusline=%F%<\ %=[TYPE=%Y]\ %=[%p%%]
set laststatus=2

set number
set numberwidth=3

set cursorline

set isfname+=32

set incsearch

set autoindent
set smartindent
set cinwords="if,elseif,else,do,while,for,switch"
sign define information text=!> linehl=Warning texthl=Error

highlight cursorline ctermbg=darkgray ctermfg=white

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
inoremap <Tab> <C-R>=SuperCleverTab()<cr>

" Autocommands
autocmd BufNewFile * silent! call LoadTemplate('%:e')

augroup filetypedetect
		autocmd BufNewFile,BufRead *.ps1 setfiletype conf
		autocmd BufNewFile,BufRead *.psm1 setfiletype conf
augroup END
