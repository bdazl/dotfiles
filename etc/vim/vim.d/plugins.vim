if !has('nvim')
    call plug#begin('~/.vim/plugged')

    Plug 'Valloric/YouCompleteMe', { 'do': './install.py --go-completer' }

    Plug 'simnalamburt/vim-mundo'          " undo tree
    Plug 'vim-airline/vim-airline'         " status bar
    Plug 'vim-airline/vim-airline-themes'  " status bar themes
    Plug 'christoomey/vim-tmux-navigator'  " awareness of tmux-panes

    Plug 'fatih/vim-go'                    " golang
    Plug 'dense-analysis/ale'              " python linting
    Plug 'neovimhaskell/haskell-vim'       " haskell
    Plug 'hashivim/vim-terraform'          " terraform

    Plug 'junegunn/fzf'                    " fzf fuzzy search
    Plug 'junegunn/fzf.vim'                " fuzzy search
    Plug 'francoiscabrol/ranger.vim'       " ranger (file explorer)

    Plug 'tpope/vim-fugitive'              " git

    call plug#end()

    let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
    let g:ycm_goto_buffer_command = 'same-buffer'
    let g:ycm_collect_identifiers_from_tags_files = 1
endif

" Airline status bar
set rtp+=~/.etc/etc/vim
let g:airline_theme = 'quiet'
let g:airline_powerline_fonts = 0
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#whitespace#enabled = 0
if !has('nvim')
    let g:airline_section_z = '%p%% %l:%c'
    let g:airline_section_warning = ''
    let g:airline_section_error = ''
endif

" :help ale-python-options
let b:ale_fixers = ['black', 'autoimport', 'isort', 'yapf', 'remove_trailing_lines', 'trim_whitespace']
let g:ale_python_flake8_options = '--max-line-length=88'
" let g:ale_fix_on_save = 1

" Ranger defaults to:
" map <leader>f :Ranger<CR>
let g:ranger_map_keys = 0
let g:ranger_command_override = 'ranger --cmd "set show_hidden=true"'

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
    let options = {'options': ['--info=inline', '--preview', '~/.etc/bin/preview {}']}
    call fzf#vim#files(dir, options, a:bang)

    " Restore
    let g:fzf_action = pre_fzf_action
endfunction
