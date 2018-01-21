#!/bin/bash


# Usage: ./playlist-collector -d=<destination-folder> -p=<youtube-playlist-link>

DIRECTORY="songs"
PLAYLIST_LINK=""

for i in "$@"
do
case $i in
    -d=*|--directory=*)
    DIRECTORY="${i#*=}"
    shift # past argument=value
    ;;
    -p=*|--playlist=*)
    PLAYLIST_LINK="${i#*=}"
    shift # past argument=value
    ;;
  *)
    ;;
esac
done


# Create destination directory if not exists
mkdir -p ${DIRECTORY}


SONGS_LINKS=$(curl ${PLAYLIST_LINK} | grep -Po '(?<=href=")[^"]*' | grep index)

i=0

for song in ${SONGS_LINKS}
do
  link="https://www.youtube.com${song}"
  DESTINATION="${DIRECTORY}/song${i}.mp3"

  echo DOWNLOADING ${link}\n
  echo ${DESTINATION}

  youtube-dl --extract-audio --audio-format mp3 "$link" --output ${DESTINATION}
  i="$[$i+1]"
done
