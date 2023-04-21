#!/bin/zsh

src_token() {
    export ACCESS_TOKEN=$(cat "$1" | tr -d "\n")
    export TOKEN_H="PRIVATE-TOKEN: $ACCESS_TOKEN"
}
alias src_got='src_token ~/cfg/gototsatrium-token && echo $ACCESS_TOKEN'
alias src_gotproj='src_token ~/cfg/project-token && echo $ACCESS_TOKEN'

export KUBECONFIG=~/cfg/config

export GL_URL="https://gototsatrium8p.got.jeppesensystems.com"
export GL_API="$GL_URL/api/v4"

src_got > /dev/null
# export ACCESS_TOKEN=$(cat ~/cfg/gototsatrium-token | tr -d "\n")
# export TOKEN_H="PRIVATE-TOKEN: $ACCESS_TOKEN"

export DOCKER_BUILD_EXTRA="--format docker"
