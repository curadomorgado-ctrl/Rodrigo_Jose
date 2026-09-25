%% Coriolis and centripetal matrix C(q,qdot), ex1.3
% Based on Christoffel symbols of the first kind:
%   C_kj = sum_i [ 1/2 * (dM_kj/dqi + dM_ki/dqj - dM_ij/dqk) * qidot ]
%
% This only needs M(q) (already computed in inertia_matrix.m) —
% no new physics, just systematic differentiation of M.

function C = coriolis_matrix()
    syms q1 q2 q1dot q2dot real

    % Reuse M(q) from before (must be symbolic in q1, q2)
    M = inertia_matrix();

    q    = [q1, q2];
    qdot = [q1dot, q2dot];
    n = 2;

    C = sym(zeros(n,n));
    for k = 1:n
        for j = 1:n
            for i = 1:n
                c_ijk = 0.5*( diff(M(k,j), q(i)) + diff(M(k,i), q(j)) - diff(M(i,j), q(k)) );
                C(k,j) = C(k,j) + c_ijk*qdot(i);
            end
        end
    end

    C = simplify(C);
end