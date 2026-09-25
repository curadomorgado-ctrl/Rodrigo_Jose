%% Jacobian function, centro de massa1 ex1.2
function J_cm1 = jacobian_cm1(q1,lc1)
  J_cm1 = [-lc1*sin(q1),   0;
          lc1*cos(q1),   0];
end

