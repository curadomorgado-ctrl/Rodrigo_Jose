%% Fixed Values
% --- Physical Parameters -------------------------------------------------
m1 = Simulink.Parameter(0.5);
m2 = Simulink.Parameter(0.2);
l1 = Simulink.Parameter(0.3);
l2 = Simulink.Parameter(0.2);
lc1 = Simulink.Parameter(l1.Value/2);
lc2 = Simulink.Parameter(l2.Value/2);
I1 = Simulink.Parameter( (1/12)*m1.Value*(l1.Value^2) );
I2 = Simulink.Parameter( (1/12)*m2.Value*(l2.Value^2) );
g = Simulink.Parameter(9.81);

%Initial Conditions
Fv= Simulink.Parameter(0.04);
q=[pi/2;pi/4];
dq=[0;0];
Te=[0;0];
Tc=[0;0];

%% Ex 4a
Fv=0.01;
q=[pi/2;pi/4];
dq=[0;0];
load_system('simulator_model.slx');
out = sim('simulator_model.slx','StopTime','5','SrcWorkspace','current');

t = out.tout(:,1);
q1 = out.q_data(1:2:end,1);
q2 = out.q_data(2:2:end,1);

for k = 1:length(t)
    plot_robot([q1(k), q2(k), l1.Value, l2.Value,t(k)]);
    drawnow limitrate;
end
%% Ex 4b
Fv=0.03;
q=[pi/2;pi/4];
dq=[0;0];
load_system('simulator_model.slx');
out = sim('simulator_model.slx','StopTime','5','SrcWorkspace','current');

t = out.tout(:,1);
q1 = out.q_data(1:2:end,1);
q2 = out.q_data(2:2:end,1);

for k = 1:length(t)
    plot_robot([q1(k), q2(k), l1.Value, l2.Value,t(k)]);
    drawnow limitrate;
end
%% Ex 4c
Fv=0.07;
q=[pi/2;pi/4];
dq=[0;0];
load_system('simulator_model.slx');
out = sim('simulator_model.slx','StopTime','5','SrcWorkspace','current');

t = out.tout(:,1);
q1 = out.q_data(1:2:end,1);
q2 = out.q_data(2:2:end,1);

for k = 1:length(t)
    plot_robot([q1(k), q2(k), l1.Value, l2.Value,t(k)]);
    drawnow limitrate;
end
%% Ex 4d
Fv=0.1;
q=[pi/2;pi/4];
dq=[0;0];
load_system('simulator_model.slx');
out = sim('simulator_model.slx','StopTime','5','SrcWorkspace','current');
t = out.tout(:,1);
q1 = out.q_data(1:2:end,1);
q2 = out.q_data(2:2:end,1);

for k = 1:length(t)
    plot_robot([q1(k), q2(k), l1.Value, l2.Value,t(k)]);
    drawnow limitrate;
end
%% Ex 4e
Fv=0.04;
q=[0;0];
dq=[0;0];
load_system('simulator_model.slx');
out = sim('simulator_model.slx','StopTime','5','SrcWorkspace','current');
t = out.tout(:,1);
q1 = out.q_data(1:2:end,1);
q2 = out.q_data(2:2:end,1);

for k = 1:length(t)
    plot_robot([q1(k), q2(k), l1.Value, l2.Value,t(k)]);
    drawnow limitrate;
end
%% Ex 4f
Fv=0.04;
q=[pi/2;pi/4];
dq=[pi;pi];
load_system('simulator_model.slx');
out = sim('simulator_model.slx','StopTime','5','SrcWorkspace','current');
t = out.tout(:,1);
q1 = out.q_data(1:2:end,1);
q2 = out.q_data(2:2:end,1);

for k = 1:length(t)
    plot_robot([q1(k), q2(k), l1.Value, l2.Value,t(k)]);
    drawnow limitrate;
end
%% Ex 5 
Fv=0.04;
q=[pi/2;pi/4];
dq=[0;0];
load_system('simulator_model_G.slx');
out = sim('simulator_model_G.slx','StopTime','5','SrcWorkspace','current');
t = out.tout(:,1);
q1 = out.q_data(1:2:end,1);
q2 = out.q_data(2:2:end,1);

for k = 1:length(t)
    plot_robot([q1(k), q2(k), l1.Value, l2.Value,t(k)]);
    drawnow limitrate;
end

%% Ex 6a
Fc=[0;-10];
Fv=0.04;
q=[pi/2;pi/4];
dq=[0;0];
load_system('simulator_model_Fc.slx');
out = sim('simulator_model_Fc.slx','StopTime','10','SrcWorkspace','current');
t = out.tout(:,1);
q1 = out.q_data(1:2:end,1);
q2 = out.q_data(2:2:end,1);

for k = 1:length(t)
    plot_robot([q1(k), q2(k), l1.Value, l2.Value,t(k)]);
    drawnow limitrate;
end

%% Ex 6b
Fc=[10; 0];
Fv=0.04;
q=[pi/2;pi/4];
dq=[0;0];
load_system('simulator_model_Fc.slx');
out = sim('simulator_model_Fc.slx','StopTime','10','SrcWorkspace','current');
t = out.tout(:,1);
q1 = out.q_data(1:2:end,1);
q2 = out.q_data(2:2:end,1);

for k = 1:length(t)
    plot_robot([q1(k), q2(k), l1.Value, l2.Value,t(k)]);
    drawnow limitrate;
end

%% Ex 6c
Fc=[10;-10];
Fv=0.04;
q=[pi/2;pi/4];
dq=[0;0];
load_system('simulator_model_Fc.slx');
out = sim('simulator_model_Fc.slx','StopTime','10','SrcWorkspace','current');
t = out.tout(:,1);
q1 = out.q_data(1:2:end,1);
q2 = out.q_data(2:2:end,1);

for k = 1:length(t)
    plot_robot([q1(k), q2(k), l1.Value, l2.Value,t(k)]);
    drawnow limitrate;
end

%% 7a
Fv=0.04;
mx=0.15;
my=0.1;
f=1/4;
px=0.21;
py=0.24;
q=[pi/2;pi/4];
dq=[0;0];

Kp = 45;
Kd = 0;
mode = Simulink.Parameter(2);
load_system('simulator_model_controller_NE.slx');
out = sim('simulator_model_controller_NE.slx','StopTime','10','SrcWorkspace','current');
t = out.tout(:,1);
q1 = out.q_data(1:2:end,1);
q2 = out.q_data(2:2:end,1);
xe=out.error_data(1:2:end,1);
ye=out.error_data(2:2:end,1);
for k = 1:length(t)
    plot_robot([q1(k), q2(k), l1.Value, l2.Value,t(k),xe(k),ye(k)],mode.Value);
    drawnow limitrate;
end
%% 7b
Fv=0.04;
mx=0.15;
my=0.1;
f=1/4;
px=0.21;
py=0.24;
q=[pi/2;pi/4];
dq=[0;0];

Kp = 2000;
Kd = sqrt(Kp/3)*3;
mode = Simulink.Parameter(2);
load_system('simulator_model_controller_NE.slx');
out = sim('simulator_model_controller_NE.slx','StopTime','10','SrcWorkspace','current');
t = out.tout(:,1);
q1 = out.q_data(1:2:end,1);
q2 = out.q_data(2:2:end,1);
xe=out.error_data(1:2:end,1);
ye=out.error_data(2:2:end,1);
for k = 1:length(t)
    plot_robot([q1(k), q2(k), l1.Value, l2.Value,t(k),xe(k),ye(k)],mode.Value);
    drawnow limitrate;
end

%% 7c
Fv=0.04;
mx=0;
my=0.15;
f=1/4;
px=0.21;
py=0.24;
q=[pi/2;pi/4];
dq=[0;0];

Kp = 750;
Kd = 0;
mode = Simulink.Parameter(3);
load_system('simulator_model_controller_NE.slx');
out = sim('simulator_model_controller_NE.slx','StopTime','10','SrcWorkspace','current');
t = out.tout(:,1);
q1 = out.q_data(1:2:end,1);
q2 = out.q_data(2:2:end,1);
xe=out.error_data(1:2:end,1);
ye=out.error_data(2:2:end,1);
for k = 1:length(t)
    plot_robot([q1(k), q2(k), l1.Value, l2.Value,t(k),xe(k),ye(k)],mode.Value);
    drawnow limitrate;
end

%% 7d
Fv=0.04;
mx=0;
my=0.1;
f=1/4;
px=0.21;
py=0.24;
q=[pi/2;pi/4];
dq=[0;0];

Kp = 2000;
Kd = sqrt(Kp/3)*3;
mode = Simulink.Parameter(3);
load_system('simulator_model_controller_NE.slx');
out = sim('simulator_model_controller_NE.slx','StopTime','10','SrcWorkspace','current');
t = out.tout(:,1);
q1 = out.q_data(1:2:end,1);
q2 = out.q_data(2:2:end,1);
xe=out.error_data(1:2:end,1);
ye=out.error_data(2:2:end,1);
for k = 1:length(t)
    plot_robot([q1(k), q2(k), l1.Value, l2.Value,t(k),xe(k),ye(k)],mode.Value);
    drawnow limitrate;
end
%% 7e
Fv=0.04;
mx=0.2;
my=0.1;
f=1/4;
px=0.41;
py=0.31;
q=[pi/2;pi/4];
dq=[0;0];

Kp = 2;
Kd = sqrt(Kp/3)*3;
mode = Simulink.Parameter(2);
load_system('simulator_model_controller_NE.slx');
out = sim('simulator_model_controller_NE.slx','StopTime','12.44','SrcWorkspace','current');
t = out.tout(:,1);
q1 = out.q_data(1:2:end,1);
q2 = out.q_data(2:2:end,1);
xe=out.error_data(1:2:end,1);
ye=out.error_data(2:2:end,1);
for k = 1:length(t)
    plot_robot([q1(k), q2(k), l1.Value, l2.Value,t(k),xe(k),ye(k)],mode.Value);
    drawnow limitrate;
end

%% 8a (Compliant design)
Fv=0.04;
Kp = 1000;
Kd = sqrt(Kp/3)*3;
q=[pi/2;pi/4];
dq=[0;0];

Ks = 2500;
Fc = Simulink.Parameter([250; 0]);
Xe = Simulink.Parameter([0.25 ; 0.2]);
kp = Simulink.Parameter([0 0 ; 0 Kp]);
ke = Simulink.Parameter([Ks 0 ; 0 0]);

mode = Simulink.Parameter(4);
load_system('simulator_model_controller_compliance1.slx');
out = sim('simulator_model_controller_compliance1.slx','StopTime','5','SrcWorkspace','current');
t = out.tout(:,1);
q1 = out.q_data(1:2:end,1);
q2 = out.q_data(2:2:end,1);
xe=out.error_data(1:2:end,1);
ye=out.error_data(2:2:end,1);
for k = 1:length(t)
    plot_robot([q1(k), q2(k), l1.Value, l2.Value,t(k),xe(k),ye(k)],mode.Value);
    drawnow limitrate;
end
%% 8b (Stiff design)
Fv=0.04;
q=[pi/2;pi/4];
dq=[0;0];
Kp = 10000;
Kd = sqrt(Kp/3)*3;

Ks = 2500;
Fc = Simulink.Parameter([250; 0]);
Xe = Simulink.Parameter([0.25 ; 0.2]);
kp = Simulink.Parameter([0 0 ; 0 Kp]);
ke = Simulink.Parameter([Ks 0 ; 0 0]);

mode = Simulink.Parameter(4);
load_system('simulator_model_controller_compliance1.slx');
out = sim('simulator_model_controller_compliance1.slx','StopTime','5','SrcWorkspace','current');
t = out.tout(:,1);
q1 = out.q_data(1:2:end,1);
q2 = out.q_data(2:2:end,1);
xe=out.error_data(1:2:end,1);
ye=out.error_data(2:2:end,1);
for k = 1:length(t)
    plot_robot([q1(k), q2(k), l1.Value, l2.Value,t(k),xe(k),ye(k)],mode.Value);
    drawnow limitrate;
end

%% 9
Fv=0.04;
q=[pi/2;pi/4];
dq=[0;0];

K = 1000;
kp = Simulink.Parameter([0 0 ; 0 10000]);
D = sqrt(10000/3)*3;
Dd = Simulink.Parameter([D 0 ; 0 D]);

Ks = 2500;
ke = Simulink.Parameter([Ks 0 ; 0 Ks]);
Fc = Simulink.Parameter([0; 0]);
Xe = Simulink.Parameter([0.2 ; -0.2]);

mode = Simulink.Parameter(5);
load_system('simulator_model_controller_impedance3.slx');
out = sim('simulator_model_controller_impedance3.slx','StopTime','10','SrcWorkspace','current');

t = out.tout(:,1);
q1 = out.q_data(1:2:end,1);
q2 = out.q_data(2:2:end,1);
xe=out.error_data(1:2:end,1);
ye=out.error_data(2:2:end,1);
for k = 1:length(t)
    plot_robot([q1(k), q2(k), l1.Value, l2.Value,t(k),xe(k),ye(k)],mode.Value);
    drawnow limitrate;
end
%% 10
l1=Simulink.Parameter(1);
l2=Simulink.Parameter(1);
l3=Simulink.Parameter(0.3);
qi = [pi/12; pi/3; pi/3];

Kp= 10;
Kq= 10;

%qdp= [pi/2; -pi/2; -pi/2];
qdp= [80*pi/180; -160*pi/180; 80*pi/180];

load_system('robot_trajectory_control.slx');
out = sim('robot_trajectory_control.slx','StopTime','20','SrcWorkspace','current');
t = out.tout(:,1);
q1 = out.q_data(1:3:end,1);
q2 = out.q_data(2:3:end,1);
q3 = out.q_data(3:3:end,1);

for k = 1:length(t)
    plot_robot_3links([q1(k), q2(k), q3(k), l1.Value, l2.Value, l3.Value, t(k)]);
    drawnow limitrate;
end
