#!/usr/bin/env bash

VCF=NAM.imputed.ann.vcf.gz
WINDOW=10000

for POPULATION in Chinese_Amber Leoti PI_297130 PI_506069 PI_508366 PI_510757 PI_329311 Rio PI_229841 PI_297155 PI_655972
do
    vcftools --gzvcf ${VCF} --keep ${POPULATION}.txt --out nt_diversity.${POPULATION} --site-pi
    #--window-pi ${WINDOW}
done

for POPULATION in Chinese_Amber Leoti PI_297130 PI_506069 PI_508366 PI_510757 PI_329311 Rio PI_229841 PI_297155 PI_655972
do
    vcftools --gzvcf ${VCF} --keep ${POPULATION}.txt --out tajd.${POPULATION} --TajimaD ${WINDOW}
done

