%% Group 3 - Ex 1: straight line motion avoiding the vital area
clear; close all;
modelo = 'Gr_3_Ex1_3linkedRobot';    % Simulink model

% Robot and task (slides 179-181)
L   = [1 1 0.3];                     % link lengths
qd0 = [pi/12; pi/3; pi/3];           % initial joint position
Xf  = [1.5; -1.2];                   % final position of the end-effector
Kp  = 10;                            % task gain

% Simulation and plot
Tsim = '2';                          % simulation time [s]
dt   = 0.1;                          % time between drawn poses [s]

%% Slide 182 - no null space
Kq  = 0;
qdp = [0; 0; 0];
out = sim(modelo, 'StopTime', Tsim);
PlotPoses3(out, L, qdp, dt);

%% Slide 183 - qdp = [80 -160 80] deg
Kq  = 10;
qdp = [80; -160; 80]*pi/180;
out = sim(modelo, 'StopTime', Tsim);
PlotPoses3(out, L, qdp, dt);

%% Slide 184 - qdp = [90 -90 -90] deg
Kq  = 10;
qdp = [90; -90; -90]*pi/180;
out = sim(modelo, 'StopTime', Tsim);
PlotPoses3(out, L, qdp, dt);