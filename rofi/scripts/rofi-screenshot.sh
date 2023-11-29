#!/bin/env bash

chosen=$(printf "󰊓 Screen"'\n'"󰩭 Partial" | rofi -dmenu -i)

case "$chosen" in
        "󰊓 Screen") grim -t jpeg - | swappy -f -
        ;;
        "󰩭 Partial") grim -g "$(slurp)" -t jpeg - | swappy -f -
        ;;
esac
