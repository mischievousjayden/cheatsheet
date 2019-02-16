#!/bin/bash

num=16
for i in {0..255} ; do
    printf "\x1b[38;5;${i}m%4d" $i
    if ((i % num == num-1)); then
        echo ""
    fi
done

for((i=0; i<256; i++)); do
    printf "\e[48;5;${i}m%03d" $i;
    printf '\e[0m';
    [ ! $((($i + 1) % $num)) -eq 0 ] && printf ' ' || printf '\n'
done
