#!/usr/bin/env bash

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize variables:
INPUT=""
OUTPUT=""

while getopts "h?i:o:" opt; do
    case "${opt}" in
        h|\?)
            printf "\nEx. bash snpEff.bash -i snps.vcf -o output.vcf n\n\
                -i      input VCF file (required)\n\
                -o      output VCF file (required)\n\
                ";
            exit 0;
            ;;
        i)  INPUT=${OPTARG}
            ;;
        o)  OUTPUT=${OPTARG}
            ;;
    esac
done
shift $((OPTIND -1))

if [ "${INPUT}" == "" ]
then
    printf "\nbash snpEff.bash -i snps.vcf -o output.vcf    -i REQUIRED\n\n"
    exit 0;
fi

if [ "${OUTPUT}" == "" ]
then
    printf "\nbash snpEff.bash -i snps.vcf -o output.vcf    -o REQUIRED\n\n"
    exit 0;
fi

java -jar -Xmx4g /panicle/software/snpEff/snpEff.jar ann -c /panicle/software/snpEff/snpEff.config -csvStats NAM.annotation Sbicolor_v3 ${INPUT} > ${OUTPUT}
