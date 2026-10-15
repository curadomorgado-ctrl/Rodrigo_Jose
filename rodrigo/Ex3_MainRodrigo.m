clc; clear all; close all;

% 3- M(q), C(q,q'), g(q)

syms m1 m2 q1 dq1 q2 dq2 real
syms l1 l2 lc1 lc2 I1cxx I1cyy I1czz I2cxx I2cyy I2czz real
syms g0 real

% Joint position and velocity vectors
q = [q1; q2];
dq = [dq1; dq2];

M = Ex3_MassMatrix_Symbolic(q, dq, m1, m2, l1, lc1, lc2, I1cxx, I1cyy, I1czz, I2cxx, I2cyy, I2czz)
C = Ex3_CoriolisMatrix_Symbolic(q, dq, M)
G = Ex3_GravityVector_Symbolic(q, m1, m2, lc1, l1, lc2, g0)