%% Ex 7 - Task space position control (P and PD) on an elliptical trajectory
% Control law (slide 159 with Ki = 0, gravity compensation eq. 5.6, tau = J'F eq. 3.143):
%   tau_c = g(q) + J'*[Kp*(Xd - X) + Kd*(dXd - dX)]      (Kd = 0 -> P control)
clear; close all;
modelo = 'Ex7_2LinkRobot_TaskSpacePD';   % Simulink model (copy of Ex6)

% Robot parameters [m1 m2 l1 l2 g0 Fv]
m1 = 0.3;  m2 = 0.1;  l1 = 0.3;  l2 = 0.2;  g0 = 9.8;  Fv = 0.04;
modelParameters = [m1 m2 l1 l2 g0 Fv];

% Initial conditions: q0 puts the tip on the ellipse start point (0.3, 0.2)
q0    = [0; pi/2];
dq0   = [0; 0];
tau_e = [0; 0];

% Ellipse [xc yc mx my f]
ellipse = [0.15 0.2 0.15 0.1 1/3];

% Simulation time (3 cycles)
Tsim = '9';

% Ellipse points for the plot
s = linspace(0, 2*pi, 200);
xref = ellipse(1) + ellipse(3)*cos(s);
yref = ellipse(2) + ellipse(4)*sin(s);

%% P control
Kp = 100;  Kd = 0;
out = sim(modelo, 'StopTime', Tsim);
PlotRobot(out, l1, l2, xref, yref);
outP = out;

%% PD control
Kp = 100;  Kd = 10;
out = sim(modelo, 'StopTime', Tsim);
PlotRobot(out, l1, l2, xref, yref);
outPD = out;

%% Tracking error P vs PD
figure;
hold on;
runs = {outP, outPD};
for r = 1:2
    t = runs{r}.tout;
    q = squeeze(runs{r}.q_data);
    if size(q,1) == 2
        q = q';
    end
    x  = l1*cos(q(:,1)) + l2*cos(q(:,1)+q(:,2));
    y  = l1*sin(q(:,1)) + l2*sin(q(:,1)+q(:,2));
    w  = 2*pi*ellipse(5);
    xd = ellipse(1) + ellipse(3)*cos(w*t);
    yd = ellipse(2) + ellipse(4)*sin(w*t);
    plot(t, sqrt((xd-x).^2 + (yd-y).^2)*1000, 'LineWidth', 1.5);
end
grid on;
xlabel('t [s]');
ylabel('position error [mm]');
legend('P', 'PD');
title('End-effector tracking error');