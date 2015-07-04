#!/bin/bash
# This is my media renamer using Filebot; version 1.2

while getopts :xrmsh
	case $option in
		x) unrar=$OPTARG;;
		r) rmFiles=$OPTARG;;
		m) meida=$OPTARG;;
		h) help=$OPTARG;;
	esac

if [ $help == h ]; then
	echo "-x: unrar and process media files"
	echo "-r: remove .r*, .nfo, and .sfv files"
	echo "-m: process media files"
	echo "-s: process sub files"
	echo "-m: process media files"
fi

if [ $unrar == x ]; then
	rarCount=$(find . -maxdepth 1 -type f -name "*.rar" | wc -l)
	if [ $rarCount == 0 ]; then
		echo "No rar files found."
		exit 1
	elseif [ $rarCount == 0 ]; then
		echo "There is $rarCount file(s) to be rar'd. Unraring now..."
		rarFile=$(find . -maxdepth 1 -type f -name "*.rar")
		unrar x $rarFile
		echo "Done."
fi

fileCount=$(find . -maxdepth 1 -type f \( -name "*.mkv" -or -name "*.mp4" -or -name "*.avi" \) | wc -l)
# echo $fileCount
if [ $fileCount == 1 ]; then
	mediaFile=$(find . -maxdepth 1 -type f \( -name "*.mkv" -or -name "*.mp4" -or -name "*.avi" \))
	fileName=$(echo $mediaFile | sed 's/\.\///g')
elif [ $fileCount == 0 ]; then
	echo "No media files found."
	exit 1
else
	echo "Too many media files found:"
	echo $(find . -maxdepth 1 -type f \( -name "*.mkv" -or -name "*.mp4" -or -name "*.avi" \))
	exit 1
fi
#
echo "Media file found: $fileName"
read -p "Do you want to rename this one [Y/N]? " goOn
goOn=$(echo $goOn | tr '[A-Z]' '[a-z]')
if [ $goOn == "n" ]; then
	echo "Then try again."
	exit 1
fi
read -p "Enter search name: " searchName
read -p "Enter database [1=TheMovieDB or 2=TheTVDB]: " database
if [ $database == 1 ]; then
	database="TheMovieDB"
elif [ $database == 2 ]; then
	database="TheTVDB"
fi
read -p "Non-Strict [Y/N]? " strict
read -p "Test [Y/N]?: " actionTest
#
strict=$(echo $strict | tr '[A-Z]' '[a-z]')
actionTest=$(echo $actionTest | tr '[A-Z]' '[a-z]')
#
#echo $goOn
#echo $searchName
#echo $database
#echo $actionTest
#echo $strict
#
if [ $actionTest == "n" ] && [ $strict == "n" ]; then
	mytime=$( TIMEFORMAT='%R';time ( ls ) 2>&1 1>/dev/null )
	echo "----------------Filebot Running-----------------"
	filebot -rename "$fileName" "$searchName" $database
	echo "Completed in: $mytime seconds."
	exit 1
elif [ $actionTest == "y" ] && [ $strict == "n" ]; then
	mytime=$( TIMEFORMAT='%R';time ( ls ) 2>&1 1>/dev/null )
	echo "----------------Filebot Running-----------------"
	filebot -rename "$fileName" "$searchName" $database --action test
	echo "Completed in: $mytime seconds."
	exit 1
elif [ $actionTest == "n" ] && [ $strict == "y" ]; then
	mytime=$( TIMEFORMAT='%R';time ( ls ) 2>&1 1>/dev/null )
	echo "----------------Filebot Running-----------------"
	filebot -rename "$fileName" "$searchName" $database -non-strict
	echo "Completed in: $mytime seconds."
	exit 1
elif [ $actionTest == "y" ] && [ $strict == "y" ]; then
	mytime=$( TIMEFORMAT='%R';time ( ls ) 2>&1 1>/dev/null )
	echo "----------------Filebot Running-----------------"
	filebot -rename "$fileName" "$searchName" $database -non-strict --action test
	echo "Completed in: $mytime seconds."
	exit 1
fi
