
function C = Ex3_CoriolisMatrix(q, dq, m2, l1, lc2)
    q1 = q(1); q2  = q(2);
    dq1 = dq(1); dq2 = dq(2);

    C = [ -m2*l1*lc2*sin(q2) * dq2,   -m2*l1*lc2*sin(q2) * (dq1 + dq2);
           m2*l1*lc2*sin(q2) * dq1,   0 ];
end