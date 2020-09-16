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
df["group"] = final_names
df.columns = ["sample.id",f"PC1 ({pc1}%)", f"PC2 ({pc2}%)"] + list(df.columns)[3:]
fig, ax = plt.subplots(figsize=(9,6))
sns.scatterplot(x=f"PC1 ({pc1}%)", y=f"PC2 ({pc2}%)", hue="group", data=df, linewidth=0, alpha=0.9, ax=ax)
sns.scatterplot(x=f"PC1 ({pc1}%)", y=f"PC2 ({pc2}%)", color=".2", data=df[df["group"] == "Grassl"], marker="x", s=1000, linewidth=0, alpha=0.9, ax=ax)
handles, labels = ax.get_legend_handles_labels()
ax.legend(handles=handles[1:], labels=labels[1:], bbox_to_anchor=(1.05, 1), loc=2, borderaxespad=0., ncol=2)
# plt.legend(bbox_to_anchor=(1.05, 1), loc=2, borderaxespad=0.)
plt.tight_layout()
plt.savefig("pca.png")
