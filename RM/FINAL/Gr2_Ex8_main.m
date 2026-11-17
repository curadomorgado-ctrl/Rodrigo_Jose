%% Ex 8 - Diagonal trajectories with arbitrary slope, different control gains
% Same control law as Ex 7:
%   tau_c = g(q) + J'*[Kp*(Xd - X) + Kd*(dXd - dX)]      (Kd = 0 -> P control)
% Reference: back-and-forth motion along a straight line with slope theta
%   Xd = C + A*[cos(theta); sin(theta)]*sin(2*pi*f*t)
clear; close all;
modelo = 'Ex8_2LinkRobot_TaskSpacePD';   % Simulink model (copy of Ex7)

% Robot parameters [m1 m2 l1 l2 g0 Fv]
m1 = 0.3;  m2 = 0.1;  l1 = 0.3;  l2 = 0.2;  g0 = 9.8;  Fv = 0.04;
modelParameters = [m1 m2 l1 l2 g0 Fv];
dq0   = [0; 0];
tau_e = [0; 0];

% Line: centre (xc, yc), amplitude A, frequency f
xc = 0.2;  yc = 0.2;  A = 0.3;  f = 1/3;
Tsim = '9';                              % 3 cycles

% q0 puts the tip on the centre of the line (inverse kinematics, elbow down)
c2 = (xc^2 + yc^2 - l1^2 - l2^2)/(2*l1*l2);
q2 = acos(c2);
q1 = atan2(yc, xc) - atan2(l2*sin(q2), l1 + l2*cos(q2));
q0 = [q1; q2];

%% 1) One case animated: slope 45 deg, PD
theta = 130*pi/180;
diagLine = [xc yc A theta f];
Kp = 100;  Kd = 10;
out = sim(modelo, 'StopTime', Tsim);
PlotRobot(out, l1, l2, xc + A*cos(theta)*[-1 1], yc + A*sin(theta)*[-1 1]);
