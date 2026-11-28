function [M, C, G] = Gr2_Ex3_AI_Tool_Dynamics()
% Symbolic dynamic model of a 2-link planar robot (Lagrangian formulation):
%   M(q)*ddq + C(q,dq)*dq + g(q) = tau
% Returns M(q), C(q,dq) and g(q) as symbolic expressions.

syms q1 q2 dq1 dq2 m1 m2 l1 l2 lc1 lc2 g0 real
q  = [q1; q2];
dq = [dq1; dq2];
I1 = m1*l1^2/12;  I2 = m2*l2^2/12;

% Centre of mass positions
pc1 = [lc1*cos(q1); lc1*sin(q1)];
pc2 = [l1*cos(q1) + lc2*cos(q1+q2); l1*sin(q1) + lc2*sin(q1+q2)];

% Centre of mass velocities
vc1 = jacobian(pc1, q)*dq;
vc2 = jacobian(pc2, q)*dq;

% Kinetic and potential energy
K = 1/2*m1*(vc1.'*vc1) + 1/2*m2*(vc2.'*vc2) + 1/2*I1*dq1^2 + 1/2*I2*(dq1 + dq2)^2;
U = m1*g0*pc1(2) + m2*g0*pc2(2);

% Inertia matrix and gravity vector
M = simplify(hessian(K, dq));
G = simplify(jacobian(U, q).');

% Coriolis/centripetal matrix (Christoffel symbols)
n = length(q);
C = sym(zeros(n));
for k = 1:n
    for j = 1:n
        for i = 1:n
            C(k,j) = C(k,j) + 1/2*(diff(M(k,j), q(i)) + diff(M(k,i), q(j)) - diff(M(i,j), q(k)))*dq(i);
        end
    end
end
C = simplify(C);
end



