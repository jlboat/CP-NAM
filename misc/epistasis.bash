#!/usr/bin/env bash

~/Plink/plink --file plink.pruned --epistasis --set-test --set top_snps.txt --pheno Plink.pericarp.tsv --allow-no-sex
