
function [x, y, phi] = ForwardKinematics(q, l1, l2) % robots with 2 links
    q1 = q(1); q2 = q(2);   % Joint angles
    phi = q1 + q2;

    x = l1*cos(q1) + l2*cos(q1 + q2);    % Forward kinematics
    y = l1*sin(q1) + l2*sin(q1 + q2);    % Joint Vector cartesian coordinates
end
