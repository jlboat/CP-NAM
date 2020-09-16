import sys
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

df = pd.read_csv(sys.argv[1], sep="\t")

df["group"] = df["sample.id"].apply(lambda x: "_".join(x.split("_")[0:2]) if "PI" in x else x.split("_")[0])
df.columns = ["sample.id","PC1 (7.50%)", "PC2 (4.68%)"] + list(df.columns)[3:]
fig, ax = plt.subplots(figsize=(9,6))
sns.scatterplot(x="PC1 (7.50%)", y="PC2 (4.68%)", hue="group", data=df, linewidth=0, alpha=0.9, ax=ax)
sns.scatterplot(x="PC1 (7.50%)", y="PC2 (4.68%)", color=".2", data=df[df["group"] == "Grassl"], marker="x", s=1000, linewidth=0, alpha=0.9, ax=ax)
handles, labels = ax.get_legend_handles_labels()
ax.legend(handles=handles[1:], labels=labels[1:], bbox_to_anchor=(1.05, 1), loc=2, borderaxespad=0., ncol=2)
# plt.legend(bbox_to_anchor=(1.05, 1), loc=2, borderaxespad=0.)
plt.tight_layout()
plt.savefig("pca.png")
