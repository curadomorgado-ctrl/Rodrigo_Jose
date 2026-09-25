%% Jacobian function, centro de massa2 ex1.2
function J_cm2 = jacobian_cm2(q1, q2, l1, lc2)
    J_cm2 = [-l1*sin(q1) - lc2*sin(q1+q2),   -lc2*sin(q1+q2);
          l1*cos(q1) + lc2*cos(q1+q2),    lc2*cos(q1+q2)];
end
