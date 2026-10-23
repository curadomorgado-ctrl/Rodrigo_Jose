% JACOBIANS  Jacobianos linear e angular da ponta e dos centros de massa
%
% Jacobianos lineares: Jv = [dx/dq1 dx/dq2; dy/dq1 dy/dq2; 0 0], derivando as posicoes
% Terceira linha nula porque o movimento é no plano xy
%
%   Ponta: x = l1*cos(q1) + l2*cos(q1+q2),   y = l1*sin(q1) + l2*sin(q1+q2)
%   CM1:   xc1 = lc1*cos(q1),                yc1 = lc1*sin(q1)  -> nao depende de q2, coluna 2 nula
%   CM2:   igual a ponta com lc2 no lugar de l2


% Jacobianos angulares: juntas rotacionais em z, so a linha de wz é nao nula
%
%   Elo 1 roda com q1:          wz = q1'          -> [1 0]
%   Elo 2 e ponta rodam com q1+q2: wz = q1' + q2'  -> [1 1]


function [Jv_EndEffector, Jv_CM1, Jv_CM2, Jw_EndEffector, Jw_CM1, Jw_CM2] = Jacobians(q)
    global l1 l2 lc1 lc2
    q1 = q(1); q2 = q(2);   % Joint angles

    % Linear Jacobian  v = Jv(q) . q'

    Jv_EndEffector = [ -l1*sin(q1)-l2*sin(q1 + q2), -l2*sin(q1 + q2);  % End-effector
                        l1*cos(q1)+l2*cos(q1 + q2),  l2*cos(q1 + q2);
                        0,                           0 ];

    Jv_CM1 = [ -lc1*sin(q1), 0;    % Link 1 centre of mass
                lc1*cos(q1), 0;
                0,           0 ];

    Jv_CM2 = [ -l1*sin(q1)-lc2*sin(q1 + q2), -lc2*sin(q1 + q2);    % Link 2 centre of mass
                l1*cos(q1)+lc2*cos(q1 + q2),  lc2*cos(q1 + q2);
                0,                            0 ];

    % Angular Jacobian  w = Jw(q) . q'

    Jw_EndEffector = [ 0, 0;    % End-effector
                       0, 0;
                       1, 1 ];

    Jw_CM1 = [ 0, 0;    % Link 1 centre of mass
               0, 0;
               1, 0 ];

    Jw_CM2 = [ 0, 0;    % Link 2 centre of mass
               0, 0;
               1, 1 ];
end