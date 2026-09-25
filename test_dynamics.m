%% Test all dynamics functions together, ex1.3
clear; clc;

syms q1 q2 q1dot q2dot real

%% Compute the three functions
M = inertia_matrix();
C = coriolis_matrix();
g_vec = gravity_term();

%% Display symbolic results
disp('--- M(q) ---')
disp(M)

disp('--- C(q,qdot) ---')
disp(C)

disp('--- g(q) ---')
disp(g_vec)

%% Sanity check 1: M symmetric?
disp('--- Check: M - M.'' should be zero (M symmetric) ---')
disp(simplify(M - M.'))

%% Sanity check 2: skew-symmetry of Mdot - 2C
Mdot = diff(M,'q1')*q1dot + diff(M,'q2')*q2dot;
N = Mdot - 2*C;
disp('--- Check: N + N.'' should be zero (skew-symmetric) ---')
disp(simplify(N + N.'))