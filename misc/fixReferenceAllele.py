import sys
import argparse
from Bio import SeqIO

def parse_arguments():
    """Parse arguments passed to script"""
    parser = argparse.ArgumentParser(description="This script was " + 
        "designed to find reference alleles in a FASTA and fix VCF " + 
        "variants with the correct REF allele.\n\n")

    requiredNamed = parser.add_argument_group('required arguments')

    requiredNamed.add_argument(
        "--fasta", 
        type=str, 
        required=True, 
        help="The name of the FASTA file.",
        action="store")

    requiredNamed.add_argument(
        "--vcf",
        type=str,
        required=True,
        help="The name of the VCF file.",
        action="store")

    return parser.parse_args()                    


def read_fasta(fasta_file):
    """Return FASTA object from file name"""
    return SeqIO.read(fasta_file, "fasta")


def fix_variant(variant, ref_allele):
    """Switch the incorrect reference allele with the true reference allele"""
    vcf_ref_allele = variant[3]
    alt_alleles = variant[4].split(',')
    try:
        true_ref_index = alt_alleles.index(ref_allele)
    except ValueError:
        sys.stderr.write("WARN: Reference allele not detected -- seen with biallelic filtered VCFs\n")
        sys.stderr.write(f"\tSNP:{variant[2]},REF:{ref_allele},VCF_REF:{vcf_ref_allele},ALTS:{alt_alleles}\n")
        true_ref_index = len(alt_alleles) 
    all_alleles = set([ref_allele, vcf_ref_allele]).union(set(alt_alleles))
    # change elements 9 and on -- zero-based index
    genotypes = "\t".join(variant[9:])
    genotypes = genotypes.replace("0","r") # old reference
    genotypes = genotypes.replace(str(true_ref_index+1), "0")
    genotypes = genotypes.replace("r",str(true_ref_index+1))
    if true_ref_index < len(alt_alleles):
        variant_fixed = variant[:3] + \
                [ref_allele] + \
                [variant[4].replace(ref_allele, vcf_ref_allele)] + \
                variant[5:9] + \
                genotypes.split()
    else:
        variant_fixed = variant[:3] + \
                [ref_allele] + \
                [variant[4] + f",{vcf_ref_allele}"] + \
                variant[5:9] + \
                genotypes.split()
    return "\t".join(variant_fixed) + "\n"


def check_vcf(vcf_file, fasta):
    """Read through VCF and fix incorrect references for variants"""
    with open(vcf_file) as f:
        for line in f:
            if (not line.startswith("#")): # 1=COORD 3=REF 4=ALT
                split_line = line.split()
                ref_allele = fasta.seq[int(split_line[1])-1]
                if ref_allele != split_line[3]:
                    new_variant_line = fix_variant(split_line, ref_allele)
                    sys.stdout.write(new_variant_line)
                    new_variant_line_split = new_variant_line.split()
                    sys.stderr.write(f"{split_line[2]}" + 
                            f", REF: {ref_allele}" + 
                            f", VCF_REF: {split_line[3]}" + 
                            f", ALT: {split_line[4]}" +
                            f", NEW_REF: {new_variant_line_split[3]}" +
                            f", NEW_ALT: {new_variant_line_split[4]}\n")
                else:
                    sys.stdout.write(line)
            else:
                sys.stdout.write(line)

if __name__ == "__main__":
    args = parse_arguments()
    fasta = read_fasta(args.fasta)
    check_vcf(args.vcf, fasta)
