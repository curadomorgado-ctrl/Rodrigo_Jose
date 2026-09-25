%% Test
[x,y] = forward_kinematics(pi/3, (5*pi/18), 0.3, 0.2);
%% Test jacobian ee
J=jacobian_ee(pi/3, (5*pi/18), 0.3, 0.2);
%% Test jacobian linear cm1
J_cm1=jacobian_cm1(pi/3, 0.15);
%% Test jacobian linear cm2
J_cm2=jacobian_cm2(pi/3, (5*pi/18), 0.3, 0.1);
%% Test jacobian angular cm1
J_cm1_w=jacobian_cm1_w;
%% Test jacobian angular cm2
J_cm2_w=jacobian_cm2_w;