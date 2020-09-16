#!/usr/bin/env bash

DESIGN_FILE="Population_keys.txt"
ALL_PHENOTYPES="All_pericarp_phenotypes_withBrown.csv"

for i in {1..12}
do
    DESIGN=$(cat ${DESIGN_FILE} | head -n ${i} | tail -n 1)
    IFS=',' read -ra ARRAY <<< "${DESIGN}"
    NUMBER="${ARRAY[0]}"
    POPULATION="${ARRAY[1]}"
    head -n 1 ${ALL_PHENOTYPES} > ${POPULATION}.phenotypes.csv
    grep -F "${NUMBER}" ${ALL_PHENOTYPES} >> ${POPULATION}.phenotypes.csv
    grep ${POPULATION} ${ALL_PHENOTYPES} >> ${POPULATION}.phenotypes.csv
    grep "Grassl" ${ALL_PHENOTYPES} >> ${POPULATION}.phenotypes.csv
done

