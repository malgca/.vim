" Personal vimrc file
" Maintainer: Malusi Gcakasi
" Last Modified:

" Set no compatible mode to allow greater access to ViM functions.
set nocompatible
" Set personal runtimepath
set runtimepath=$home\.vim,$home\.vim\after,$Vim\vimfiles,$Vim\vimfiles\after,$VIMRUNTIME

" Set all sources from personal .vim folder
source $home/.vim/abbreviations.vim
source $home/.vim/config/vim/functions.vim
source $home/.vim/config/vim/mappings.vim
source $home/.vim/config/vim/testFunctions.vim
source $home/.vim/config/vim/autocommands.vim

" Vim set runtime paths
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim

" Make sure that behaviour is set to MSWindows
behave mswin

" Set personal preferences (lines beyond here won't be explained unless deemed
" necessary).

set shiftwidth=4
set tabstop=4

set shell=powershell
set shellcmdflag=-command

" Set information to be displayed on status line, in my case: File Name, File
" Type and percentage of way through the file.
set statusline=%F%<\ %=[%l,%c]\ %=[TYPE=%Y]\ %=[%p%%]
" Set status line to appear at bottom of screen.
set laststatus=2

" Set line numbers on
set number
" Set digit length to which line numbers may extend.
set numberwidth=3

" Set cursor line highlighting on.
set cursorline
" Set colour for cursorline background and foreground highting
highlight cursorline ctermbg=darkgray ctermfg=white

" Set allowances for paths with spaces.
set isfname+=32

" Allow for incremental searching.
set incsearch

" Set auto, smart and c indentation on.
set autoindent
set smartindent
" Set special keywords to be automatically indented
set cinwords="if,elseif,else,do,while,for,switch"

" Sset sign to use for setting highlight stops.
sign define information text=!> linehl=Warning texthl=Error
