
function MassSymbolic = Ex3_MassMatrix_Symbolic(q, dq, m1, m2, l1, lc1, lc2, I1cxx, I1cyy, I1czz, I2cxx, I2cyy, I2czz)
    % function created from matlab script: "MassComputation2LinkRobot.m"

    q1 = q(1);
    q2 = q(2);

    dq1 = dq(1);
    dq2 = dq(2);

    I1c = [I1cxx 0 0;0 I1cyy 0; 0 0 I1czz]; % Inertia tensors referred to the center of mass
    I2c = [I2cxx 0 0;0 I2cyy 0; 0 0 I2czz];
    
    Jvc1 = [-lc1*sin(q1) 0; lc1*cos(q1) 0;0 0];     % Jacobians referred to the center of mass
    Jvc2 = [-l1*sin(q1)-lc2*sin(q1+q2),  -lc2*sin(q1+q2); 
             l1*cos(q1)+lc2*cos(q1+q2),   lc2*cos(q1+q2); 0 0];
        
    Jw1=[0 0;0 0;1 0];
    Jw2=[0 0;0 0;1 1];
        
    R1=[cos(q1) -sin(q1) 0; sin(q1) cos(q1) 0; 0 0 1]; % rotation matrices associated to each coordinate frame (rotation along z)
    R2=[cos(q1+q2) -sin(q1+q2) 0; sin(q1+q2) cos(q1+q2) 0; 0 0 1];
        
    MassSymbolic = simplify(m1*Jvc1'*Jvc1 +Jw1'*R1*I1c*R1'*Jw1  +m2*Jvc2'*Jvc2  + Jw2'*R2*I2c*R2'*Jw2);
end
