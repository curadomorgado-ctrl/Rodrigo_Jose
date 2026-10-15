%% Jacobian linear, centro de massa 2, ex 1.2
%
% Posição do centro de massa do elo 2 (percorre todo o elo 1, depois
% avança lc2 no elo 2, na direção q1+q2):
%   xc2 = l1*cos(q1) + lc2*cos(q1+q2)
%   yc2 = l1*sin(q1) + lc2*sin(q1+q2)
%
% Repara que isto é igual à cinemática direta do end-effector, só
% trocando l2 por lc2 no segundo termo -> por isso a derivação segue
% exatamente os mesmos passos de jacobian_ee.
%
% Agora SIM depende de q1 e q2: se a junta 1 rodar, arrasta o braço
% inteiro (incluindo o elo 2); se a junta 2 rodar, só afeta o elo 2.
%
% Serve para calcular a energia cinética de TRANSLAÇÃO do elo 2
% no exercício 3.

function J = jacobian_cm2(q1, q2, l1, lc2)
    J = [-l1*sin(q1) - lc2*sin(q1+q2),   -lc2*sin(q1+q2);
          l1*cos(q1) + lc2*cos(q1+q2),    lc2*cos(q1+q2)];
end