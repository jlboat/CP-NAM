#!/usr/bin/env bash

OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize variables:
VCF_IN=""
VCF_OUT=""
THIN="0"
HWE="0"
SITE_MISS="1"

while getopts "h?i:o:t:a:e:m:" opt; do
    case "${opt}" in
        h|\?)
            printf "\nEx. bash filterVcf.bash -i input.vcf -o output_basename \n\
                -i      input VCF file -- one per line (required)\n\
                -o      output basename for new VCF (required)\n\
                -t      thinning distance in bases (optional)\n\
                -a      minor allele frequency (optional)\n\
                -e      hardy-weinberg equilibrium filter (optional)\n\
                -m      proportion missing sites (optional)\n\n";
            exit 0;
            ;;
        i)  INPUT=${OPTARG}
            ;;
        o)  OUTPUT=${OPTARG}
            ;;
        t)  THIN=${OPTARG}
            ;;
        a)  MAF=${OPTARG}
            ;;
        e)  HWE=${OPTARG}
            ;;
        m)  SITE_MISS=${OPTARG}
            ;;
    esac
done
shift $((OPTIND -1))

if [ "${VCF_IN}" == "" ]
then
    bash /panicle/Scripts/filterVcf.bash -h
    exit 0;
fi

if [ "${VCF_OUT}" == "" ]
then
    bash /panicle/Scripts/filterVcf.bash -h
    exit 0;
fi

/panicle/software/vcftools-0.1.16/bin/vcftools --thin ${THIN} --maf ${MAF} --hwe ${HWE} --max-missing ${SITE_MISS} --vcf ${VCF_IN} --recode --out ${VCF_OUT}
