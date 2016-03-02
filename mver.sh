#!/bin/bash
# This is my quick movie renamer using filebot

mediaFile=$(find . -type f \( -name "*.mkv" -or -name ".mp4" -or -name ".avi" \))
fileName=$(echo "$mediaFile" | sed 's/\.\///g')

filebot -rename "$fileName" "*" TheMovieDB
