clc; clear all; close all;

% dados do enunciado
m1 = 0.3;         m2 = 0.1; % Tratar como matrizes??
l1 = 0.3;         l2 = 0.2;              
lc1 = l1/2;       lc2 = l2/2;
 
I1cxx = 0; I1cyy = 0; I1czz = m1*l1^2/12;
I2cxx = 0; I2cyy = 0; I2czz = m2*l2^2/12;
Fv = 0.04; g0 = 9.8;


%% 1- Forward Kinematics
% q é o joint vector (posição angular em relação ao elo anterior: Fig1 tp_RM2026.pdf)
q = [pi/4 pi/4];

[x, y, phi] = Gr2_Ex1_ForwardKinematics(q, l1, l2);

pos_JointVector = [x, y];
total_angle = phi;          % regarding the base cartesian referencial

disp("Cartesian Position of the End-Effector:")
disp(pos_JointVector)
disp("Total Angle relative to the Cartesian Reference: ")
disp(total_angle)

%% 1- Comparison with function made by AI tool

pos_AI = Gr2_Ex1_AI_Tool_ForwardKinematics(q, l1, l2);
disp("Cartesian Position of the End-Effector made by AI tool:")
disp(pos_AI)

error = abs(pos_JointVector - pos_AI);
total_error = sqrt(error(1)^2 + error(2)^2);
disp("Error in each coordinate, x and y: ")
disp(error)
disp("Error in magnitude: ")
disp(total_error)

%% 2- Jacobians

[Jv_EndEffector, Jv_CM1, Jv_CM2, Jw_EndEffector, Jw_CM1, Jw_CM2] = Gr2_Ex2_Jacobians(q, l1, l2, lc1, lc2); 

fprintf('\n--- Linear Jacobians ---\n\n')
disp("1st link, linear: ")
disp(Jv_CM1)
disp("2st link, linear: ")
disp(Jv_CM2)
disp("End-Effector linear: ")
disp(Jv_EndEffector)

fprintf('\n--- Angular Jacobians (considering 3D ans 2links) ---\n\n')
disp("1st link, angular: ")
disp(Jw_CM1)
disp("2st link, angular: ")
disp(Jw_CM2)
disp("End-Effector angular: ")
disp(Jw_EndEffector)

%% 2 - Comparison with AI tools functions

% Since the AI considered only 2D and we considered always 3D in the
% Jacobians, the matrixes have different sizes. Thats why in the error
% computations we apply a small correction size by extracting only the rows
% from the "hand made" version that contained 2D info

[Jv_ee_AI, Jv_c1_AI, Jv_c2_AI, Jw_ee_AI, Jw_c1_AI, Jw_c2_AI] = Gr2_Ex2_AI_Tool_Jacobians(q, l1, l2, lc1, lc2);

fprintf('\n--- Linear Jacobians made by AI tool ---\n\n')

disp("1st link, linear (made by AI tool): ")
disp(Jv_c1_AI)
error_Jv1 = norm(Jv_CM1(1:2, :) - Jv_c1_AI, 'fro');
disp("Error: ")
disp(error_Jv1)

disp("2st link, linear (made by AI tool): ")
disp(Jv_c2_AI)
error_Jv2 = norm(Jv_CM2(1:2, :) - Jv_c2_AI, 'fro');
disp("Error: ")
disp(error_Jv2)

disp("End-Effector linear (made by AI tool): ")
disp(Jv_ee_AI)
error_Jvee = norm(Jv_EndEffector(1:2, :) - Jv_ee_AI, 'fro');
disp("Error: ")
disp(error_Jvee)

fprintf('\n--- Angular Jacobians made by AI tool ---\n\n')
disp("1st link, angular (made by AI tool): ")
disp(Jw_c1_AI)
error_Jw1 = norm(Jw_CM1(3, :) - Jw_c1_AI, 'fro');
disp("Error: ")
disp(error_Jw1)

disp("2st link, angular (made by AI tool): ")
disp(Jw_c2_AI)
error_Jw2 = norm(Jw_CM2(3, :) - Jw_c2_AI, 'fro');
disp("Error: ")
disp(error_Jw2)

disp("End-Effector linear (made by AI tool): ")
disp(Jw_ee_AI)
error_Jwee = norm(Jw_EndEffector(3, :) - Jw_ee_AI, 'fro');
disp("Error: ")
disp(error_Jwee)
