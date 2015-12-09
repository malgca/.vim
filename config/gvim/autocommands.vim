" File: ~\.vim\config\gvim\autocommands.vim 
" Description: Autocommands used by GViM
" Maintainer: Malusi Gcakasi
" Last Modified: Dec 09, 2015 11:09 PM

" Automatically loads template for newly created files based on extensions
autocmd BufNewFile * silent! :call LoadTemplate('%:e')

" Automatically set when file was last modified by replacing 'Last Modified' string in first 20 lines.
autocmd BufWritePre * :call LastModified()

" Automoatically call maximize text area when GVim starts.
autocmd VimEnter * :call MaximizeTextArea()
autocmd VimEnter * :helptags $HOME/.vim/vimfiles/doc

augroup highlightSyntax
	autocmd BufNewFile,BufReadPre *.ps1 :setf ps1
	autocmd BufNewFile,BufReadPre *.psm1 :setf ps1
augroup END


