set history=500
set encoding=utf8
set fileformats=unix,dos,mac "unix is standard fileformat
filetype plugin on
filetype indent on
syntax enable "syntax highlighting

set t_Co=256 "256 colors palette

set expandtab "spaces instead of tabs
set smarttab
set shiftwidth=4
set tabstop=4
"set linebreak
set textwidth=500

set autoindent
set si "smart indent
set wrap "wrap lines
set whichwrap+=<,>,h,l

set ruler          "always show current position
set number         "margin has current line number
set relativenumber "margin shows relative numbers for other lines
set foldcolumn=0   "extra margin to the left

set cmdheight=1 "command bar height
set showmatch   "show matching brackets when text indicater is over them

" Set to auto read when a file is changed from the outside
" set autoread

set directory=$HOME/.vim/swap//
set backupdir=$HOME/.vim/backup//

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Don't push the cursor around after leaving insert mode
au InsertLeave * call cursor([getpos('.')[1], getpos('.')[2]+1])

" No annoying sound on errors
set noerrorbells
set visualbell
set t_vb=

" Find tags file from current dir and upward to home
" set tags=tags;~;
set tags^=./.git/tags;

set mat=2 "tenths of a seconds to blink when matching brackets
set hid "buffer becomes hidden when it is abandoned

set backspace=eol,start,indent

set ignorecase "ignore case when searching
set smartcase "smart case search
set hlsearch "highlight search result
set incsearch "match (so far) during typing
set magic "regular expressions

set lazyredraw  "don't redraw while executing macros

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"slate, elflord, wildcharm, monokai, lunaperche
colorscheme wildcharm
set background=dark

" Don't let the colorscheme mess with transparency (let the terminal dictate)
function! AdaptColorscheme()
    highlight clear CursorLine
    highlight Normal ctermbg=none
    highlight LineNr ctermbg=none
    highlight Folded ctermbg=none
    highlight NonText ctermbg=none
    highlight SpecialKey ctermbg=none
    highlight VertSplit ctermbg=none
    highlight SignColumn ctermbg=none
endfunction
autocmd ColorScheme * call AdaptColorscheme()


" Ensure PEP8 indentation
autocmd FileType python
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix
