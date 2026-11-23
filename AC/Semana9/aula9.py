# fazer grid_seach para C com np.arrange(-20,20,2)
# simplifiedSMO
from anyio import run
import numpy as np
import pandas as pd
import plotly.graph_objects as go
from sklearn.svm import SVC
from sklearn.model_selection import train_test_split
from sklearn.metrics import roc_curve, auc
import plotly.graph_objects as go
import numpy as np
import pandas as pd
import os
from sklearn.svm import SVC

# Ler o ficheiro CSV: separador ';', decimal ',' e saltar a linha vazia (linha 2)
df = pd.read_csv(
    r"C:/Users/josem/OneDrive/Ambiente de Trabalho/Zé Miguel/UNIVERSIDADE/5ANO/Rodrigo_Jose/AC/datasets/CORK_STOPPERS.csv",
    sep=";",
    decimal=",",
    skiprows=[1],
)

# Selecionar as colunas pretendidas e remover linhas com valores em falta
CorkStopp = (
    df[["C", "ART", "N.1", "PRT", "ARM", "PRM", "ARTG", "NG", "PRTG", "RAAR", "RAN"]]
    .dropna()
    .copy()
)

# Nomes das features, excluindo a primeira coluna, que contém a classe
fnames = CorkStopp.columns[1:]

# Obter os índices das amostras de cada classe
ixSuper = np.where(CorkStopp["C"] == 1)[0]
ixAverage = np.where(CorkStopp["C"] == 2)[0]

# Extract the 'N.1' and 'PRT' features for the "Super" and "Average" classes
# using the indices obtained from the previous step

# Extract the 'N.1' feature for the "Super" class
NSup = CorkStopp["N.1"].to_numpy()[ixSuper]

# Extract the 'N.1' feature for the "Average" class
NAvg = CorkStopp["N.1"].to_numpy()[ixAverage]

# Extract the 'PRT' feature, divide it by 10, and select the "Super" class
PRT10Sup = (CorkStopp["PRT"].to_numpy() / 10)[ixSuper]

# Extract the 'PRT' feature, divide it by 10, and select the "Average" class
PRT10Avg = (CorkStopp["PRT"].to_numpy() / 10)[ixAverage]

X = np.vstack((np.column_stack((NSup, PRT10Sup)), np.column_stack((NAvg, PRT10Avg))))
Y = np.concatenate(
    (np.ones(len(NSup)), -np.ones(len(NAvg)))
)  # Super = +1, Average = -1


C_values = 2.0 ** np.arange(-20, 20, 2)
errors = np.zeros((10, len(C_values)))

# # for i in range(10):
# #   # fazer a divisao 50/50
# #  X_train, X_test, Y_train, Y_test = train_test_split(
# #     X, Y, train_size=0.5, stratify=Y, random_state=i
# # )
# # fazer o grid search em C
# # for j, C in enumerate(C_values):
# #   svm = SVC(kernel="linear", C=C)  # SVM linear
# #  svm.fit(X_train, Y_train)  # treinar
# # errors[i, j] = 1 - svm.score(X_test, Y_test)  # erro de teste

# # melhor C = menor erro médio nas 10 corridas
# # best_C = C_values[np.argmin(errors.mean(axis=0))]
# # print(best_C)


# ## Matriz para C e gamma
# C_values_2 = 2.0 ** np.arange(-10, 26, 1)  # 2^-10 ... 2^25
# gamma_values = 2.0 ** np.arange(-25, 1, 1)  # 2^-25 ... 2^0
# errors_2 = np.zeros((10, len(C_values_2), len(gamma_values)))  # corrida x C x gamma

# for i in range(10):
#     # fazer a divisao 50/50
#     X_train, X_test, Y_train, Y_test = train_test_split(
#         X, Y, train_size=0.5, stratify=Y, random_state=i
#     )
#     # fazer o grid search em C e gamma
#     for j, C in enumerate(C_values_2):
#         for z, gamma in enumerate(gamma_values):
#             svm = SVC(kernel="rbf", C=C, gamma=gamma)  # SVM rbf
#             svm.fit(X_train, Y_train)  # treinar
#             errors_2[i, j, z] = 1 - svm.score(X_test, Y_test)  # erro de teste

# # melhor C e gamma = menor erro médio nas 10 corridas
# mean_err_2 = errors_2.mean(axis=0)
# j_best, z_best = np.unravel_index(np.argmin(mean_err_2), mean_err_2.shape)
# best_C = C_values_2[j_best]
# best_gamma = gamma_values[z_best]
# print(
#     f"Melhor C = 2^{np.log2(best_C):.0f}, melhor gamma = 2^{np.log2(best_gamma):.0f}, "
#     f"erro médio = {mean_err_2[j_best, z_best]:.4f}"
# )

# # ---------- mapa do erro médio ----------
# fig = go.Figure(
#     go.Heatmap(
#         z=mean_err_2,
#         x=np.log2(gamma_values),  # colunas = gamma
#         y=np.log2(C_values_2),  # linhas = C
#         colorbar=dict(title="Erro"),
#     )
# )
# fig.update_layout(
#     title="Erro médio de teste (10 corridas)",
#     xaxis_title="log2(gamma)",
#     yaxis_title="log2(C)",
# )
# fig.show()


# i_best = np.argmin(errors_2[:, j_best, z_best])
# X_train, X_test, Y_train, Y_test = train_test_split(
#     X, Y, train_size=0.5, stratify=Y, random_state=i_best
# )
# svm = SVC(kernel="rbf", C=best_C, gamma=best_gamma).fit(X_train, Y_train)
# print(f"Erro de teste da melhor SVM = {1 - svm.score(X_test, Y_test):.4f}")

# scores = svm.decision_function(X_test)  # distância à fronteira
# fpr, tpr, _ = roc_curve(Y_test, scores, pos_label=1)
# fig = go.Figure()
# fig.add_trace(go.Scatter(x=fpr, y=tpr, mode="lines", name=f"AUC = {auc(fpr, tpr):.3f}"))
# fig.add_trace(
#     go.Scatter(
#         x=[0, 1], y=[0, 1], mode="lines", line=dict(dash="dash"), name="Aleatório"
#     )
# )
# fig.update_layout(
#     title="Curva ROC - melhor SVM rbf",
#     xaxis_title="Falsos positivos (FPR)",
#     yaxis_title="Verdadeiros positivos (TPR)",
# )
# fig.show()

# xx = np.linspace(X[:, 0].min() - 5, X[:, 0].max() + 5, 300)
# yy = np.linspace(X[:, 1].min() - 5, X[:, 1].max() + 5, 300)
# XX, YY = np.meshgrid(xx, yy)
# Z = svm.decision_function(np.c_[XX.ravel(), YY.ravel()]).reshape(XX.shape)

# fig = go.Figure()
# # fronteira (Z = 0) e margens (Z = ±1)
# fig.add_trace(
#     go.Contour(
#         x=xx,
#         y=yy,
#         z=Z,
#         showscale=False,
#         contours=dict(start=-1, end=1, size=1, coloring="lines"),
#         line=dict(width=2),
#         name="Fronteira / margens",
#     )
# )
# # pontos de cada classe
# fig.add_trace(go.Scatter(x=X[Y == 1, 0], y=X[Y == 1, 1], mode="markers", name="Super"))
# fig.add_trace(
#     go.Scatter(x=X[Y == -1, 0], y=X[Y == -1, 1], mode="markers", name="Average")
# )
# # vetores de suporte
# fig.add_trace(
#     go.Scatter(
#         x=svm.support_vectors_[:, 0],
#         y=svm.support_vectors_[:, 1],
#         mode="markers",
#         name="Vetores de suporte",
#         marker=dict(size=12, symbol="circle-open", color="black"),
#     )
# )
# fig.update_layout(
#     title=f"Fronteira de decisão - rbf (C = 2^{np.log2(best_C):.0f}, "
#     f"gamma = 2^{np.log2(best_gamma):.0f})",
#     xaxis_title="N",
#     yaxis_title="PRT/10",
# )
# fig.show()


# # ---------- dados com as 3 classes ----------
# X3 = np.column_stack(
#     (CorkStopp["N.1"].to_numpy(), CorkStopp["PRT"].to_numpy() / 10)
# )  # features N e PRT/10
# Y3 = CorkStopp["C"].to_numpy()  # classes 1, 2, 3

# ## Matriz para C e gamma (mesmos valores)
# errors_3 = np.zeros((10, len(C_values_2), len(gamma_values)))  # corrida x C x gamma

# for i in range(10):
#     # fazer a divisao 50/50 (stratify garante 50% de cada uma das 3 classes)
#     X_train, X_test, Y_train, Y_test = train_test_split(
#         X3, Y3, train_size=0.5, stratify=Y3, random_state=i
#     )
#     # fazer o grid search em C e gamma
#     for j, C in enumerate(C_values_2):
#         for z, gamma in enumerate(gamma_values):
#             svm = SVC(
#                 kernel="rbf", C=C, gamma=gamma, decision_function_shape="ovo"
#             )  # OAO
#             svm.fit(X_train, Y_train)  # treinar
#             errors_3[i, j, z] = 1 - svm.score(X_test, Y_test)  # erro de teste

# # melhor C e gamma = menor erro médio nas 10 corridas
# mean_err_3 = errors_3.mean(axis=0)
# j_best3, z_best3 = np.unravel_index(np.argmin(mean_err_3), mean_err_3.shape)
# best_C3 = C_values_2[j_best3]
# best_gamma3 = gamma_values[z_best3]

# # erro de previsão
# print(
#     f"Melhor C = 2^{np.log2(best_C3):.0f}, melhor gamma = 2^{np.log2(best_gamma3):.0f}"
# )
# print(
#     f"Erro médio de teste = {mean_err_3[j_best3, z_best3]:.4f} "
#     f"± {errors_3[:, j_best3, z_best3].std():.4f}"
# )

# # mapa do erro médio (igual ao anterior)
# fig = go.Figure(
#     go.Heatmap(
#         z=mean_err_3,
#         x=np.log2(gamma_values),
#         y=np.log2(C_values_2),
#         colorbar=dict(title="Erro"),
#     )
# )
# fig.update_layout(
#     title="Erro médio de teste - 3 classes (OAO)",
#     xaxis_title="log2(gamma)",
#     yaxis_title="log2(C)",
# )
# fig.show()

C_values_2 = 2.0 ** np.arange(-10, 26, 1)  # 2^-10 ... 2^25
gamma_values = 2.0 ** np.arange(-25, 1, 1)  # 2^-25 ... 2^0


X3 = np.column_stack(
    (CorkStopp["N.1"].to_numpy(), CorkStopp["PRT"].to_numpy() / 10)
)  # features N e PRT/10
Y3 = CorkStopp["C"].to_numpy()  # classes 1, 2, 3

## Matriz para C e gamma (mesmos valores)
errors_3 = np.zeros((10, len(C_values_2), len(gamma_values)))  # corrida x C x gamma

for i in range(10):
    # fazer a divisao 50/50 (stratify garante 50% de cada uma das 3 classes)
    X_train, X_test, Y_train, Y_test = train_test_split(
        X3, Y3, train_size=0.5, stratify=Y3, random_state=i
    )
    # fazer o grid search em C e gamma
    for j, C in enumerate(C_values_2):
        for z, gamma in enumerate(gamma_values):
            svm = SVC(
                kernel="rbf", C=C, gamma=gamma, decision_function_shape="ovo"
            )  # OAO
            svm.fit(X_train, Y_train)  # treinar
            errors_3[i, j, z] = 1 - svm.score(X_test, Y_test)  # erro de teste

# melhor C e gamma = menor erro médio nas 10 corridas
mean_err_3 = errors_3.mean(axis=0)
j_best3, z_best3 = np.unravel_index(np.argmin(mean_err_3), mean_err_3.shape)
best_C3 = C_values_2[j_best3]
best_gamma3 = gamma_values[z_best3]

# erro de previsão
print(
    f"Melhor C = 2^{np.log2(best_C3):.0f}, melhor gamma = 2^{np.log2(best_gamma3):.0f}"
)
print(
    f"Erro médio de teste = {mean_err_3[j_best3, z_best3]:.4f} "
    f"± {errors_3[:, j_best3, z_best3].std():.4f}"
)

# mapa do erro médio (igual ao anterior)
fig = go.Figure(
    go.Heatmap(
        z=mean_err_3,
        x=np.log2(gamma_values),
        y=np.log2(C_values_2),
        colorbar=dict(title="Erro"),
    )
)
fig.update_layout(
    title="Erro médio de teste - 3 classes (OAO)",
    xaxis_title="log2(gamma)",
    yaxis_title="log2(C)",
)
fig.show()
