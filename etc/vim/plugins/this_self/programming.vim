
"""" PYTHON
" F9 runs current file as python script
autocmd FileType python map <buffer> <F9> :exec '!python3' shellescape(@%, 1)<cr>
" Same as above, but letting user enter any arguments before executing
autocmd FileType python map <F10> :exec '!python3' shellescape(@%, 1) 'args'
autocmd FileType python nmap <leader>gr :w <bar> exec '!python3' shellescape(@%, 1) 'args'

" Go to definition
autocmd FileType python nmap <leader>gd :tab YcmCompleter GoToDefinitionElseDeclaration<cr>
autocmd FileType python nmap <leader>gf :YcmCompleter GoToReferences<cr>

" TODO: New tab with output of python command
"map <F8> :tabnew<Bar>read '!python' shellescape(@%, 1)<cr>

"""" GOLANG
" Go Run ( ,gr )
" Go Build ( ,gb )
" Go Test ( ,gg )
autocmd FileType go nmap <leader>gr :w <bar> :GoRun<cr>
autocmd FileType go nmap <leader>gb :w <bar> :GoBuild<cr>
autocmd FileType go nmap <leader>gg :w <bar> :GoTest<cr>
autocmd FileType go nmap <leader>gd <plug>(go-def-tab)
autocmd FileType go nmap <leader>go :GoDocBrowser<cr>
autocmd FileType go nmap <leader>gf :GoReferrers<cr>
 
" OLD GoDef helpers (go-def-tab) is doing something funny
" autocmd FileType go nmap <leader>gd :GoDef<cr>
" autocmd FileType go nmap <leader>gd :<C-u>call go#def#Jump("tab", 0)<cr>
" let g:go_debug = 1
