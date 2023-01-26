#!/bin/bash

filename="${1%%.*}"
extension="${1##*.}"

case $extension in
    "cpp")  # C++
        g++ "$1" -o "$filename" 
        chmod +x "./$filename"
        ./"$filename"
        rm "$filename"
        ;;
    "c")  # C
        gcc "$1" -o "$filename" 
        chmod +x "./$filename"
        ./"$filename"
        rm "$filename"
        ;;
    "py")  # Python
        python3 "$1"
        ;;
    "sh")  # Shell
        chmod +x "./$1"
        ./"$1"
        ;;
    "")
        echo "Usage: run <file>"
        ;;
    *) 
        echo "This language is not supported or the file has the wrong extension."
esac

