#!/bin/bash
# This is my TV renamer using filebot

#fileCount=$(echo ${#mediaFile[*]})
#fileCount=$(find . -type f \( -name "*.mkv" -or -name "*.mp4" -or -name "*.avi" \) | wc -l)
mediaFile=$(find . -type f \( -name "*.mkv" -or -name "*.mp4" -or -name "*.avi" \))
fileName=$(echo "$mediaFile" | sed 's/\.\///g')
#echo $fileCount
#if [ "$fileName" == 1 ]; then
	filebot -rename "$fileName" "*" TheTVDB -non-strict
#else
#	exit 1
#fi
