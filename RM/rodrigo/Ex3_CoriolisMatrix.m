
function C = Ex3_CoriolisMatrix(q, dq, m2, l1, lc2)
    q2  = q(2);
    dq1 = dq(1);
    dq2 = dq(2);
    h = -m2*l1*lc2*sin(q2);
    C = [ h*dq2,   h*(dq1 + dq2);
         -h*dq1,   0 ];
end