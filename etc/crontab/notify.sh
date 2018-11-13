#!/bin/bash

users=$(users)
if [[ -n "$users" ]]; then
    notify-send "$1 ($users)"
fi

