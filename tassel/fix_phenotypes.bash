#!/usr/bin/env bash

while read p
do
    cd $p
    sed 's/,r/,1/g' ${p}.phenotypes.csv | sed 's/,b/,2/g' | sed 's/,y/,3/g' | sed 's/,w/,4/g' > ${p}.phenotypes.numeric.csv
    cd ../
done < lines.txt
