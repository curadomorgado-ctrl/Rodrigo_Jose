clc; clear all; close all;

% Parametros (iguais para todos os exercicios)

m1 = 0.3;         m2 = 0.1; 
l1 = 0.3;         l2 = 0.2;              
g0 = 9.8;         Fv = 0.04; 
% Fv if equal in both links we can consider scalar, if not we
% have to consider as diagonal matrix. This happens because dq (2x1)
% and the result of the multiplication Fv.dq has to be (2x1)


%% Ex 4 - 

modelParameters = [m1, m2, l1, l2, g0, Fv]; % simulink input
tau_c = [0, 0]; tau_e = [0, 0];
q0  = [pi/2; pi/4]; dq0 = [0; 0];      % initial conditions

out = sim('Ex4_2LinkRobot_NoFriction', 'StopTime', '5');
PlotRobot(out, l1, l2);


%% Ex 5 - tau = g(q)

modelParameters = [m1, m2, l1, l2, g0, Fv]; % simulink input
q0  = [pi/2; pi/4]; dq0 = [3; 3];      % initial conditions

out = sim('Ex5_2LinkRobot_FrictionEqGravity', 'StopTime', '5');
PlotRobot(out, l1, l2);


%% Ex 6 - forcas cartesianas

modelParameters = [m1, m2, l1, l2, g0, Fv]; % simulink input
tau_e = [0, 0];
q0  = [pi/2; pi/4]; dq0 = [0; 0];      % initial conditions

Fc = [0; -10; 0];          % [0;-10;0], [10;0;0] ou [10;-10;0]

out = sim('Ex6_2LinkRobot_CartesianForces', 'StopTime', '5');
PlotRobot(out, l1, l2);
