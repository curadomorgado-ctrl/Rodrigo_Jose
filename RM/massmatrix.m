%% Mass matrix M(q), ex 1.3
% M(q) = soma_i [ mi*Jvci'*Jvci + Ii*Jwi'*Jwi ]
%
% Reaproveita as funções do exercício 1.2 (projeto iterativo: os
% Jacobianos já estão feitos e testados, não se reescrevem aqui).

function M = massmatrix(q1, q2, m1, m2, l1, lc1, lc2, I1, I2)

    % Jacobianos do exercício 1.2 (reaproveitados, não reescritos)
    Jvc1 = jacobian_cm1(q1, lc1);
    Jvc2 = jacobian_cm2(q1, q2, l1, lc2);
    Jw1  = jacobian_w1();
    Jw2  = jacobian_w2();

    % M(q): translação + rotação, elo 1 + elo 2
    M = m1*(Jvc1.')*Jvc1 + I1*(Jw1.')*Jw1 +m2*(Jvc2.')*Jvc2 + I2*(Jw2.')*Jw2;
end

