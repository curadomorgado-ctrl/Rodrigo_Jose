function [M] = forward_kinematics(q1,q2,l1,l2)
    
    xt = l1*cos(q1) + l2*cos(q1+q2); 
    yt = l1*sin(q1) + l2*sin(q1+q2);
    M = [xt; yt]; 
end
