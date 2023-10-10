if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

let g:wsl = 0

if g:os == "Linux"
	let lines = readfile("/proc/version")
    if lines[0] =~ "microsoft"
        let g:wsl = 1
    else
        let g:wsl = 0
    endif
endif
