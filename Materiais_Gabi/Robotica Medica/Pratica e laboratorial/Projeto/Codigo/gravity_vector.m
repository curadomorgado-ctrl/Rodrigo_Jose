function G = gravity_vector(q1,q2,m1,m2,l1,l2,lc1,lc2,g)

G = [ g*(l1*m2*cos(q1) + lc1*m1*cos(q1) + lc2*m2*cos(q1 + q2));
      g*lc2*m2*cos(q1 + q2) ];
end
