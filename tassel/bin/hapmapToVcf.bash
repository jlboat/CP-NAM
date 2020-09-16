#!/usr/bin/env bash

HAPMAP=$1

~/tassel-5-standalone/run_pipeline.pl -Xmx5g -fork1 -h ${HAPMAP} -export -exportType VCF -runfork1
