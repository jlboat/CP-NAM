#!/usr/bin/env bash

while read p
do
    cd $p
    ln -s ../../pmap_${p}.csv
    ln -s ../../gmap_${p}.csv
    ln -s ../../rqtl2_${p}.yaml
    ln -s ../../${p}.H_missing.rqtl2.csv
    cd ../
done < lines.txt
