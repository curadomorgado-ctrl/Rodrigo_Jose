from PIL import Image
import os
from itertools import combinations
import numpy as np
import matplotlib.pyplot as plt

pastas = [
    r"datasets/FRUITS/APPLES",
    r"datasets/FRUITS/PEACHES",
    r"datasets/FRUITS/ORANGES",
]

# As 2 features: uma de COR e uma de FORMA
nomes_features = ["hue", "proporcao"]

# dados["APPLES"]["hue"] = lista com o hue de cada maçã
dados = {}

for pasta in pastas:
    fruta = os.path.basename(pasta)                 # APPLES, PEACHES, ORANGES
    dados[fruta] = {f: [] for f in nomes_features}

    for nome in sorted(os.listdir(pasta)):
        if nome.lower().endswith(".jpg"):
            img = Image.open(os.path.join(pasta, nome)).convert("RGB")
            pixeis = np.array(img).astype(int)

            # 1. fundo = cor do pixel do canto; fruta = pixels muito diferentes do fundo
            fundo = pixeis[0, 0]
            diferenca = np.abs(pixeis - fundo).sum(axis=2)
            fruta_mask = diferenca > 100            # True = fruta, False = fundo

            # 2. COR -> hue (o "tom" da cor, em graus: 0=vermelho, 30=laranja, 60=amarelo, 120=verde)
            h = np.array(img.convert("HSV"))[:, :, 0][fruta_mask].astype(float)
            angulo = h * 2 * np.pi / 255
            # média circular (o vermelho está no "fim" e no "início" da escala 0-360)
            hue = np.degrees(np.arctan2(np.sin(angulo).mean(), np.cos(angulo).mean())) % 360
            if hue > 300:
                hue = hue - 360                     # vermelhos ficam à volta de 0 (ex.: -5, 8)

            # 3. FORMA -> proporção = largura / altura (~1 redondo, >1 alongado)
            linhas, colunas = np.nonzero(fruta_mask)
            largura = colunas.max() - colunas.min() + 1
            altura = linhas.max() - linhas.min() + 1
            proporcao = largura / altura

            dados[fruta]["hue"].append(hue)
            dados[fruta]["proporcao"].append(proporcao)

# ---------------- Gráficos ----------------
fig, eixos = plt.subplots(1, 3, figsize=(15, 4))

# boxplots: uma caixa por fruta (a caixa é o IQR)
for eixo, f in zip(eixos[:2], nomes_features):
    eixo.boxplot([dados[fruta][f] for fruta in dados])
    eixo.set_xticklabels(list(dados))
    eixo.set_title(f)

# gráfico das 2 features juntas: cada ponto é uma imagem
for fruta in dados:
    eixos[2].scatter(dados[fruta]["hue"], dados[fruta]["proporcao"], label=fruta)
eixos[2].set_xlabel("hue")
eixos[2].set_ylabel("proporcao")
eixos[2].set_title("hue vs proporcao")
eixos[2].legend()

plt.tight_layout()
plt.savefig("features_boxplot.png")
plt.show()

# ---------------- Mediana e IQR ----------------
for f in nomes_features:
    print(f)
    for fruta in dados:
        q1, mediana, q3 = np.percentile(dados[fruta][f], [25, 50, 75])
        print(f"  {fruta:8} mediana={mediana:7.2f}  IQR={q3 - q1:6.2f}  (Q1={q1:.2f}, Q3={q3:.2f})")

# ---------------- Qual é a MELHOR feature? ----------------
# Para cada par de frutas: distância entre as medianas / soma dos IQRs.
# Quanto maior o número, mais afastadas (e menos sobrepostas) estão as caixas.
pontuacao = {}
pares = {}
for f in nomes_features:
    pares[f] = {}
    for a, b in combinations(dados, 2):
        qa = np.percentile(dados[a][f], [25, 50, 75])
        qb = np.percentile(dados[b][f], [25, 50, 75])
        iqr_a = qa[2] - qa[0]
        iqr_b = qb[2] - qb[0]
        distancia = abs(qa[1] - qb[1])
        pares[f][(a, b)] = distancia / (iqr_a + iqr_b + 1e-9)
    pontuacao[f] = np.mean(list(pares[f].values()))      # média de todos os pares

print("\nRANKING (maior = discrimina melhor)")
for f in sorted(pontuacao, key=pontuacao.get, reverse=True):
    print(f"  {f:10} {pontuacao[f]:.2f}")

melhor = max(pontuacao, key=pontuacao.get)
print("\nMELHOR FEATURE:", melhor)

par_dificil = min(pares[melhor], key=pares[melhor].get)
print("Par mais difícil de separar com ela:", par_dificil[0], "vs", par_dificil[1])

# ---------------- Dimensionalidade e nº de exemplos ----------------
print("\nDimensionalidade (nº de features):", len(nomes_features))

total = 0
for fruta in dados:
    n = len(dados[fruta]["hue"])                # nº de imagens desta fruta
    print(" ", fruta, ":", n, "exemplos")
    total += n
print("Nº total de exemplos:", total)