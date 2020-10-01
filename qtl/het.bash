#!/usr/bin/env bash

while read p
do
    LINE=${p}
    vcftools --vcf ${LINE}/${LINE}.imp.prn.maf.vcf.recode.vcf --out ${LINE}/${LINE}.vcftools --het
done < files.txt
