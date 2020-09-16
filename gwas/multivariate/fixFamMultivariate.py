import sys
from collections import OrderedDict

if len(sys.argv) != 3:
    print(f"python {sys.argv[0]} additional_phenotypes.txt plink.fam")
    sys.exit(1)

additional_phenotypes = OrderedDict()
with open(sys.argv[1]) as f:
    for line in f.read().splitlines():
        split_line = line.split()
        additional_phenotypes[split_line[0]] = split_line[1:]

with open(sys.argv[2]) as f:
    fam = f.read().splitlines()

for line in fam:
    split_line = line.split()
    try:
        print(" ".join([line] + additional_phenotypes[split_line[0]]))
    except KeyError:
        values = ["-9" for i in range(len(list(additional_phenotypes.values())[3]))]
        print(" ".join([line] + values))
