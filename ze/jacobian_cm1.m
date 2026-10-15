%% Jacobian linear, centro de massa 1, ex 1.2
%
% Posição do centro de massa do elo 1 (ponto a meio do elo 1,
% a distância lc1 da base):
%   xc1 = lc1*cos(q1)
%   yc1 = lc1*sin(q1)
%
% Repara que NÃO aparece q2 -> o centro de massa 1 está fisicamente
% preso ao elo 1, por isso só a junta 1 o afeta; a junta 2 (cotovelo)
% não lhe mexe. É por isso que a coluna 2 da matriz é sempre zero.
%
% Serve para calcular a energia cinética de TRANSLAÇÃO do elo 1
% no exercício 3 (K = 1/2*m1*xdot_c1'*xdot_c1, com xdot_c1 = J*qdot).

function J = jacobian_cm1(q1, lc1)
    J = [-lc1*sin(q1),   0;
          lc1*cos(q1),   0];
end