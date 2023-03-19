set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Auto-complete / Intellisense for many languages
Plugin 'Valloric/YouCompleteMe'
" Status bar
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'fatih/vim-go'

Plugin 'francoiscabrol/ranger.vim'

Plugin 'tpope/vim-fugitive'

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'simnalamburt/vim-mundo.git'

Plugin 'crusoexia/vim-monokai'

Plugin 'iamcco/markdown-preview.nvim'

" Realtime linting (python and others)
Plugin 'dense-analysis/ale'

Plugin 'jmcantrell/vim-virtualenv'
Plugin 'PieterjanMontens/vim-pipenv'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
" let g:ycm_global_ycm_extra_conf = '/usr/share/vim/vimfiles/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'

" Airline status bar
"let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'solarized'
let g:airline_solarized_bg = 'dark'
" let g:airline_powerline_fonts = 1

let g:virtualenv_directory = '~/.local/share/virtualenvs'

let b:ale_fixers = ['autopep8', 'mypy', 'isort', 'yapf', 'remove_trailing_lines', 'trim_whitespace']
