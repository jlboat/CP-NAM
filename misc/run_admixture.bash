#!/usr/bin/env bash

for K in 16 17 18 19 20
do
    /zfs/tillers/panicle/bin/admixture plink.pruned.bed $K -j16 --cv=5 | tee log${K}.out
done
