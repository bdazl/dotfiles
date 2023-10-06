"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" <leader>
let mapleader = ","

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Most important rebinds for the swedish keyboard!!
map ö ^
map ä $

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Remove Q mapping
nnoremap Q <nop>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 
" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h") . "/"<cr>

nmap <TAB> :tabnext<cr>
nmap <S-TAB> :tabprev<cr>

" Split tab vertically and horizontally
map <leader>so :vs <c-r>=expand("%:p:h") . "/"<cr>
map <leader>sO :sp <c-r>=expand("%:p:h") . "/"<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Undo tree
nmap U :MundoToggle<cr>
let g:mundo_width = 25
let g:mundo_preview_bottom = 1

" Tagbar (for current file)
nmap <leader>b :TagbarToggle<cr>

" Ranger (open file in current buffer)
nmap <leader>r :Ranger<cr>

" fzf (BTags = search ctags in current file, Files = open files)
nmap <leader>f :BLines<cr>
nmap <leader>F :BTags<cr>
nmap <leader>o :Files!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ctags
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Go to definition
nnoremap <leader>d <C-]>

" Open definition in new tab
nmap <C-G> :tab split<cr>:exec("tag ".expand("<cword>"))<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Search
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Search and Replace from current line to last
nmap <leader>sr :.,$s///gi<left><left><left><left>

" In visual mode, pressing a results in yanking 
" current selection and letting the user decide
" what to replace that text with.
" Replaces all occurrences in the file.
vmap a y<esc>:<c-r>=GetSearchFromYanked("%s")<cr><left><left><left>
vmap A y<esc>:<c-r>=GetSearchFromYanked(".,+2s")<cr><left><left><left>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => FileType mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" PYTHON
" F9 runs current file as python script
autocmd FileType python map <buffer> <F9> :exec '!python3' shellescape(@%, 1)<cr>
" Same as above, but letting user enter any arguments before executing
autocmd FileType python map <F10> :exec '!python3' shellescape(@%, 1) 'args'
autocmd FileType python nmap <leader>gr :w <bar> exec '!python3' shellescape(@%, 1) 'args'

" Go to definition
autocmd FileType python nmap <leader>gd :tab YcmCompleter GoToDefinitionElseDeclaration<cr>
autocmd FileType python nmap <leader>gf :YcmCompleter GoToReferences<cr>

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Copy to X CLIPBOARD
" TODO: Make this portable and better
map <leader>c :call SaveToXClip()<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions for keymaps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! EscapeYanked()
    return escape(@", "\\/.*'$^~[]:")
endfunction

function! GetSearchFromYanked(pre)
    return a:pre . ":" . EscapeYanked() . "::gi"
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

function! GetVisualSelection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

function! SaveToXClip()
    let selection = GetVisualSelection()
    execute "!" . "echo " . selection . "|" . "xsel -i -b"
endfunction
