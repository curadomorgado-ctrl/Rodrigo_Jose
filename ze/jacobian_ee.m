%% Jacobian end-effector, ex 1.2
%
% Pergunta a que responde: "se eu mexer q1 e q2 a uma certa velocidade,
% a que velocidade se move a PONTA do braço (end-effector)?"
%
% Parte-se da cinemática direta (ex 1.1):
%   x = l1*cos(q1) + l2*cos(q1+q2)
%   y = l1*sin(q1) + l2*sin(q1+q2)
%
% Como q1 e q2 variam no tempo, deriva-se x e y em ordem ao tempo
% usando a regra da cadeia:
%   xdot = (dx/dq1)*q1dot + (dx/dq2)*q2dot
%   ydot = (dy/dq1)*q1dot + (dy/dq2)*q2dot
%
% Escrito em forma matricial: [xdot;ydot] = J * [q1dot;q2dot]
% J é a "tabela de sensibilidades": cada entrada diz quanto x (ou y)
% muda por cada pequena variação em q1 (ou q2).

function J = jacobian_ee(q1, q2, l1, l2)
    J = [-l1*sin(q1) - l2*sin(q1+q2),   -l2*sin(q1+q2);
          l1*cos(q1) + l2*cos(q1+q2),    l2*cos(q1+q2)];
end