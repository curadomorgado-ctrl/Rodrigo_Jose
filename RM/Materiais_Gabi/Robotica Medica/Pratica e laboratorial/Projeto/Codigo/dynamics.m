function ddq = dynamics(q,dq,Tc,Te,Fv,m1,m2,l1,l2,lc1,lc2,I1,I2,g)
M = mass_matrix(q(1),q(2),m1,m2,l1,l2,lc1,lc2,I1,I2);
C = coriolis_matrix(q(1),q(2),dq(1),dq(2),m1,m2,l1,l2,lc1,lc2);
G = gravity_vector(q(1),q(2),m1,m2,l1,l2,lc1,lc2,g);
tau = Tc + Te;
ddq = M \ (tau - C*dq - G - Fv * dq);