#!/usr/bin/env bash

while read p
do
    POPULATION=${p}
    cd $POPULATION
    rm ${POPULATION}.map
    singularity run -B /panicle ~/singularity_containers/gc.simg \
        python -m schnablelab.imputation.GC vcf2map \
        ${POPULATION}.imp.prn.maf.vcf.recode.vcf ${POPULATION}.map
    cd ../
done < files.txt
