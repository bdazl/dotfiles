#!/bin/zsh
# Copyright (c) 2018-2025 Jacob Peyron <jacob.peyron@gmail.com>
# Use of this source code is governed by an ICU License that can be found in the LICENSE file

echo-if-dir-exists() {
    if [ -d "${1}" ]; then
        echo ${1}
    fi
}

remove-non-existing() {
    local out=""
    for arg do
        e="$(echo-if-dir-exists $arg)"

        # if length of string is non-zero
        if [ -n "$e" ]; then
            out+="$e "
        fi
    done
    echo $out
}

echo-user-dirs() {
    # User-owned bin directories, highest precedence.
    # These must win over system/brew tools so our own scripts
    # (e.g. ~/bin/copy, ~/bin/paste) shadow any same-named utility.
    pth=( \
        $(remove-non-existing \
            "$HOME/.local/bin" \
            "$HOME/bin" \
            "$HOME/go/bin" \
            "$HOME/.cargo/bin" \
            "$HOME/.elan/bin" \
        ) \
    )

    # Join spaces with :
    echo "${(j.:.)pth}"
}

echo-path-base() {
    # User dirs first, then the inherited PATH.
    echo "$(echo-user-dirs):${PATH}"
}

echo-path-osx() {
    if [[ -x "${BREW_BIN}" ]]; then
        # If nothing is found, dont't print error messages
        setopt local_options null_glob

        for bindir in "$BREW_PREFIX/opt/"*"/libexec/gnubin"; do
            [[ -d "$bindir" ]] && gnubin=$bindir:$gnubin
        done
        for bindir in "$BREW_PREFIX/opt/"*"/bin"; do
            [[ -d "$bindir" ]] && gnubin=$bindir:$gnubin
        done
        #for mandir in "${BREW_PREFIX}/opt/"*"/libexec/gnuman"; do export MANPATH=$mandir:$MANPATH; done
        #for mandir in "${BREW_PREFIX}/opt/"*"/share/man/man1"; do export MANPATH=$mandir:$MANPATH; done
    fi
    
    echo "${BREW_PREFIX}/bin:${BREW_PREFIX}/sbin:${gnubin}"
}
    
echo-path() {
    u_name="$(uname)"
    case $u_name in
        Darwin):
            # User dirs first so our own scripts win, then brew (gnubin
            # shadows BSD tools), then the inherited system PATH.
            brew_path="$(echo-path-osx)"
            echo "$(echo-user-dirs):$brew_path:${PATH}"
            ;;
        *)
            echo "$(echo-path-base)"
            ;;
    esac

}

echo-pythonpath() {
    pth=( \
        $(remove-non-existing \
            "$HOME/.etc/lib/py" \
        ) \
        ${PYTHONPATH} \
    )
    echo "${(j.:.)pth}"
}

export PATH=$(echo-path)
export PYTHONPATH=$(echo-pythonpath)
