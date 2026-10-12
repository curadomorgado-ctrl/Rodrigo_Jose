
function [Jv_EndEffector, Jv_CM1, Jv_CM2, Jw_EndEffector, Jw_CM1, Jw_CM2] = Jacobians(q, l1, l2, lc1, lc2) % robots with 2 links
    q1 = q(1); q2 = q(2);   % Joint angles

    % Linear Jacobian  v = Jv(q) . q'
    Jv_EndEffector = [ -l1*sin(q1)-l2*sin(q1 + q2), -l2*sin(q1 + q2);  % End-effector: 
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
