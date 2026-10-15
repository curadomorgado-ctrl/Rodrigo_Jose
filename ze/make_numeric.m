%% make_numeric.m - gera coriolis_num.m e gravity_num.m (corre uma vez)
syms q1 q2 q1dot q2dot m1 m2 l1 lc1 lc2 I1 I2 g_acc real

C_s = coriolis_matrix(q1, q2, q1dot, q2dot, m1, m2, l1, lc1, lc2, I1, I2);
g_s = gravity_term(q1, q2, m1, m2, l1, lc1, lc2, g_acc);

matlabFunction(C_s, 'File', 'coriolis_num', ...
    'Vars', {q1, q2, q1dot, q2dot, m1, m2, l1, lc1, lc2, I1, I2});
matlabFunction(g_s, 'File', 'gravity_num', ...
    'Vars', {q1, q2, m1, m2, l1, lc1, lc2, g_acc});