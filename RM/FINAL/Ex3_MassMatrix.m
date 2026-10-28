% output M is a 2x2 matrix, because the robot is 2 linked
% so it has 2 dof -> 2 joints
function M = Ex3_MassMatrix(q, m1, m2, l1, lc1, lc2, I1czz, I2czz)
    q1 = q(1); q2 = q(2);

    M = [ m2*l1^2 + 2*m2*cos(q2)*l1*lc2 + m1*lc1^2 + m2*lc2^2 + I1czz + I2czz,   m2*lc2^2 + l1*m2*cos(q2)*lc2 + I2czz;
          m2*lc2^2 + l1*m2*cos(q2)*lc2 + I2czz,                                  m2*lc2^2 + I2czz];
end