#!/bin/bash

npm install

FILE="node_modules/react-dom/umd/react-dom.production.min.js"

ls -hal $FILE

if [ -e "$FILE" ]; then
  printf "\n\nFile %s exists on disk\n\n" "$FILE";
else
  echo "File $FILE does NOT exist on disk";
  exit 1;
fi

GLOB="!/$FILE"
printf "\n\n>>> Trying with the simple glob: %s...\n\n" "$GLOB";

npx web-ext build --overwrite-dest --ignoreFiles $GLOB

ZIP_FILES=$(unzip -l web-ext-artifacts/hello-0.1.8.zip)

echo; echo;

if [ "$(echo "$ZIP_FILES" | grep "$(basename "$FILE")")" = "" ]; then
  echo ">>> Target file is NOT in the zip file";
else
  echo ">>> Target file IS in the zip file";
fi



GLOB="!**/node_modules !**/node_modules/**/react-dom !**/node_modules/**/react-dom/umd !**/node_modules/**/*/react-dom.production.min.js"
printf "=================== \n\n>>> Now trying with the needlessly complex glob: %s...\n\n" "$GLOB";

npx web-ext build --overwrite-dest --ignoreFiles --ignore-files $GLOB

ZIP_FILES=$(unzip -l web-ext-artifacts/hello-0.1.8.zip)

echo; echo;

if [ "$(echo "$ZIP_FILES" | grep "$(basename "$FILE")")" = "" ]; then
  echo ">>> Target file is NOT in the zip file";
else
  echo ">>> Target file IS in the zip file";
fi
