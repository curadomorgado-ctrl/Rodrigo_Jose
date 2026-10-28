clc; clear all; close all;

% 3 - Mass matrix M(q), Coriolis matrix C(q,dq) and gravity vector G(q)

syms q1 dq1 q2 dq2 real
syms m1 m2 l1 l2 lc1 lc2 g0 real
syms I1cxx I1cyy I1czz I2cxx I2cyy I2czz real

% Joint position and velocity vectors
% q = [q1; q2];  dq = [dq1; dq2];


%% Mass matrix M(q)

% Inertia tensors referred to the center of mass
I1c = [I1cxx,  0,      0;
       0,      I1cyy,  0;
       0,      0,      I1czz];

I2c = [I2cxx,  0,      0;
       0,      I2cyy,  0;
       0,      0,      I2czz];

% Linear Jacobians of the centers of mass
Jvc1 = [-lc1*sin(q1),  0;
         lc1*cos(q1),  0;
         0,            0];

Jvc2 = [-l1*sin(q1)-lc2*sin(q1+q2),  -lc2*sin(q1+q2);
         l1*cos(q1)+lc2*cos(q1+q2),   lc2*cos(q1+q2);
         0,                           0];

% Angular Jacobians
Jw1 = [0,  0;
       0,  0;
       1,  0];

Jw2 = [0,  0;
       0,  0;
       1,  1];

% Rotation matrices from each link frame to the base frame
R1 = [cos(q1), -sin(q1),  0;
      sin(q1),  cos(q1),  0;
      0,        0,        1];

R2 = [cos(q1+q2), -sin(q1+q2),  0;
      sin(q1+q2),  cos(q1+q2),  0;
      0,           0,           1];

% The mass matrix is obtained from the kinetic energy:
%
% T = 0.5*sum(m_i*vc_i'*vc_i + w_i'*I_i*w_i)
%
% Using vc_i = Jvc_i*dq and w_i = Jw_i*dq:
%
% M(q) = sum(m_i*Jvc_i'*Jvc_i ...
%            + Jw_i'*R_i*Iic_i*R_i'*Jw_i)
%
% The matrix M is 2x2 because the robot has two joints.

% For this planar manipulator, the resulting matrix is:
%
% M11 = m1*lc1^2 + I1czz + m2*l1^2 ...
%       + 2*m2*l1*lc2*cos(q2) + m2*lc2^2 + I2czz
%
% M12 = M21 = m2*lc2^2 + m2*l1*lc2*cos(q2) + I2czz
%
% M22 = m2*lc2^2 + I2czz

MassMatrix = m1*(Jvc1')*Jvc1 + (Jw1')*R1*I1c*(R1')*Jw1 ...
           + m2*(Jvc2')*Jvc2 + (Jw2')*R2*I2c*(R2')*Jw2;
M = simplify(MassMatrix);

disp('Mass matrix M(q):')
disp(M)
% fprintf('Dimensions of M: %d x %d\n\n', size(M));


%% Coriolis matrix C(q,dq)

% The Coriolis matrix is obtained from the derivatives of M(q):
%
% Cij = sum_k 0.5*(dMij/dqk + dMik/dqj - dMjk/dqi)*dqk
%
% This expression uses the Christoffel symbols and accounts for
% the velocity-dependent terms in the equations of motion.
%
% For this 2-DOF planar manipulator, the result is:
%
% C11 = -m2*l1*lc2*sin(q2)*dq2
% C12 = -m2*l1*lc2*sin(q2)*(dq1 + dq2)
% C21 =  m2*l1*lc2*sin(q2)*dq1
% C22 = 0

CoriolisMatrix = [-m2*l1*lc2*sin(q2)*dq2, -m2*l1*lc2*sin(q2)*(dq1+dq2);
                   m2*l1*lc2*sin(q2)*dq1,  0];
C = simplify(CoriolisMatrix);

disp('Coriolis matrix C(q,dq):')
disp(C)
% fprintf('Dimensions of C: %d x %d\n\n', size(C));


%% Gravitational vector G(q)

% The gravitational vector is obtained from the potential energy:
%
% V = sum(m_i*g0*h_i)
%
% For the first link:
% h1 = lc1*sin(q1)
%
% For the second link:
% h2 = l1*sin(q1) + lc2*sin(q1+q2)
%
% Therefore:
%
% V(q) = (m1*lc1 + m2*l1)*g0*sin(q1) ...
%        + m2*lc2*g0*sin(q1+q2)

V = (m1*lc1 + m2*l1)*g0*sin(q1) + m2*lc2*g0*sin(q1+q2);

% disp('Potential energy V(q):')
% disp(V)

% The gravity vector is the gradient of the potential energy:
%
% G(q) = dV/dq = [dV/dq1; dV/dq2]
%
% G1 = (m1*lc1 + m2*l1)*g0*cos(q1) ...
%      + m2*lc2*g0*cos(q1+q2)
%
% G2 = m2*lc2*g0*cos(q1+q2)
%
% In Cartesian coordinates, the conservative force is F = -dV/dx.
% In the robot dynamics, G = dV/dq appears on the left-hand side
% of M(q)*ddq + C(q,dq)*dq + G(q) = tau.

GravityVector = jacobian(V, [q1, q2])';
G = simplify(GravityVector);

disp('Gravity vector G(q):')
disp(G)
% fprintf('Dimensions of G: %d x %d\n\n', size(G));