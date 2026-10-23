function M = Ex3_MassMatrix(q, m1, m2, l1, lc1, lc2, I1cxx, I1cyy, I1czz, I2cxx, I2cyy, I2czz)
    q1 = q(1);
    q2 = q(2);
    I1c = [I1cxx 0 0; 0 I1cyy 0; 0 0 I1czz];   % tensores de inercia no centro de massa
    I2c = [I2cxx 0 0; 0 I2cyy 0; 0 0 I2czz];
    Jvc1 = [-lc1*sin(q1) 0; lc1*cos(q1) 0; 0 0];   % Jacobianos dos centros de massa
    Jvc2 = [-l1*sin(q1)-lc2*sin(q1+q2),  -lc2*sin(q1+q2);
             l1*cos(q1)+lc2*cos(q1+q2),   lc2*cos(q1+q2); 0 0];
    Jw1 = [0 0; 0 0; 1 0];
    Jw2 = [0 0; 0 0; 1 1];
    R1 = [cos(q1) -sin(q1) 0; sin(q1) cos(q1) 0; 0 0 1];   % rotacoes em torno de z
    R2 = [cos(q1+q2) -sin(q1+q2) 0; sin(q1+q2) cos(q1+q2) 0; 0 0 1];
    M = m1*(Jvc1'*Jvc1) + Jw1'*R1*I1c*R1'*Jw1 + m2*(Jvc2'*Jvc2) + Jw2'*R2*I2c*R2'*Jw2;
end