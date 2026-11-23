function [Jv_ee, Jv_c1, Jv_c2, Jw_ee, Jw_c1, Jw_c2] = Gr2_Ex2_AI_Tool_Jacobians(q, l1, l2, lc1, lc2)
% Linear (Jv) and angular (Jw) Jacobians of a 2-link planar robot,
% referred to the end-effector and to the centre of mass of each link.
% q = [q1; q2] (rad), l1, l2 (m). Centres of mass at lci = li/2.

s1  = sin(q(1));        c1  = cos(q(1));
s12 = sin(q(1) + q(2)); c12 = cos(q(1) + q(2));

% Linear Jacobians (3x2)
Jv_ee = [-l1*s1 - l2*s12,  -l2*s12;
          l1*c1 + l2*c12,   l2*c12]

Jv_c1 = [-lc1*s1, 0;
          lc1*c1, 0];

Jv_c2 = [-l1*s1 - lc2*s12, -lc2*s12;
          l1*c1 + lc2*c12,  lc2*c12];

% Angular Jacobians (3x2), rotation about z
Jw_c1 = [1 0];
Jw_c2 = [1 1];
Jw_ee = Jw_c2;
end
