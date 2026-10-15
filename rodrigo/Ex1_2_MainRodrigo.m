clc; clear all; close all;

% dados do enunciado

m1 = 0.3;         m2 = 0.1; % Tratar como matrizes??
l1 = 0.3;         l2 = 0.2;              
lc1 = l1/2;       lc2 = l2/2;
 
I1cxx = 0; I1cyy = 0; I1czz = m1*l1^2/12;
I2cxx = 0; I2cyy = 0; I2czz = m2*l2^2/12;
Fv = 0.04;

%% 1- Forward Kinematics
% q é o joint vector (posição angular em relação ao elo anterior: Fig1 tp_RM2026.pdf)
q = [pi/4 pi/4];

[x, y, phi] = Ex1_ForwardKinematics(q,l1,l2);

pos_JointVector = [x, y];
total_angle = phi;          % regarding the base cartesian referencial


%% 2- Jacobians

[Jv_EndEffector, Jv_CM1, Jv_CM2, Jw_EndEffector, Jw_CM1, Jw_CM2] = Ex2_Jacobians(q, l1, l2, lc1, lc2)

