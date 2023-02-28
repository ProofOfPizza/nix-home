#/bin/bash

OPERATION=$1
DIR=$2
FILES=$(find $DIR -maxdepth 1 -type f)
for FILE in $FILES
do
  echo "processing file with sope $1 -i: $FILE"
  sops $1 -i $FILE
done
