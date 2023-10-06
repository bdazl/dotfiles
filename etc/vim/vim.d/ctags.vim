
" Find tags file from current dir and upward to home
" set tags=tags;~;
set tags^=./.git/tags;

" Go to definition
nnoremap <leader>d <C-]>

" Open definition in new tab
nmap <C-G> :tab split<cr>:exec("tag ".expand("<cword>"))<cr>

" Tagbar (for current file)
nmap <leader>b :TagbarToggle<cr>

" Ranger (open file in current buffer)
nmap <leader>r :Ranger<cr>

" fzf (BTags = search ctags in current file, Files = open files)
nmap <leader>f :BLines<cr>
nmap <leader>F :BTags<cr>
nmap <leader>o :Files!<cr>
