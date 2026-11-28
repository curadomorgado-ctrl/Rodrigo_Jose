%% Group 3 - Ex 2: horizontal motion with an elbow-up posture
clear; close all;
modelo = 'Gr_3_Ex2_3linkedRobot';    % Simulink model (copy of Ex1 with the new Xd block)

% Robot and task
L   = [1 1 0.3];                     % link lengths
qd0 = [pi/12; pi/3; pi/3];           % initial joint position
Xf  = [1.6 0.4;                      % waypoints, one per column:
       1.2 1.2];                     % start of the line (1.6,1.2) and end (0.4,1.2)
Kp  = 10;                            % task gain

% Simulation and plot
Tsim = '4.5';                        % simulation time [s]
dt   = 0.1;                          % time between drawn poses [s]

%% No null space (stays elbow-down)
Kq  = 0;
qdp = [0; 0; 0];
out = sim(modelo, 'StopTime', Tsim);
PlotPoses3(out, L, qdp, dt);

%% Elbow-up posture qdp = [90 -90 -90] deg
Kq  = 10;
qdp = [90; -90; -90]*pi/180;
out = sim(modelo, 'StopTime', Tsim);
PlotPoses3(out, L, qdp, dt);