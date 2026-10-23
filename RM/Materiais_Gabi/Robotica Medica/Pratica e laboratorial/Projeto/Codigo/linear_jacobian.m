function [Jv] = linear_jacobian(q1,q2,l1,l2)
    Jv = [-l1*sin(q1)-l2*sin(q1+q2), -l2*sin(q1+q2);
           l1*cos(q1)+l2*cos(q1+q2),  l2*cos(q1+q2)];
end