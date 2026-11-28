%% Ex 3 - Test of the numeric functions M(q), C(q,dq) and g(q)
clear all; clc; close all

% Robot parameters
m1 = 0.3;  m2 = 0.1;
l1 = 0.3;  l2 = 0.2;
lc1 = l1/2;  lc2 = l2/2;
I1cxx = 0; I1cyy = 0; I1czz = m1*l1^2/12;
I2cxx = 0; I2cyy = 0; I2czz = m2*l2^2/12;
Fv = 0.04; g0 = 9.8;

% Test configuration
q  = [pi/6; -pi/4];
dq = [0.8; -1.2];

%% Values of M, C and g
M = Gr2_Ex3_MassMatrix(q, m1, m2, l1, lc1, lc2, I1czz, I2czz);
disp('Inertia Matrix:');
disp(M);

G = Gr2_Ex3_GravityVector(q, m1, m2, lc1, l1, lc2, g0);
disp('Gravity Vector:');
disp(G);

C = Gr2_Ex3_CoriolisMatrix(q, dq, m2, l1, lc2);
disp('Coriolis and Centripetal Matrix:');
disp(C);

%% Test 1: M = M'
erro_M = norm(M - M');
fprintf('M - M'' = %.2e\n', round(erro_M, 4));

%% Test 2: N = dM/dt - 2C is skew symmetric (N + N' = 0)
% dM/dt computed numerically: M changes along the direction of dq
h  = 1e-6;
Mp = Gr2_Ex3_MassMatrix(q + h*dq, m1, m2, l1, lc1, lc2, I1czz, I2czz);
Mm = Gr2_Ex3_MassMatrix(q - h*dq, m1, m2, l1, lc1, lc2, I1czz, I2czz);
dM = (Mp - Mm)/(2*h);

N = dM - 2*C;
erro_N = norm(N + N');
fprintf('N = dM - 2C => N + N'' = %.2e\n', round(erro_N, 4));