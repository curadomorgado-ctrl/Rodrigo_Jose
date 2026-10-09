%% test_ex1.m - Testes simbólicos e numéricos, ex 1.1 a 1.3
% Parte 1: expressões simbólicas (letras)
% Parte 2: valores reais do enunciado, em 2 configurações
% Parte 3: validação cruzada com diferenças finitas (independente da derivação à mão)
clear; clc;

%% ===================== PARTE 1: SIMBÓLICO =====================
syms q1 q2 q1dot q2dot m1 m2 l1 l2 lc1 lc2 I1 I2 g_acc real

[x_s, y_s] = forward_kinematics(q1, q2, l1, l2);
Je_s  = jacobian_ee(q1, q2, l1, l2);
Jc1_s = jacobian_cm1(q1, lc1);
Jc2_s = jacobian_cm2(q1, q2, l1, lc2);
Jw1_s = jacobian_w1();
Jw2_s = jacobian_w2();
M_s   = simplify(massmatrix(q1, q2, m1, m2, l1, lc1, lc2, I1, I2));
C_s   = coriolis_matrix(q1, q2, q1dot, q2dot, m1, m2, l1, lc1, lc2, I1, I2);
g_s   = gravity_term(q1, q2, m1, m2, l1, lc1, lc2, g_acc);

disp('--- SIMBOLICO ---')
disp('x ='), disp(x_s)
disp('y ='), disp(y_s)
disp('J_ee ='), disp(Je_s)
disp('J_cm1 ='), disp(Jc1_s)
disp('J_cm2 ='), disp(Jc2_s)
disp('M(q) ='), disp(M_s)
disp('C(q,qdot) ='), disp(C_s)
disp('g(q) ='), disp(g_s)

% Checks de propriedades
disp('M - M.'' (zero => simetrica):'), disp(simplify(M_s - M_s.'))
Mdot = diff(M_s, q1)*q1dot + diff(M_s, q2)*q2dot;
N = Mdot - 2*C_s;
disp('N + N.'' (zero => Mdot-2C antissimetrica):'), disp(simplify(N + N.'))

%% ===================== PARTE 2: NUMÉRICO =====================
% Valores do enunciado (SI)
m1n = 0.3;  m2n = 0.1;
l1n = 0.3;  l2n = 0.2;
lc1n = l1n/2;  lc2n = l2n/2;
I1n = m1n*l1n^2/12;  I2n = m2n*l2n^2/12;
gn  = 9.81;
q1dn = 0.1; q2dn = 0.1;

symvars = [m1 m2 l1 l2 lc1 lc2 I1 I2 g_acc q1dot q2dot];
numvals = [m1n m2n l1n l2n lc1n lc2n I1n I2n gn q1dn q2dn];
evalnum = @(expr, a, b) double(subs(expr, [symvars q1 q2], [numvals a b]));

configs = [pi/3, 5*pi/18;      % A: configuração usada nos testes anteriores
    pi/2, pi/4];        % B: condição inicial q0 do enunciado (ex 1.4)
nomes = {'A: q=[pi/3, 5pi/18]', 'B: q0=[pi/2, pi/4] (enunciado)'};

h = 1e-6;                      % passo das diferenças finitas
tol = 1e-6;

for c = 1:size(configs,1)
    a = configs(c,1);  b = configs(c,2);
    fprintf('\n=========== Config %s ===========\n', nomes{c});
    
    % --- chamadas diretas com números (onde a função aceita) ---
    [x_n, y_n] = forward_kinematics(a, b, l1n, l2n);
    Je_n  = jacobian_ee(a, b, l1n, l2n);
    Jc1_n = jacobian_cm1(a, lc1n);
    Jc2_n = jacobian_cm2(a, b, l1n, lc2n);
    M_n   = massmatrix(a, b, m1n, m2n, l1n, lc1n, lc2n, I1n, I2n);
    
    % --- C e g vêm do simbólico, avaliados com subs (usam diff/jacobian) ---
    C_n = evalnum(C_s, a, b);
    g_n = evalnum(g_s, a, b);
    
    fprintf('(x,y) = (%.6f, %.6f)\n', x_n, y_n);
    disp('J_ee ='), disp(Je_n)
    disp('M ='), disp(M_n)
    disp('C (com qdot=[0.1;0.1]) ='), disp(C_n)
    disp('g ='), disp(g_n)
    
    % Consistência: numérico direto vs simbólico avaliado
    fprintf('|M direto - M simbolico|  = %.2e\n', norm(M_n - evalnum(M_s,a,b)));
    fprintf('|J_ee direto - J_ee simb| = %.2e\n', norm(Je_n - evalnum(Je_s,a,b)));
    
    %% ===================== PARTE 3: DIFERENÇAS FINITAS =====================
    % Posições escritas à parte (independentes dos Jacobianos derivados à mão)
    pee = @(p,q) [l1n*cos(p)+l2n*cos(p+q);  l1n*sin(p)+l2n*sin(p+q)];
    pc1 = @(p,q) [lc1n*cos(p);              lc1n*sin(p)];
    pc2 = @(p,q) [l1n*cos(p)+lc2n*cos(p+q); l1n*sin(p)+lc2n*sin(p+q)];
    fdj = @(pos) [ (pos(a+h,b)-pos(a-h,b))/(2*h), (pos(a,b+h)-pos(a,b-h))/(2*h) ];
    
    fprintf('J_ee  vs dif. finitas: erro = %.2e\n', norm(Je_n  - fdj(pee)));
    fprintf('J_cm1 vs dif. finitas: erro = %.2e\n', norm(Jc1_n - fdj(pc1)));
    fprintf('J_cm2 vs dif. finitas: erro = %.2e\n', norm(Jc2_n - fdj(pc2)));
    
    % g(q) = dU/dq, por diferenças finitas
    Ufun = @(p,q) m1n*gn*lc1n*sin(p) + m2n*gn*(l1n*sin(p)+lc2n*sin(p+q));
    g_fd = [ (Ufun(a+h,b)-Ufun(a-h,b))/(2*h);
        (Ufun(a,b+h)-Ufun(a,b-h))/(2*h) ];
    fprintf('g(q)  vs dif. finitas: erro = %.2e\n', norm(g_n - g_fd));
    
    % Propriedades numéricas
    fprintf('M simetrica? |M-M''| = %.2e ; autovalores de M > 0? %d\n', ...
        norm(M_n - M_n.'), all(eig(M_n) > 0));
    
    ok = norm(Je_n-fdj(pee))<tol && norm(Jc1_n-fdj(pc1))<tol && ...
        norm(Jc2_n-fdj(pc2))<tol && norm(g_n-g_fd)<1e-5;
    if ok, disp('>>> TUDO OK nesta configuracao'); else, disp('>>> ATENCAO: ha erros acima da tolerancia'); end
end