
"""" PYTHON
" F9 runs current file as python script
map <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>
" Same as above, but letting user enter any arguments before executing
map <F10> :exec '!python' shellescape(@%, 1) 'args'

" TODO: New tab with output of python command
"map <F8> :tabnew<Bar>read '!python' shellescape(@%, 1)<cr>

"""" GOLANG
" Go Run ( ,gr )
" Go Build ( ,gb )
nmap <leader>gr :w <bar> :GoRun<cr>
nmap <leader>gb :w <bar> :GoBuild<cr>
nmap <leader>gd :w <bar> :GoDocBrowser<cr>
 
