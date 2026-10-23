
function G = Ex3_GravityVector(q)
    global m1 m2 lc1 l1 lc2 g0
    q1 = q(1); q2 = q(2);
    
    G = [(m1*lc1 + m2*l1)*g0*cos(q1) + m2*lc2*g0*cos(q1+q2);
          m2*lc2*g0*cos(q1+q2)];
end