%% Gravity term g(q), ex1.3
% Based on lecture notes:
%   U(Link i) = -m_i * r_ci' * g_vec        (potential energy of link i)
%   U(robot)  = sum_i [ -m_i * r_ci' * g_vec ]
%   g(q)      = dU/dq
%
% r_ci = [x_ci; y_ci] is the position vector of link i's center of mass
% g_vec = [0; -g_acc] is the gravity vector (only acts in -y direction)
%
% Since g_vec has zero x-component, the dot product r_ci' * g_vec
% simplifies to:
%   r_ci' * g_vec = x_ci*0 + y_ci*(-g_acc) = -g_acc * y_ci
%
% Substituting into U(Link i):
%   U(Link i) = -m_i * (-g_acc * y_ci) = m_i * g_acc * y_ci
%
% So in 2D (planar robot), only the y-component (height) of each
% center of mass matters for gravitational potential energy.
function g_vec = gravity_term()
    syms q1 q2 l1 lc1 lc2 m1 m2 g_acc real
    
    % y-components of each center of mass (from ex1.2 Jacobian derivation)
    yc1 = lc1*sin(q1);                        % height of link 1's center of mass
    yc2 = l1*sin(q1) + lc2*sin(q1+q2);        % height of link 2's center of mass
    
    % Total potential energy: U = m1*g*yc1 + m2*g*yc2
    % (this is the simplified form of U(robot) = sum_i [-m_i * r_ci' * g_vec])
    U = m1*g_acc*yc1 + m2*g_acc*yc2;
    
    % g(q) = dU/dq  -> partial derivative of U w.r.t. each joint angle
    % jacobian(U, [q1,q2]) gives a row vector [dU/dq1, dU/dq2]
    % transpose (.') to match the column vector convention used for g(q)
    g_vec = jacobian(U, [q1, q2]).';
    g_vec = simplify(g_vec);
end

