classdef Jacobian
    methods(Static)

        function [Jv] = linear_jacobian(q1,q2,l1,l2)
    Jv = [-l1*sin(q1)-l2*sin(q1+q2), -l2*sin(q1+q2);
           l1*cos(q1)+l2*cos(q1+q2),  l2*cos(q1+q2)];
end

        function [Jw] = angular_jacobian()
    Jw = [0, 0;
          0, 0; 
          1, 1]; 
end

        function [Jvc1]= linear_jacobianc1(q1,lc1)
    Jvc1 = [-lc1*sin(q1) 0; lc1*cos(q1) 0];
end

        function [Jvc2]= linear_jacobianc2(q1,q2,l1,lc2)
    Jvc2 = [-l1*sin(q1)-lc2*sin(q1+q2),  -lc2*sin(q1+q2); 
         l1*cos(q1)+lc2*cos(q1+q2),   lc2*cos(q1+q2)];
end

        function [Jwc1]= angular_jacobianc1()
    Jwc1=[0 0;0 0;1 0];
end

        function [Jwc2]= angular_jacobianc2()
   Jwc2=[0 0;0 0;1 1];
end

        function [M] = differential_kinematics(q1,q2,dq1,dq2,l1,l2)
            dxt = -l1*sin(q1)*dq1 - l2*sin(q1+q2)*(dq1+dq2); 
            dyt = l1*cos(q1)*dq1 + l2*cos(q1+q2)*(dq1+dq2);
            M = [dxt; dyt]; 
        end
        function [dJ] = differential_jacobian(q1,q2,dq1,dq2,l1,l2)
            dJ = [-dq1*(l2*cos(q1 + q2) + l1*cos(q1)) - dq2*l2*cos(q1 + q2),  -l2*cos(q1 + q2)*(dq1 + dq2);
                    -dq1*(l2*sin(q1 + q2) + l1*sin(q1)) - dq2*l2*sin(q1 + q2),  -l2*sin(q1 + q2)*(dq1 + dq2)];

        end
        
    end
end