"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Search in project (as defined by .git dir)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Seems to not work very well. Todo
map <F4> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>

" Search and Replace from current line to last
nmap <leader>sr :.,$s///gi<left><left><left><left>

" In visual mode, pressing a results in yanking 
" current selection and letting the user decide
" what to replace that text with.
" Replaces all occurrences in the file.
vmap a y<esc>:<c-r>=GetSearchFromYanked("%s")<cr><left><left><left>
vmap A y<esc>:<c-r>=GetSearchFromYanked(".,+2s")<cr><left><left><left>

function! EscapeYanked()
    return escape(@", "\\/.*'$^~[]:")
endfunction

function! GetSearchFromYanked(pre)
    return a:pre . ":" . EscapeYanked() . "::gi"
endfunction

