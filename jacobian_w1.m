%% Jacobian angular, elo 1, ex 1.2
%
% Pergunta a que responde: "a que velocidade ANGULAR roda o elo 1?"
%
% Como o robô é planar (nunca sai do plano xy), a única rotação
% possível é em torno do eixo z (perpendicular à folha). O elo 1
% roda exatamente ao ritmo da junta 1 -> não há geometria/trigonometria
% envolvida, é uma relação direta e constante:
%   w1 = q1dot   ->   w1 = [1, 0] * [q1dot; q2dot]
%
% Serve para calcular a energia cinética de ROTAÇÃO do elo 1
% no exercício 3 (K_rot = 1/2*I1*w1^2).

function J_cm1_w = jacobian_w1()
    J_cm1_w = [1, 0];
end