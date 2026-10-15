%% Termo de gravidade g(q), ex 1.3
%
% Pergunta a que responde: "quanto peso cada junta sente, consoante
% a posição atual do braço?"
%
% Baseado nos apontamentos do professor:
%   U(elo i) = -mi * rci' * g_vec        (energia potencial do elo i)
%   U(robô)  = soma_i [ -mi * rci' * g_vec ]
%   g(q)     = dU/dq
%
% rci = [xci; yci] é a posição do centro de massa do elo i
% g_vec = [0; -g_acc] é o vetor gravidade (só atua na vertical, -y)
%
% Como g_vec só tem componente em y, o produto interno simplifica:
%   rci' * g_vec = xci*0 + yci*(-g_acc) = -g_acc*yci
% Substituindo:
%   U(elo i) = -mi*(-g_acc*yci) = mi*g_acc*yci
%
% Ou seja, em 2D só interessa a ALTURA (y) de cada centro de massa
% -> é a mesma fórmula de sempre, Ep = m*g*h, aplicada a cada elo.
%
% IMPORTANTE (projeto iterativo): as posições yc1 e yc2 usadas aqui
% são as MESMAS que já apareceram implicitamente nos Jacobianos
% lineares do exercício 1.2 (jacobian_cm1, jacobian_cm2) -> não é
% física nova, é só "andar um passo atrás" até à posição, antes de
% ter sido derivada em velocidade.

function g_vec = gravity_term(q1, q2, m1, m2, l1, lc1, lc2, g_acc)

    % Alturas (componente y) dos centros de massa de cada elo
    % (posições de onde vieram os Jacobianos lineares do ex 1.2)
    yc1 = lc1*sin(q1);
    yc2 = l1*sin(q1) + lc2*sin(q1+q2);

    % Energia potencial total do robô: soma de mi*g*yi para cada elo
    U = m1*g_acc*yc1 + m2*g_acc*yc2;

    % g(q) = dU/dq -> derivada parcial de U em ordem a cada junta.
    % jacobian(U,[q1,q2]) dá um vetor-linha [dU/dq1, dU/dq2];
    % transpõe-se (.') para ficar um vetor-coluna, como g(q) deve ser.
    g_vec = jacobian(U, [q1, q2]).';
    g_vec = simplify(g_vec);
end