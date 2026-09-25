%% Forward kinematics, ex 1.1
function [x,y]= forward_kinematics (q1,q2,l1,l2)
    x= l1 * cos (q1)+ l2*cos(q1+q2);
    y= l1*sin(q1)+ l2*sin (q1+q2);
end
