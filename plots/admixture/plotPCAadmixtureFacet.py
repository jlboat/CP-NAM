import sys
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

df = pd.read_csv(sys.argv[1], sep="\t")
pc1 = sys.argv[2]
pc2 = sys.argv[3]

df["group"] = df["sample.id"].apply(lambda x: "_".join(x.split("_")[0:2]) if "PI" in x else x.split("_")[0])
# Convert PI to common name -- common,PI
pi_to_common = {}
with open("PiToCommon.txt") as f:
    for line in f.read().splitlines():
        split_line = line.split(",")
        pi_to_common[split_line[1]] = split_line[0]
# Convert Pop numbers to PI -- pop,PI
pop_to_pi = {}
with open("PopToPi.txt") as f:
    for line in f.read().splitlines():
        split_line = line.split(",")
        pop_to_pi[split_line[0]] = split_line[1]
new_names = []
for i in list(df.group):
    try:
        new_names.append(pi_to_common[i])
    except KeyError:
        new_names.append(i)
print(set(new_names))
final_names = []
for i in new_names:
    try:
        final_names.append(pop_to_pi[i])
    except KeyError:
        final_names.append(i)
print(set(final_names))
admixture = pd.read_csv("admix.named.sorted.txt", sep=" ", header=None)
print(admixture.head())
group = ["Q"+str(i) for i in admixture.iloc[:,16]]
print(set(group))
df["group"] = group
df.columns = ["sample.id",f"PC1 ({pc1}%)", f"PC2 ({pc2}%)"] + list(df.columns)[3:]
df["family"] = final_names
df = df[df.family.str.contains("PI")]
g = sns.FacetGrid(df, col="family", col_wrap=4)
g.map_dataframe(sns.scatterplot, x=f"PC1 ({pc1}%)", y=f"PC2 ({pc2}%)", hue="group", data=df, linewidth=0, alpha=0.6, palette={"Q1":"#F0A0FF", "Q2":"#0075DC", "Q3":"#993F00", 
    "Q4":"#4C005C", "Q5":"#191919", "Q6":"#005C31", "Q7":"#2BCE48", "Q8":"#FFCC99", 
    "Q9":"#808080", "Q10":"#94FFB5", "Q11":"#8F7C00", "Q12":"#9DCC00", "Q13":"#C20088", 
    "Q14":"#003380", "Q15":"#FFA405"}, size=10)
#sns.scatterplot(x=f"PC1 ({pc1}%)", y=f"PC2 ({pc2}%)", hue="group", data=df, linewidth=0, alpha=0.6, ax=ax)
# sns.scatterplot(x=f"PC1 ({pc1}%)", y=f"PC2 ({pc2}%)", data=df[~df["group"].str.contains("PI")], alpha=0.9, marker="x", s=20, color=".2", ax=ax)
# sns.scatterplot(x=f"PC1 ({pc1}%)", y=f"PC2 ({pc2}%)", data=df[df["group"].str.contains("Grassl")], marker="x", s=40, color=".2", ax=ax)
# plt.legend(bbox_to_anchor=(1.05, 1), loc=2, borderaxespad=0.)
#handles, labels = ax.get_legend_handles_labels()
#ax.legend(handles=handles[1:], labels=labels[1:], bbox_to_anchor=(1.05, 1), loc=2, borderaxespad=0., ncol=2)
plt.tight_layout()
plt.savefig("pca.facet.png", dpi=600)
