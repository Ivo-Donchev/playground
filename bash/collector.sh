#!/bin/bash

DIRECTORY="songs/"
SOURCE_FILE="links.txt"

for i in "$@"
do
case $i in
    -d=*|--directory=*)
    DIRECTORY="${i#*=}"
    shift # past argument=value
    ;;
    -s=*|--source-file=*)
    SOURCE_FILE="${i#*=}"
    shift # past argument=value
    ;;
  *)
    ;;
esac
done

# Create destination directory if not exists
mkdir -p ${DIRECTORY}


# Read the links from the ${SOURCE_FILE} and saves it to ${DIRECTORY}
i="0"

while read link; do
  youtube-dl --extract-audio --audio-format wav $link --output "${DIRECTORY}/song${i}.wav"

  i=$[$i+1]
done <${SOURCE_FILE}
