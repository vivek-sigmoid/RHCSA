#!/bin/bash
set -e
$(touch unique.txt)
file=$(find / resource.*)
compression_details=$(file -b $file)
compression_type="${compression_details%%,*}"
gzip="gzip compressed data"
bzip2="bzip2 compressed data"
zip="Zip archive data"
if [ "$compression_type" = "$gzip" ];
then
    gzip -c -d $file > resource.txt
elif [ "$compression_type" = "$bzip2" ];
then
    bunzip2 -d $file
elif [ "$compression_type" = "$zip" ] ;
then
    unzip resource.zip
fi
file=$(find resource.txt)
prev="fghjklyuierjgjtrdfefytcd44"
while read line; do
if [ "$prev" = "$line" ];
then
echo $line >> unique.txt
fi
prev=$(echo $line)
done < $file
ln unique.txt final.txt
mv unique.txt .unique.txt
