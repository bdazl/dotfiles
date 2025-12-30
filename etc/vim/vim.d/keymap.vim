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

" Make '-' right-indent, in visual mode
vmap - >

" When pasting, keep the previous copy-buffer,
" i.e. send the new one to the black hole register.
vnoremap p "_dP
vnoremap P "_dP

" Useful mappings for managing tabs and windows
map <leader>q :quit<cr>
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>

" Set tabs/spaces with certain numbers of spaces
nnoremap <leader>§ :set list!<CR>
nnoremap <leader>1 :set tabstop=4 shiftwidth=4 softtabstop=0 noexpandtab<CR>
nnoremap <leader>2 :set tabstop=2 shiftwidth=2 softtabstop=2 expandtab<CR>
nnoremap <leader>4 :set tabstop=4 shiftwidth=4 softtabstop=4 expandtab<CR>

" Use vim-tmux-navigator for insert and visual modes as well
inoremap <silent> <C-h> <ESC>:<C-U>TmuxNavigateLeft<cr>
inoremap <silent> <C-j> <ESC>:<C-U>TmuxNavigateDown<cr>
inoremap <silent> <C-k> <ESC>:<C-U>TmuxNavigateUp<cr>
inoremap <silent> <C-l> <ESC>:<C-U>TmuxNavigateRight<cr>

vnoremap <silent> <C-h> <ESC>:<C-U>TmuxNavigateLeft<cr>
vnoremap <silent> <C-j> <ESC>:<C-U>TmuxNavigateDown<cr>
vnoremap <silent> <C-k> <ESC>:<C-U>TmuxNavigateUp<cr>
vnoremap <silent> <C-l> <ESC>:<C-U>TmuxNavigateRight<cr>

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

vnoremap <leader>y :<c-u>silent '<,'>w !~/.etc/bin/copy<cr>:redraw!<cr>

" In M$ terminals ctrl-v may be difficult
nnoremap <leader>v <c-v>

" Remove Q mapping
nnoremap Q <nop>

" Jumping big chunks always centers the cursor mid screen
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h") . "/"<cr>

nmap <TAB> :tabnext<cr>
nmap <S-TAB> :tabprev<cr>

" Toggle between relative and absolute line numbers
nnoremap <leader>l :execute 'set number ' . (&relativenumber ? 'norelativenumber' : 'relativenumber')<cr>

" Quickfix (or YcmCompleter GoToReferences for instance)
nmap <leader>n :cn<cr>
nmap <leader>p :cp<cr>

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
nmap <leader>S :BLines<cr>
nmap <leader>s :BTags<cr>
nmap <leader>o :Files!<cr>

" YouCompleteMe
nmap <leader>t :YcmCompleter GetType<cr>
nmap <leader>d :YcmCompleter GoToDefinitionElseDeclaration<cr>
nmap <leader>f :YcmCompleter GoToReferences<cr>

"""" GOLANG
autocmd FileType go nmap <leader>gr :GoRename<cr>
autocmd FileType go nmap <leader>gd :GoDoc<cr>
autocmd FileType go nmap <leader>gR :w <bar> :GoRun<cr>
autocmd FileType go nmap <leader>gb :w <bar> :GoBuild<cr>
autocmd FileType go nmap <leader>gg :w <bar> :GoTest<cr>
autocmd FileType go nmap <leader>go :GoDocBrowser<cr>
" Use YouCompleter for these instead
" autocmd FileType go nmap <leader>gd <plug>(go-def-split)
" autocmd FileType go nmap <leader>gf :GoReferrers<cr>

"""" PYTHON
" F9 runs current file as python script
autocmd FileType python map <buffer> <F9> :exec '!python3' shellescape(@%, 1)<cr>
" Same as above, but letting user enter any arguments before executing
autocmd FileType python map <F10> :exec '!python3' shellescape(@%, 1) 'args'
autocmd FileType python nmap <leader>gr :w <bar> exec '!python3' shellescape(@%, 1) 'args'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Search
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Search and Replace from current line to last
nmap <leader>sr :.,$s///gI<left><left><left><left>

" In visual mode, pressing 'a' results in yanking
" current selection and then make an interactive search and replace
" ,$ -> .,$ (current position to end)
" % -> 1,$ (the whole file from start)
" TODO: Fix so that we wrap around the file and back to current position
vmap a y<esc>:<c-r>=GetSearchFromYanked(",$s", "gc")<cr><left><left><left>
" 'A' searches and replaces all occurrences in the file
vmap A y<esc>:<c-r>=GetSearchFromYanked("%s", "gi")<cr><left><left><left>


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

function! GetSearchFromYanked(pre, post)
    return a:pre . ":" . EscapeYanked() . "::" . a:post
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
