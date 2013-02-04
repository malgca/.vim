" Personal cli vim Autocommands
" Maintainer: Malusi Gcakasi
" Last Modified:

" Automatically loads template for newly created files based on extensions
autocmd BufNewFile * silent! call LoadTemplate('%:e')

" Automatically set when file was last modified by replacing 'Last Modified'
" string in first 20 lines
autocmd BufNewFile *  call LastModified()
