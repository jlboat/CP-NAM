import sys
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

df = pd.read_csv(sys.argv[1], sep=" ")
df["Digest Lengths"] = df["segment_length"].apply(lambda x: np.log2(x))
# df[df["segment_length"] < 100000]
plt.figure()
sns.boxplot(x="Chr", y="Digest Lengths", data=df)
plt.savefig("digest_segment_distributions.png")
