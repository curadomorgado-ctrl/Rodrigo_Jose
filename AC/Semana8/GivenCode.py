import numpy as np


def clipAlphasJ(aj, H, L):
    if aj > H:
        aj = H
    if L > aj:
        aj = L
    return aj


def selectJrandom(i, m):
    j = i
    while j == i:
        j = int(np.random.uniform(0, m))
    return j


def simplifiedSMO(dataX, classY):
    C = 1e10
    tol = 1e-3
    max_passes = 100
    X = np.asmatrix(dataX, dtype=float)  # type: ignore
    Y = np.asmatrix(classY, dtype=float).T  # type: ignore
    m, n = np.shape(X)
    # Initialize b: threshold for solution
    b = 0.0
    # Initialize alphas: lagrange multipliers for solution
    alphas = np.asmatrix(np.zeros((m, 1)))  # type: ignore
    passes = 0
    while passes < max_passes:
        num_changed_alphas = 0
        for i in range(m):
            # Calculate Ei = f(xi) - yi
            fXi = (np.multiply(alphas, Y).T * (X * X[i, :].T)).item() + b
            Ei = fXi - Y[i].item()
            if ((Y[i] * Ei < -tol) and (alphas[i] < C)) or (
                (Y[i] * Ei > tol) and (alphas[i] > 0)
            ):
                # select j # i randomly
                j = selectJrandom(i, m)
                # Calculate Ej = f(xj) - yj
                fXj = (np.multiply(alphas, Y).T * (X * X[j, :].T)).item() + b
                Ej = fXj - Y[j].item()
                # save old alphas's
                alphaIold = alphas[i].copy()
                alphaJold = alphas[j].copy()
                # compute L and H
                if Y[i] != Y[j]:
                    L = max(0, alphas[j] - alphas[i])
                    H = min(C, C + alphas[j] - alphas[i])
                else:
                    L = max(0, alphas[j] + alphas[i] - C)
                    H = min(C, alphas[j] + alphas[i])
                # if L = H the continue to next i
                if L == H:
                    continue
                # compute eta
                eta = (
                    2.0 * X[i, :] * X[j, :].T
                    - X[i, :] * X[i, :].T
                    - X[j, :] * X[j, :].T
                )
                # if eta >= 0 then continue to next i
                if eta >= 0:
                    continue
                # compute new value for alphas j
                alphas[j] -= Y[j] * (Ei - Ej) / eta
                # clip new value for alphas j
                alphas[j] = clipAlphasJ(alphas[j], H, L)
                # if |alphasj - alphasold| < 0.00001 then continue to next i
                if abs(alphas[j] - alphaJold) < 0.00001:
                    continue
                # determine value for alphas i
                alphas[i] += Y[j] * Y[i] * (alphaJold - alphas[j])
                # compute b1 and b2
                b1 = (
                    b
                    - Ei
                    - Y[i] * (alphas[i] - alphaIold) * X[i, :] * X[i, :].T
                    - Y[j] * (alphas[j] - alphaJold) * X[i, :] * X[j, :].T
                )
                b2 = (
                    b
                    - Ej
                    - Y[i] * (alphas[i] - alphaIold) * X[i, :] * X[j, :].T
                    - Y[j] * (alphas[j] - alphaJold) * X[j, :] * X[j, :].T
                )
                # compute b
                if (0 < alphas[i]) and (C > alphas[i]):
                    b = b1.item()
                elif (0 < alphas[j]) and (C > alphas[j]):
                    b = b2.item()
                else:
                    b = ((b1 + b2) / 2.0).item()
                num_changed_alphas += 1
        # (fora do "for i")
        if num_changed_alphas == 0:
            passes += 1
        else:
            passes = 0
    return alphas, b


import matplotlib.pyplot as plt

np.random.seed(0)

# Dados da folha prática
X = np.array(
    [
        [-2, -1],
        [-1, -1],
        [0, 0],
        [1, 0],  # classe +1
        [2, 0],
        [0, 2],
        [3, 2],
        [4, 4],
    ],  # classe -1
    dtype=float,
)
y = np.array([1, 1, 1, 1, -1, -1, -1, -1], dtype=float)

alphas, b = simplifiedSMO(X, y)
a = np.asarray(alphas).ravel()
# calcular o w
w = (a * y) @ X
print("alphas =", np.round(a, 4))
print("w =", np.round(w, 4))
print("b =", round(b, 4))

margem = 2 / np.linalg.norm(w)
print("Largura da margem = 2/||w|| =", round(margem, 4))
# identificar os support vectors
sv = a > 1e-5
print("Vetores de suporte classe +1:", X[sv & (y == 1)].tolist())
print("Vetores de suporte classe -1:", X[sv & (y == -1)].tolist())
##testar novos dados
for x_new in ([0.5, 0.5], [1.0, 1.0]):
    f = w @ np.array(x_new) + b
    print(f"x = {x_new}: f(x) = {f:.4f} -> classe {int(np.sign(round(f, 3))):+d}")

# plottar

fig, ax = plt.subplots(figsize=(9, 6))
x1 = np.linspace(-3, 5, 200)
# w1*x1 + w2*x2 + b = c   ->   x2 = (c - b - w1*x1) / w2
for c, estilo, nome in [
    (0, "-", "Hiperplano (f(x)=0)"),
    (1, "--", "Margem (f(x)=+1)"),
    (-1, ":", "Margem (f(x)=-1)"),
]:
    ax.plot(x1, (c - b - w[0] * x1) / w[1], estilo, color="#444444", lw=2, label=nome)

ax.scatter(*X[y == 1].T, s=70, color="#2a78d6", label="Classe +1", zorder=3)
ax.scatter(
    *X[y == -1].T, s=70, color="#eb6834", marker="s", label="Classe -1", zorder=3
)
ax.scatter(
    *X[sv].T,
    s=260,
    facecolors="none",
    edgecolors="black",
    lw=1.5,
    label="Vetores de suporte",
    zorder=4,
)
ax.scatter(
    [0.5, 1.0],
    [0.5, 1.0],
    s=90,
    marker="x",
    color="#7a3fbf",
    lw=2,
    label="Amostras novas",
    zorder=4,
)
ax.set_xlim(-3, 5)
ax.set_ylim(-2, 5)
ax.set_xlabel("x1")
ax.set_ylabel("x2")
ax.set_title(f"SVM hard-margin  |  w = ({w[0]:.2f}, {w[1]:.2f}), b = {b:.2f}")
ax.grid(alpha=0.25)
ax.set_aspect("equal")
ax.legend(loc="upper left", bbox_to_anchor=(1.02, 1), fontsize=9)
plt.tight_layout()
plt.savefig("svm_semana8.png", dpi=150)
plt.show()
