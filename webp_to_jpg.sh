#!/bin/bash

# Simple script to convert all webp to jpg in a directory using imagemagick convert
# Usage: webp_to_jpg.sh <directory>

dir=$1

# Check if path argument has been passed

if [ $# -eq 0 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Check if convert command exist

if ! command -v convert >/dev/null 2>&1; then
    echo "Error: convert command not found, please install imagemagick"
    exit 1
fi

# check file presence in $dir

for file in $dir*.webp; do
    if [ ! -f $file ]; then
        echo "No .webp files in $dir"
        exit 1
    fi
done

# and convert them to jpg and remove the webp source

for file in $dir*.webp; do
    convert $file ${file%.webp}.jpg >/dev/null 2>&1
    # if convert error, fingerpoint it
    if [ $? -ne 0 ]; then
        echo "Error converting $file"
        continue
    fi
    echo Converted $file to ${file%.webp}.jpg
    echo Removing $file ...
    rm $file # remove webp file
done

echo "No more files to convert"
exit 0
