%% Jacobian angular, elo 2, ex 1.2
%
% O elo 2 é "arrastado" pela rotação da junta 1 e depois roda mais um
% pouco por causa da junta 2 -> a sua velocidade angular é a soma:
%   w2 = q1dot + q2dot   ->   w2 = [1, 1] * [q1dot; q2dot]
%
% Tal como no elo 1, é uma relação constante (sem senos/cossenos),
% porque num robô planar em série cada junta soma diretamente a sua
% rotação às anteriores.
%
% Serve para calcular a energia cinética de ROTAÇÃO do elo 2
% no exercício 3.

function J_cm2_w = jacobian_w2()
    J_cm2_w = [1, 1];
end