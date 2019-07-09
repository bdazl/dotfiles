#!/bin/bash
#
# This script assumes that $CSCOPE_DB is setup

gopath=$(go env GOPATH)
go_src=$gopath/src
files=/tmp/cscope.files

find $go_src -name "*.go" -print > $files

if cscope -b -k $files; then
    mv cscope.out $CSCOPE_DB
    echo "Done"
else
    echo "Failed"
    exit 1
fi
