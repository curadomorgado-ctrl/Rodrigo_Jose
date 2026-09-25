%% Inertia matrix M(q), ex1.3
% Based on lecture notes:
%   K = 1/2 * qdot' * M(q) * qdot                    (total kinetic energy)
%   K_trans,i = 1/2 * mi * xdot_ci' * xdot_ci,  xdot_ci = Jv_ci * qdot
%   K_rot,i   = 1/2 * Ii * wi^2,                wi     = Jw_i  * qdot
%
% Substituting and matching terms with K = 1/2*qdot'*M*qdot gives:
%   M(q) = sum_i [ mi * Jv_ci' * Jv_ci + Ii * Jw_i' * Jw_i ]
%
% i.e. M(q) is built directly from the Jacobians computed in ex1.2

function M = inertia_matrix()
    syms q1 q2 l1 lc1 lc2 m1 m2 I1 I2 real

    % Reuse the Jacobians from ex1.2 (they work symbolically too)
    Jvc1 = jacobian_cm1(q1, lc1);
    Jvc2 = jacobian_cm2(q1, q2, l1, lc2);
    Jw1  = jacobian_w1();
    Jw2  = jacobian_w2();

    % M(q) = translational contribution + rotational contribution, for each link
    M = m1*(Jvc1.')*Jvc1 + I1*(Jw1.')*Jw1 + ...
        m2*(Jvc2.')*Jvc2 + I2*(Jw2.')*Jw2;

    M = simplify(M);
end