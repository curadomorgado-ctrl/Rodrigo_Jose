%% Forward kinematics, ex 1.1
%
% Question this answers: "given the joint angles, where is the tip
% of the arm (end-effector)?"
%
% Geometry: link 1 has length l1 and makes angle q1 with the horizontal
% (measured from the base, x0 axis). Its tip would be at:
%   x = l1*cos(q1), y = l1*sin(q1)   (basic right-triangle trig)
%
% Link 2 hangs off the tip of link 1. Its angle q2 is measured
% relative to link 1 (not relative to the horizontal) -> so, relative
% to the base, link 2 actually points in direction (q1+q2) -> the two
% joint angles add up.
%
% End-effector position = walk along link 1, then walk along link 2
% (in its true direction q1+q2):
%   x = l1*cos(q1) + l2*cos(q1+q2)
%   y = l1*sin(q1) + l2*sin(q1+q2)
%
% This is the foundation for everything else in the project: the
% Jacobians (ex 1.2) and the dynamics (ex 1.3) both build on top of
% this forward kinematics relationship.

function [x,y]= forward_kinematics (q1,q2,l1,l2)
    x= l1 * cos (q1)+ l2*cos(q1+q2);
    y= l1*sin(q1)+ l2*sin (q1+q2);
end