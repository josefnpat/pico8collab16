#!/bin/sh
for file in collab_*/ ; do
  ./build.sh ${file%/}
done
