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

Plugin 'majutsushi/tagbar'
Plugin 'simnalamburt/vim-mundo.git'

Plugin 'junegunn/fzf.vim'

Plugin 'crusoexia/vim-monokai'

Plugin 'iamcco/markdown-preview.nvim'

" Realtime linting (python and others)
Plugin 'dense-analysis/ale'

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

" :help ale-python-options
let b:ale_fixers = ['black', 'autoimport', 'isort', 'yapf', 'remove_trailing_lines', 'trim_whitespace']
let g:ale_python_flake8_options = '--max-line-length=88'
" let g:ale_fix_on_save = 1

" Ranger defaults to:
" map <leader>f :Ranger<CR>
let g:ranger_map_keys = 0

" fzf
let g:fzf_preview_window = ['right,50%', 'ctrl-p']
command! -bang -nargs=? -complete=dir Files
            \ call MyFZFFiles(<q-args>, <bang>0)

function! MyFZFFiles(dir, bang)
    if !empty(a:dir)
        let dir = a:dir
    else
        let dir = getcwd()
    endif

    " Store previous value of global variable g:fzf_action and reset it after call
    " This is the only call (:Files) where I want enter to default to new tab
    let default = { 'enter': 'e', 'ctrl-t': 'tab split', 'ctrl-x': 'split', 'ctrl-v': 'vsplit' }
    let pre_fzf_action = get(g:, 'fzf_action', default)
    let g:fzf_action = { 'enter': 'tab split', 'ctrl-t': 'e' }

    " Wrapped call
    " * Full screen, not windowed
    " * Always open results/files in new tab
    " * Preview using my script
    let options = {'options': ['--info=inline', '--preview', '~/.dotfiles/scripts/preview.sh {}']}
    call fzf#vim#files(dir, options, a:bang)

    " Restore
    let g:fzf_action = pre_fzf_action
endfunction
