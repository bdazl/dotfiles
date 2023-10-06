

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Don't push the cursor around after leaving insert mode
au InsertLeave * call cursor([getpos('.')[1], getpos('.')[2]+1])
