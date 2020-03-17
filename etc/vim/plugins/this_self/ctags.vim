
" Find tags file from current dir and upward to home
" set tags=tags;~;
set tags^=./.git/tags;

nnoremap <leader>d <C-]>

" Open definition in new tab
map <C-G> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" Go to file
nmap <leader>o :CtrlP<cr>

" Tagbar (for current file)
nmap <leader>b :TagbarToggle<cr>
