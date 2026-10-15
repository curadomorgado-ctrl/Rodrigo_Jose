syms q1 q2 dq1 dq2 m1 m2 l1 lc1 lc2 I1 I2 g0 real
q = [q1; q2];  dq = [dq1; dq2];

M_teu = massmatrix(q1,q2,m1,m2,l1,lc1,lc2,I1,I2);
C_teu = coriolis_matrix(q1,q2,dq1,dq2,m1,m2,l1,lc1,lc2,I1,I2);
G_teu = gravity_term(q1,q2,m1,m2,l1,lc1,lc2,g0);

M_col = Ex3_MassMatrix_Symbolic(q,dq,m1,m2,l1,lc1,lc2,0,0,I1,0,0,I2);
C_col = Ex3_CoriolisMatrix_Symbolic(q,dq,M_col);
G_col = Ex3_GravityVector_Symbolic(q,m1,m2,lc1,l1,lc2,g0);

simplify(M_teu - M_col), simplify(C_teu - C_col), simplify(G_teu - G_col)