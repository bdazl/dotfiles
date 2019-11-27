"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Search in project (as defined by .git dir)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Seems to not work very well. Todo
map <F4> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>

