function C = coriolis_matrix(q1,q2,dq1,dq2,m1,m2,l1,l2,lc1,lc2)

C = [ -2*dq2*l1*lc2*m2*sin(q2),      -dq2*l1*lc2*m2*sin(q2);
       (l1*lc2*m2*sin(q2)*(2*dq1 - dq2))/2,   (dq1*l1*lc2*m2*sin(q2))/2 ];
end
