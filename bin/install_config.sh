#! /bin/bash

GITDIR="$PWD/.git"
if [ ! -d "$GITDIR" ];
then
  echo "Execute command from the root of the config git repository"
  exit 1
fi

for FILE in $(ls -a)
do
  if [ "$FILE" != "." -a "$FILE" != ".." -a "$FILE" != ".git" ];
  then
    SRC="$PWD/$FILE"
    DST="~/$FILE"
    rm -f "$DST"
    ln -s "$SRC" "$DST"
  fi
done
