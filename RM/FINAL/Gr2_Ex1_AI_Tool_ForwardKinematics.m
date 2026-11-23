function p = Gr2_Ex1_AI_Tool_ForwardKinematics(q, l1, l2)
% Forward kinematics of a 2-link planar robot.
% q = [q1; q2] (rad), l1, l2 (m). Returns end-effector position p = [x; y].

x = l1*cos(q(1)) + l2*cos(q(1) + q(2));
y = l1*sin(q(1)) + l2*sin(q(1) + q(2));
p = [x, y];
end
