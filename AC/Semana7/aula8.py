# EX 1
import numpy as np
from collections import Counter
from scipy.spatial.distance import cdist


def knn_train(X_train, y_train, k, distance_metric="euclidean"):
    # O kNN não aprende parâmetros: treinar = guardar os dados e as definições
    model = {
        "X": np.asarray(X_train, dtype=float),
        "y": np.asarray(y_train),
        "k": k,
        "metric": distance_metric,  # nomes do SciPy: "euclidean", "cityblock", "chebyshev", ...
    }
    return model

def knn_test(model, X_test):
    X_test = np.asarray(X_test, dtype=float)

    # matriz de distancias (n_test x n_train)
    # dists[i, j] -> distancia entre a amostra de teste i e a de treino j
    dists = cdist(X_test, model["X"], metric=model["metric"])

    predictions = []
    for i in range(len(X_test)):
        # ordenar as distancias da amostra i e ficar com os indices dos k mais proximos
        mais_proximos = np.argsort(dists[i])[:model["k"]]

        # labels de treino desses k vizinhos
        labels_vizinhos = model["y"][mais_proximos]

        # label mais frequente entre os vizinhos (se houver empate fica a do mais proximo)
        pred = Counter(labels_vizinhos).most_common(1)[0][0]
        predictions.append(pred)

    return np.array(predictions)

# Teste rápido
X_train = [[1, 2], [2, 3], [8, 8], [9, 7]]
y_train = ["A", "A", "B", "B"]

model = knn_train(X_train, y_train, k=3, distance_metric="euclidean")
print(knn_test(model, [[1.5, 2.5], [8.5, 7.5]]))   # ['A' 'B']

#EX2
import pandas as pd
import numpy as np

# ler o ficheiro com os dados das rolhas
# (se for csv usar pd.read_csv em vez de read_excel)
df = pd.read_csv(
    r"C:/Users/josem/OneDrive/Ambiente de Trabalho/Zé Miguel/UNIVERSIDADE/5ANO/Rodrigo_Jose/AC/datasets/CORK_STOPPERS.csv",
    sep=";",
    decimal=",",
    skiprows=[1]
)

# so interessam as features ART e PRM
# .values passa de DataFrame para array numpy
X = df[["ART", "PRM"]].values

# coluna com a classe de cada rolha (1, 2 ou 3)
y = df["C"].values

# gerador de numeros aleatorios com seed fixa
# assim a divisao treino/teste e sempre a mesma quando corremos o codigo
rng = np.random.default_rng(42)

# listas onde vao ficar os indices das amostras de treino e de teste
idx_train = []
idx_test = []

# a divisao e feita classe a classe (hold-out estratificado)
# assim o treino e o teste ficam com o mesmo numero de amostras de cada classe
for c in np.unique(y):              # type: ignore # np.unique(y) -> classes que existem, ex: [1, 2, 3]
    idx_c = np.where(y == c)[0]     # indices das amostras que pertencem a classe c
    rng.shuffle(idx_c)              # baralhar para a escolha ser aleatoria
    metade = len(idx_c) // 2        # 50% das amostras da classe (// e divisao inteira)
    idx_train.extend(idx_c[:metade])  # primeira metade vai para treino
    idx_test.extend(idx_c[metade:])   # segunda metade vai para teste

# usar os indices para construir os dois conjuntos
X_train, y_train = X[idx_train], y[idx_train]
X_test, y_test = X[idx_test], y[idx_test]

# confirmar os tamanhos: 150 amostras -> 75 treino e 75 teste, com 2 features cada
print(X_train.shape, X_test.shape)  # (75, 2) (75, 2)

#   EX 2.2
# calcular a media e o desvio padrao de cada feature, usando so os dados de treino
# axis=0 -> calcula por coluna, ou seja, um valor para ART e outro para PRM
media = np.mean(X_train, axis=0)
desvio = np.std(X_train, axis=0)

# standardizar: subtrair a media e dividir pelo desvio padrao
# o treino fica com media 0 e variancia 1
X_train_std = (X_train - media) / desvio

# o teste usa os MESMOS fatores do treino (nao se calcula media/desvio do teste)
# por isso o teste nao fica exatamente com media 0 e variancia 1, e isso e normal
X_test_std = (X_test - media) / desvio

# confirmar: no treino deve dar ~[0, 0] e [1, 1]
print("media treino:", X_train_std.mean(axis=0))
print("desvio treino:", X_train_std.std(axis=0))
print("media teste:", X_test_std.mean(axis=0))
print("desvio teste:", X_test_std.std(axis=0))

# Ex2-3 Comparar com o scikit 

import matplotlib.pyplot as plt
from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import accuracy_score

# grelha para desenhar as fronteiras de decisao
xx, yy = np.meshgrid(np.linspace(-3, 3, 200), np.linspace(-3, 3, 200))
grelha = np.c_[xx.ravel(), yy.ravel()]

for k in [1, 7]:
    # --- sklearn ---
    # inicializar com o numero de vizinhos pretendido
    knn_sk = KNeighborsClassifier(n_neighbors=k)
    # treinar com os dados de treino e prever no teste
    knn_sk.fit(X_train_std, y_train)
    pred_sk = knn_sk.predict(X_test_std)
    # accuracy e erro (erro = 1 - accuracy)
    acc_sk = accuracy_score(y_test, pred_sk)
    erro_sk = 1 - acc_sk

    # --- nossa implementacao ---
    model = knn_train(X_train_std, y_train, k, "euclidean")
    pred = knn_test(model, X_test_std)
    acc = accuracy_score(y_test, pred)
    erro = 1 - acc

    # --- comparar as duas ---
    print(f"k={k}")
    print(f"  sklearn: accuracy = {acc_sk:.3f}, erro = {erro_sk:.3f}")
    print(f"  nossa:   accuracy = {acc:.3f}, erro = {erro:.3f}")
    print(f"  previsoes iguais: {np.array_equal(pred, pred_sk)}")

    # --- fronteiras de decisao ---
    Z = knn_test(model, grelha).reshape(xx.shape)
    plt.contourf(xx, yy, Z, alpha=0.3)
    plt.scatter(X_test_std[:, 0], X_test_std[:, 1], c=y_test, edgecolor="k")
    plt.title(f"k = {k}, erro de teste = {erro:.1%}")
    plt.xlabel("ART")
    plt.ylabel("PRM")
    plt.show()

# EX 2.4
import matplotlib.pyplot as plt

def dividir_e_standardizar(X, y, seed):
    # hold-out 50/50 por classe (igual ao de antes, mas com seed variavel)
    rng = np.random.default_rng(seed)
    idx_train, idx_test = [], []
    for c in np.unique(y):
        idx_c = np.where(y == c)[0]
        rng.shuffle(idx_c)
        metade = len(idx_c) // 2
        idx_train.extend(idx_c[:metade])
        idx_test.extend(idx_c[metade:])

    # standardizar com a media e o desvio do treino
    media = X[idx_train].mean(axis=0)
    desvio = X[idx_train].std(axis=0)
    X_tr = (X[idx_train] - media) / desvio
    X_te = (X[idx_test] - media) / desvio
    return X_tr, y[idx_train], X_te, y[idx_test]


valores_k = range(1, 31, 2)   # k impares de 1 a 29
n_rep = 20                    # numero de divisoes treino/teste diferentes

medias, desvios = [], []
for k in valores_k:
    erros = []
    for rep in range(n_rep):
        X_tr, y_tr, X_te, y_te = dividir_e_standardizar(X, y, seed=rep)
        model = knn_train(X_tr, y_tr, k, "euclidean")
        pred = knn_test(model, X_te)
        erros.append(np.mean(pred != y_te))
    # media e desvio do erro nas 20 repeticoes
    medias.append(np.mean(erros))
    desvios.append(np.std(erros))
    print(f"k={k}: erro medio = {np.mean(erros):.3f}, variancia = {np.var(erros):.5f}")

# melhor k = o que tem menor erro medio
melhor_k = list(valores_k)[np.argmin(medias)]
print("melhor k:", melhor_k)

# grafico do erro de teste em funcao de k (barras = desvio padrao)
plt.errorbar(valores_k, medias, yerr=desvios, marker="o", capsize=3)
plt.xlabel("k")
plt.ylabel("erro de teste")
plt.title("erro medio (+- desvio padrao) em 20 repeticoes")
plt.show()

# fronteiras de decisao para o melhor k (usando uma das divisoes)
X_tr, y_tr, X_te, y_te = dividir_e_standardizar(X, y, seed=0)
model = knn_train(X_tr, y_tr, melhor_k, "euclidean")
pred = knn_test(model, X_te)

xx, yy = np.meshgrid(np.linspace(-3, 3, 200), np.linspace(-3, 3, 200))
Z = knn_test(model, np.c_[xx.ravel(), yy.ravel()]).reshape(xx.shape)
plt.contourf(xx, yy, Z, alpha=0.3)
plt.scatter(X_te[:, 0], X_te[:, 1], c=y_te, edgecolor="k")
plt.title(f"melhor k = {melhor_k}, erro = {np.mean(pred != y_te):.1%}")
plt.xlabel("ART")
plt.ylabel("PRM")
plt.show()