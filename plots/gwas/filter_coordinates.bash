#!/usr/bin/env bash

# NAM=NAM.imputed.pruned.recode.vcf
NAM=NAM.imputed.ann.vcf.gz

# 62463940
vcftools --gzvcf ${NAM} --keep phenotyped_individuals.txt \
    --maf 0.05 --chr 04 --from-bp 62363940 --to-bp 62563940 \
    --out NAM.tan1 --recode

# 6940113
vcftools --gzvcf ${NAM} --keep phenotyped_individuals.txt \
    --maf 0.05 --chr 02 --from-bp 6840113 --to-bp 7040113 \
    --out NAM.tan2 --recode

# 57797411
vcftools --gzvcf ${NAM} --keep phenotyped_individuals.txt \
    --maf 0.05 --chr 02 --from-bp 57697411 --to-bp 57897411 \
    --out NAM.z --recode

# 8111484
vcftools --gzvcf ${NAM} --keep phenotyped_individuals.txt \
    --maf 0.05 --chr 07 --from-bp 8011484 --to-bp 8211484 \
    --out NAM.unknown --recode

# 1948816
vcftools --gzvcf ${NAM} --keep phenotyped_individuals.txt \
    --maf 0.05 --chr 10 --from-bp 1848816 --to-bp 2098816 \
    --out NAM.waxy --recode
