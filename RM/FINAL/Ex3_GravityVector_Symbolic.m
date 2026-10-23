
function G = Ex3_GravityVector_Symbolic(q, m1, m2, lc1, l1, lc2, g0)

    q1 = q(1);
    q2 = q(2);

    V = (m1*lc1 + m2*l1)*g0*sin(q1) ...
      + m2*lc2*g0*sin(q1+q2);

    G = simplify(jacobian(V, q).');
end
