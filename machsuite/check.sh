#!/bin/zsh

echo 'A non-zero number after the filename indicates that it cannot be compiled'

for file in *.fuse; do
 fud e --to futil $file >/dev/null 2>&1
echo $file : $?
done

echo 'Following files are skipped'
echo *.skip
