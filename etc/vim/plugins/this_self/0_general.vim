"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Undo tree
nmap U :MundoToggle<cr>

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

nmap <TAB> :tabnext<cr>
nmap <S-TAB> :tabprev<cr>

" Search and Replace from current line to last
nmap <leader>sr :.,$s///gi<left><left><left><left>

" In visual mode, pressing a results in yanking 
" current selection and letting the user decide
" what to replace that text with.
" Replaces all occurrences in the file.
vmap a y<esc>:%s/<c-r>"//gi<left><left><left> 

