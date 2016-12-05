#!/bin/sh
TARGET=${1?missing target argument}
GIT=`git log --pretty=format:'%h' -n 1 $TARGET`
GIT_COUNT=`git log --pretty=format:'' $TARGET | wc -l`
OUTPUT=$TARGET-v${GIT_COUNT}.p8

cat $TARGET/header.lua > ${OUTPUT}
echo "git,git_count = \"$GIT\",\"$GIT_COUNT\"" >> ${OUTPUT}

for file in $TARGET/lua/* ; do
  cat $file >> ${OUTPUT}
  printf "\n" >> ${OUTPUT}
done

echo "__gfx__" >> ${OUTPUT}
for file in $TARGET/gfx/gfx* ; do
  cat $file >> ${OUTPUT}
done

echo "__gff__" >> ${OUTPUT}
cat $TARGET/gff >> ${OUTPUT}

echo "__map__" >> ${OUTPUT}
for file in $TARGET/map/map* ; do
  cat $file >> ${OUTPUT}
done

echo "__sfx__" >> ${OUTPUT}
for file in $TARGET/sfx/sfx* ; do
  cat $file >> ${OUTPUT}
done

echo "__music__" >> ${OUTPUT}
for file in $TARGET/music/music* ; do
  cat $file >> ${OUTPUT}
done
