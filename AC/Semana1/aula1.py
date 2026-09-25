#import numpy
#import pandas
#import sklearn
#import scipy
#import matplotlib
#import plotly

#print("Tudo instalado!")

from matplotlib import legend, pyplot as plt
import pandas as pd

# df = pd.read_csv(
#     r"datasets\CORK_STOPPERS.csv",
#     sep=";",
#     decimal=","
# )

#################################

#Exercício 1.1.2
# plt.scatter(df[df["C"] == 1]["N"], df[df["C"] == 1]["ARM"], label="Classe 1") #vai buscar todas as da classe 1
# plt.scatter(df[df["C"] == 2]["N"], df[df["C"] == 2]["ARM"], label="Classe 2") #vai buscar todas as da classe 2
# plt.scatter(df[df["C"] == 3]["N"], df[df["C"] == 3]["ARM"], label="Classe 3") #vai buscar todas as da classe 3

# plt.xlabel("N")
# plt.ylabel("ARM")
# plt.legend()
# plt.show()

#Exercício 1.1.3

# fig = plt.figure()
# ax = fig.add_subplot(111, projection="3d")

# ax.scatter(df[df["C"] == 1]["N"],
#            df[df["C"] == 1]["ARM"],
#            df[df["C"] == 1]["PRM"],
#            label="Classe 1")

# ax.scatter(df[df["C"] == 2]["N"],
#            df[df["C"] == 2]["ARM"],
#            df[df["C"] == 2]["PRM"],
#            label="Classe 2")

# ax.scatter(df[df["C"] == 3]["N"],
#            df[df["C"] == 3]["ARM"],
#            df[df["C"] == 3]["PRM"],
#            label="Classe 3")

# ax.set_xlabel("N")
# ax.set_ylabel("ARM")
# ax.set_zlabel("PRM")

# plt.legend()
# plt.show()

#Exercício 1.2.1

df = pd.read_csv(r"datasets\iris.csv")
#print(df)

#Exercício 1.2.2
# for c in df["species"].unique():
#     d=df[df["species"]==c]
#     plt.scatter(d.index,d ["sepal_length"],label=c)

# plt.xlabel("Planta")
# plt.ylabel("Sepal length")
# plt.legend()
# plt.show()

#Exercício 1.2.3
# for c in df["species"].unique():

#     d = df[df["species"] == c]

#     plt.scatter(d["petal_length"], d["sepal_length"], label=c)

# plt.xlabel("Petal length")
# plt.ylabel("Sepal length")

# plt.legend()
# plt.show()

#Exercicio 1.2.4

fig = plt.figure()

ax = fig.add_subplot(111, projection="3d")

ax.scatter(df[df["species"] == "setosa"]["petal_length"],
           df[df["species"] == "setosa"]["sepal_width"],
           df[df["species"] == "setosa"]["petal_width"],
           label="Setosa")

ax.scatter(df[df["species"] == "versicolor"]["petal_length"],
           df[df["species"] == "versicolor"]["sepal_width"],
           df[df["species"] == "versicolor"]["petal_width"],
           label="Versicolor")

ax.scatter(df[df["species"] == "virginica"]["petal_length"],
           df[df["species"] == "virginica"]["sepal_width"],
           df[df["species"] == "virginica"]["petal_width"],
           label="Virginica")

ax.set_xlabel("Petal length")
ax.set_ylabel("Sepal width")
ax.set_zlabel("Petal width")

plt.legend()
plt.show()