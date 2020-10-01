#!/usr/bin/env bash

# b=1
# r=2
# w=3
# y=4

# yellow - other
awk '{if ($3 == 4) print $1"\t"$2"\t"1; else print $1"\t"$2"\t"2}' Plink.pericarp.tsv > Whites.pericarp.tsv


# red, yellow, white
# awk '{if ($3 == 3) print $1"\t"$2"\t"1; else if ($3 == 4) print $1"\t"$2"\t"2; else print $1"\t"$2"\t"3;}' Plink.pericarp.tsv > Whites.pericarp.tsv

