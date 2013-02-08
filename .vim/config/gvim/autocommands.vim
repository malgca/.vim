" File: ~\.vim\config\gvim\autocommands.vim 
" Description: Autocommands used by GViM
" Maintainer: Malusi Gcakasi
" Last Updated: 

" Automatically loads template for newly created files based on extensions
autocmd BufNewFile * silent! call LoadTemplate('%:e')

" Automatically set when file was last modified by replacing 'Last Modified' string in first 20 lines.
autocmd BufWritePre * :call LastModified()
