function M = mass_matrix(q1,q2,m1,m2,l1,l2,lc1,lc2,I1,I2)

M = [ m2*l1^2 + 2*m2*l1*lc2*cos(q2) + m1*lc1^2 + m2*lc2^2 + I1 + I2,m2*lc2^2 + m2*l1*lc2*cos(q2) + I2;
      m2*lc2^2 + m2*l1*lc2*cos(q2) + I2, m2*lc2^2 + I2 ];

end
