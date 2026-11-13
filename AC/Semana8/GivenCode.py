def clipAlphasJ(aj,H,L):
      if aj > H:
            aj = H
      if L > aj:
            aj = L
      return aj

def selectJrandom(i,m):
      j=i
      while (j==i):
            j = int(np.random.uniform(0,m))
      return j

def simplifiedSMO(dataX, classY):
       C=1e10
       tol=1e-3
       max_passes=100;
       X = np.mat(dataX);
       Y = np.mat(classY).T
       m,n = np.shape(X)
       # Initialize b: threshold for solution
       b = 0;      
       # Initialize alphas: lagrange multipliers for solution
       alphas = np.mat(np.zeros((m,1)))
       passes = 0
       while (passes < max_passes):
              num_changed_alphas = 0
              for i in range(m):
                     # Calculate Ei = f(xi) - yi
                     fXi = float(np.multiply(alphas,Y).T*(X*X[i,:].T)) + b
                     Ei = fXi - float(Y[i])
                     if ((Y[i]*Ei < -tol) and (alphas[i] < C)) or ((Y[i]*Ei > tol) 
                                  and (alphas[i] > 0)):
                           # select j # i randomly
                           j = selectJrandom(i,m)
                           # Calculate Ej = f(xj) - yj
                           fXj = float(np.multiply(alphas,Y).T*(X*X[j,:].T)) + b
                           Ej = fXj - float(Y[j])
                           # save old alphas's
                           alphaIold = alphas[i].copy();
                           alphaJold = alphas[j].copy();
                           # compute L and H
                           if (Y[i] != Y[j]):
                                  L = max(0, alphas[j] - alphas[i])
                                  H = min(C, C + alphas[j] - alphas[i])
                           else:
                                  L = max(0, alphas[j] + alphas[i] - C)
                                  H = min(C, alphas[j] + alphas[i])
                           # if L = H the continue to next i
                           if L==H:
                                  continue
                           # compute eta
                           eta = 2.0 * X[i,:]*X[j,:].T - X[i,:]*X[i,:].T - X[j,:]*X[j,:].T
                           # if eta >= 0 then continue to next i
                           if eta >= 0:
                                  continue
                           # compute new value for alphas j
                           alphas[j] -= Y[j]*(Ei - Ej)/eta
                           # clip new value for alphas j
                           alphas[j] = clipAlphasJ(alphas[j],H,L)
                           # if |alphasj - alphasold| < 0.00001 then continue to next i
                           if (abs(alphas[j] - alphaJold) < 0.00001):
                                  continue
                           # determine value for alphas i
                           alphas[i] += Y[j]*Y[i]*(alphaJold - alphas[j])
                           # compute b1 and b2
                           b1 = b - Ei- Y[i]*(alphas[i]-alphaIold)*X[i,:]*X[i,:].T -Y[j]*(alphas[j]-alphaJold)*X[i,:]*X[j,:].T
                           b2 = b - Ej- Y[i]*(alphas[i]-alphaIold)*X[i,:]*X[j,:].T - Y[j]*(alphas[j]-alphaJold)*X[j,:]*X[j,:].T
                           # compute b
                           if (0 < alphas[i]) and (C > alphas[i]):
                                  b = b1
                           elif (0 < alphas[j]) and (C > alphas[j]):
                                  b = b2
                           else:
                                  b = (b1 + b2)/2.0                      
                           num_changed_alphas += 1
                     if (num_changed_alphas == 0): passes += 1
                     else: passes = 0
       return alphas