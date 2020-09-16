import sys
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# Many plots
# sample = sys.argv[1] + ".phenotypes.txt"
# df = pd.read_csv(sample, sep="\t", header=None, names=["IID","FID","pericarp"])
# # print(df.head())
# 
# plt.figure()
# sns.countplot(x="pericarp", data=df)
# plt.savefig(sys.argv[1] + ".hist.png")

# One plot
population_dict = {"Chinese_Amber":"PI_22913","Leoti":"PI_586454","PI_229841":"PI_229841","PI_297130":"PI_297130","PI_297155":"PI_297155","PI_329311":"PI_329311","PI_506069":"PI_506069","PI_508366":"PI_508366","PI_510757":"PI_510757","PI_655972":"PI_655972","Rio":"PI_563295"}
ordered_populations = [population_dict[i] for i in ["Chinese_Amber","Leoti","PI_229841","PI_297130","PI_297155","PI_329311","PI_506069","PI_508366","PI_510757","PI_655972","Rio"]]
full_df = pd.read_csv("Chinese_Amber.phenotypes.txt", sep="\t", header=None, names=["IID","FID","pericarp"])

full_df["Population"] = [population_dict["Chinese_Amber"] for i in range(full_df.shape[0])]
for i in ["Leoti","PI_229841","PI_297130","PI_297155","PI_329311","PI_506069","PI_508366","PI_510757","PI_655972","Rio"]:
    temp_df = pd.read_csv(i + ".phenotypes.txt", sep="\t", header=None, names=["IID","FID","pericarp"])
    temp_df["Population"] = [population_dict[i] for j in range(temp_df.shape[0])]
    full_df = pd.concat([full_df, temp_df])
pericarp = {1:"Brown", 2:"Red", 3:"White", 4:"Yellow"}
full_df["Pericarp"] = [pericarp[i] for i in full_df.pericarp]
g = sns.FacetGrid(full_df, col="Population", row_order=ordered_populations, col_wrap=4)
g.map(sns.countplot, "Pericarp", order=["Brown","Red","White","Yellow"])
g.set_axis_labels("")
plt.savefig("Pericarp_distributions.png")
