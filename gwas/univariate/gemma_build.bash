VCF="NAM.imputed.pruned.recode.vcf" # Your VCF file
PLINK_OUTPUT="plink.pruned"
PHENOTYPES="Plink.pericarp.tsv"
MISSING=0.3
START="y"

TMPDIR="."

if [ ${START} == "y" ]
then
    echo "/panicle/software/vcftools-0.1.16/bin/vcftools --vcf ${VCF} --plink --out ${PLINK_OUTPUT}"
    /panicle/software/vcftools-0.1.16/bin/vcftools --vcf ${VCF} --plink --out ${PLINK_OUTPUT}

    /panicle/software/Plink/plink --file ${PLINK_OUTPUT} --pheno ${PHENOTYPES} \
        --allow-no-sex --make-bed --out ${PLINK_OUTPUT} 
fi

# gk=1 (centered relatedness matrix) gk=2 (standardized relatedness matrix)
/panicle/software/gemma-0.98.1 -bfile ${PLINK_OUTPUT} -gk 2 -o ${PLINK_OUTPUT} -hwe 0 -miss ${MISSING} -maf 0.05

/panicle/software/gemma-0.98.1 -bfile ${PLINK_OUTPUT} \
    -k ./output/${PLINK_OUTPUT}.sXX.txt \
    -eigen -o ${PLINK_OUTPUT} \
    -miss ${MISSING} -hwe 0 -maf 0.05 
