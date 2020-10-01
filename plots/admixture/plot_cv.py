import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

df = pd.read_csv("cv_error.txt")
plt.figure()
sns.scatterplot(x="K",y="CV Error",data=df)
plt.savefig("cv_error.png")
