PLINK_OUTPUT="plink.pruned" # The output name for Plink data

/panicle/software/gemma-0.98.1 -bfile ${PLINK_OUTPUT} \
    -d ./output/${PLINK_OUTPUT}.eigenD.txt -u ./output/${PLINK_OUTPUT}.eigenU.txt \
    -lmm 4 -n 1 2 -o "${PLINK_OUTPUT}" -maf 0.05 -hwe 0 -miss 0.3 -r2 0.9

