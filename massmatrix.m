%% Mass matrix M(q), versão completa (3D), ex 1.3
%
% Versão alternativa do massmatrix.m, seguindo a formulação mais geral
% que o professor mostrou na aula: Jacobianos 3x2 (com a componente z,
% sempre zero no caso planar), tensor de inércia 3x3 (I1cxx, I1cyy,
% I1czz) e matrizes de rotação R1, R2 para rodar a inércia do
% referencial do elo para o referencial da base:
%
%   M(q) = soma_i [ mi*Jvci'*Jvci + Jwi'*(Ri*Iic*Ri')*Jwi ]
%
% Continua a reaproveitar as Jacobianas do exercício 1.2 (não se
% reescrevem à mão) — só se acrescenta a linha de zeros (componente z)
% por fora, para as tornar 3x2.
%
% No caso planar, I1cxx=I1cyy=0 (só a rotação em z importa), e como a
% rotação R1/R2 também é só em z, confirma-se que Ri*Iic*Ri' = Iic
% -> este código dá exatamente o mesmo resultado que o massmatrix.m
% mais simples (só com I1, I2 escalares).

function M = massmatrix(q1, q2, m1, m2, l1, lc1, lc2, I1czz, I2czz)

    % Jacobianos lineares do ex 1.2 (2x2), reaproveitados, com uma
    % linha extra de zeros acrescentada por fora (componente z,
    % sempre nula porque o robô é planar)
    Jvc1_2d = jacobian_cm1(q1, lc1);
    Jvc2_2d = jacobian_cm2(q1, q2, l1, lc2);
    Jvc1 = [Jvc1_2d; 0, 0];
    Jvc2 = [Jvc2_2d; 0, 0];

    % Jacobianos angulares do ex 1.2 (1x2), reaproveitados, agora
    % escritos como 3x2: só a linha de z é não-nula
    Jw1_1d = jacobian_w1();
    Jw2_1d = jacobian_w2();
    Jw1 = [0, 0; 0, 0; Jw1_1d];
    Jw2 = [0, 0; 0, 0; Jw2_1d];

    % Tensores de inércia referidos ao centro de massa (3x3).
    % No caso planar só a componente zz é não-nula.
    I1c = [0 0 0; 0 0 0; 0 0 I1czz];
    I2c = [0 0 0; 0 0 0; 0 0 I2czz];

    % Matrizes de rotação de cada referencial (rotação em torno de z)
    R1 = [cos(q1) -sin(q1) 0; sin(q1) cos(q1) 0; 0 0 1];
    R2 = [cos(q1+q2) -sin(q1+q2) 0; sin(q1+q2) cos(q1+q2) 0; 0 0 1];

    % M(q): contribuição linear + contribuição angular (com a inércia
    % já rodada para o referencial da base), para cada elo
    M = m1*(Jvc1.')*Jvc1 + (Jw1.')*R1*I1c*(R1.')*Jw1 + ...
        m2*(Jvc2.')*Jvc2 + (Jw2.')*R2*I2c*(R2.')*Jw2;

    M = simplify(M);
end