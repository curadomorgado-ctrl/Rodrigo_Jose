clc 
% Mass Matrix computation of of a 2-link planar arm
clear all
syms m1 m2 q dq q1 dq1 q2 dq2  g real
syms l1 l2 lc1 lc2 I1c I1cxx I1cyy I1czz I2c I2cxx I2cyy I2czz  real

I1c = [I1cxx 0 0;0 I1cyy 0; 0 0 I1czz]; % Inertia tensors referred to the center of mass
I2c = [I2cxx 0 0;0 I2cyy 0; 0 0 I2czz];

% symbolic variables

q=[q1;q2];
dq=[dq1;dq2];

% Jacobians referred to the center of mass

Jvc1 = [-lc1*sin(q1) 0; lc1*cos(q1) 0;0 0];

Jvc2 = [-l1*sin(q1)-lc2*sin(q1+q2),  -lc2*sin(q1+q2); 
         l1*cos(q1)+lc2*cos(q1+q2),   lc2*cos(q1+q2); 0 0];
    
Jw1=[0 0;0 0;1 0];
Jw2=[0 0;0 0;1 1];
    
R1=[cos(q1) -sin(q1) 0; sin(q1) cos(q1) 0; 0 0 1]; % rotation matrices associated to each coordinate frame (rotation along z)
R2=[cos(q1+q2) -sin(q1+q2) 0; sin(q1+q2) cos(q1+q2) 0; 0 0 1];
    
% Mass Matrix
M = simplify(m1*Jvc1'*Jvc1 +Jw1'*R1*I1c*R1'*Jw1  +m2*Jvc2'*Jvc2  + Jw2'*R2*I2c*R2'*Jw2)

% Kinetic Energy and Coriolis Matrix
K = simplify(1/2*dq'*M*dq)
dM = simplify(diff(M, q1)*dq1 + diff(M, q2)*dq2);
dF = simplify( [ dq'*diff(M,q1) ; dq'*diff(M,q2) ] );
C=simplify(dM -1/2*dF)

% Potential Energy and Gravity Vector
%r2= sqrt((l1*cos(q1) + lc2*cos(q1+q2))^2 + (l1*sin(q1)+lc2*sin(q1+q2))^2)*cos(pi/2+q1+q2);
r2= l1*sin(q1) + lc2*sin(q1+q2);
U= simplify(-m1*lc1*g*cos(pi/2+q1) +m2*r2*g);
G = simplify([diff(U, q1); diff(U,q2)])
