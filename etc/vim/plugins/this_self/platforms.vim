if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

if has("gui_running")
    if g:os == "Darwin"
		" OSX
        "set guifont=Fira\ Mono:h12

    elseif g:os == "Linux"
        "set guifont=Fira\ Mono\ 10
        "
        " Airline status bar
        "let g:airline#extensions#tabline#enabled = 1
        let g:airline_theme = 'solarized'
        let g:airline_solarized_bg = 'dark'
        " let g:airline_powerline_fonts = 1

    elseif g:os == "Windows"
        "set guifont=Fira_Mono:h12:cANSI

    endif
endif
