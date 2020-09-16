#!/usr/bin/env bash

singularity run ~/singularity_containers/popLdDecay.sif PopLDdecay -InVCF NAM.imputed.vcf -MaxDist 600 -MAF 0.1 -OutStat NAM.stat.gz

for i in 01 02 03 04 05 06 07 08 09 10
do
    singularity run ~/singularity_containers/popLdDecay.sif PopLDdecay -InVCF NAM.imputed.Chr${i}.recode.vcf -MaxDist 600 -MAF 0.1 -OutStat NAM.chr${i}.stat.gz
    singularity run ~/singularity_containers/popLdDecay.sif /opt/PopLDdecay/bin/Plot_OnePop.pl -inFile NAM.chr${i}.stat.gz -output chr${i}.ld_decay
done
