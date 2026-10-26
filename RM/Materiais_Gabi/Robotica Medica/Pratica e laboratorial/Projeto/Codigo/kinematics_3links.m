function [X] = kinematics_3links(q,l1,l2,l3)
    x = l1 * cos(q(1)) + l2 * cos(q(1) + q(2)) + l3 * cos(q(1) + q(2) + q(3));
    
    y = l1 * sin(q(1)) + l2 * sin(q(1) + q(2)) + l3 * sin(q(1) + q(2) + q(3));

    X=[x;y];
end