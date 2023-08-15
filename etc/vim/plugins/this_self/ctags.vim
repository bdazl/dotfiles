
" Find tags file from current dir and upward to home
" set tags=tags;~;
set tags^=./.git/tags;

" Go to definition
nnoremap <leader>d <C-]>

" Open definition in new tab
map <C-G> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" Go to file
nmap <leader>o :Files<cr>

" Tagbar (for current file)
nmap <leader>b :TagbarToggle<cr>

" Ranger (open file in current buffer)
map <leader>r :Ranger<cr>

" fzf (search, open files fuzzily, etc)
map <leader>f :BTags<cr>
map <leader>F :Files<cr>
