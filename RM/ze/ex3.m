%% traj3links.m - Secção 3 do projeto: trajetória de juntas, robô de 3 elos
% Método (slides 177 a 190):
%   dXd = Kp*(Xd - X)                         erro cartesiano -> velocidade desejada
%   dq0 = Kq*(qdp - q)                        espaço nulo: apontar para a postura qdp
%   dqd = pinv(J)*dXd + (I - pinv(J)*J)*dq0   (4.63), com J# = J'*inv(J*J')
% Calculado em 2 passos (4.68-4.71), o que permite a versão amortecida (ka > 0)
% perto de singularidades. Sem dinâmica: só cinemática + integração (Euler).
%
% Corre com:  traj3links     (precisa de MATLAB R2018b ou mais recente (funcoes locais, yline),
% por exemplo)
clear; clc; close all;

%% ===== PARÂMETROS (edita aqui) =====
l  = [1; 1; 0.3];                 % comprimentos dos elos [m] (enunciado)
qi = [pi/12; pi/3; pi/3];         % configuração inicial (4.57)

Kp = 10;                          % ganho da tarefa (slides: 10)
T  = 2;                           % duração [s] (slides: 2 s)
dt = 1e-3;                        % passo de integração [s]

% Reta da tarefa médica: vertical em x = 1.5, a descer.
% ATENÇÃO: os valores de y são ESTIMATIVAS minhas a partir da figura do enunciado.
xline_ = 1.5;  ys = 0.9;  ye = -0.6;

% Área vital (círculo). ATENÇÃO: centro e raio são ESTIMATIVAS minhas a partir da
% figura. O enunciado não dá coordenadas. Ajusta quando as souberes.
cv = [0.5; -0.5];  rv = 0.35;

% Amortecimento perto de singularidades (4.70-4.72). Com use_damping=false, ka = 0.
use_damping = false;  beta0 = 0.2;  w0 = 0.03;

% Casos a comparar (acrescenta linhas para testar outras posturas / ganhos)
cases = struct( ...
  'name', {'Kq=0 (sem espaco nulo)', 'Kq=10, qdp=[80 -160 80] graus', 'Kq=10, qdp=[90 -90 -90] graus'}, ...
  'Kq',   {0,                         10,                              10}, ...
  'qdp',  {zeros(3,1),                [80;-160;80]*pi/180,             [pi/2;-pi/2;-pi/2]});

%% ===== SIMULAÇÃO =====
N = round(T/dt);
nc = numel(cases);
R = cell(1, nc);
for c = 1:nc
    Kq = cases(c).Kq;  qdp = cases(c).qdp;
    q = qi;
    t  = zeros(1,N+1);  Q = zeros(3,N+1);  X = zeros(2,N+1);  Xd = zeros(2,N+1);
    manip = zeros(1,N+1);  dmin = zeros(1,N+1);
    for k = 1:N+1
        t(k) = (k-1)*dt;
        xd = [xline_; ys + (ye-ys)*min(t(k)/T, 1)];   % referência: reta a descer
        x  = fk3(q, l);
        J  = jac3(q, l);

        dXd = Kp*(xd - x);                            % (4.61)
        dq0 = Kq*(qdp - q);                           % (4.62)

        w  = sqrt(det(J*J'));                         % manipulabilidade (distância à singularidade)
        ka = 0;
        if use_damping && w < w0, ka = beta0*(1 - w/w0)^2; end   % (4.72)
        alpha = (J*J' + ka*eye(2)) \ (dXd - J*dq0);   % (4.68)/(4.70)
        dq    = J'*alpha + dq0;                       % (4.69)/(4.71)  == (4.63) se ka = 0

        Q(:,k) = q;  X(:,k) = x;  Xd(:,k) = xd;  manip(k) = w;
        dmin(k) = min_dist_circle(q, l, cv, rv);

        q = q + dq*dt;                                % integração de Euler
    end
    R{c} = struct('t',t,'Q',Q,'X',X,'Xd',Xd,'manip',manip,'dmin',dmin);
end

%% ===== RESULTADOS NUMÉRICOS =====
fprintf('\nPonta inicial: (%.4f, %.4f) m\n', R{1}.X(1,1), R{1}.X(2,1));
fprintf('%-34s %-10s %-10s %-12s %-14s\n','caso','erro fin.','manip.min','dist.min','q final [graus]');
for c = 1:nc
    r = R{c};
    errf = norm(r.Xd(:,end) - r.X(:,end));
    fprintf('%-34s %-10.3f %-10.3f %-12.3f %s\n', cases(c).name, errf, min(r.manip), min(r.dmin), ...
            mat2str(round(rad2deg(r.Q(:,end))',1)));
end
fprintf('(dist.min < 0 => algum elo entra na area vital)\n');
fprintf('Nota: com rampa, o erro final esperado ~ (velocidade de Xd)/Kp = %.3f m\n', abs(ye-ys)/T/Kp);

%% ===== FIGURAS =====
% 1) Braço em 3 instantes, por caso
figure('Name','Braco em t = 0, T/2, T','Position',[50 50 1200 380]);
for c = 1:nc
    subplot(1,nc,c); hold on; axis equal; grid on
    draw_scene(cv, rv, xline_, ys, ye);
    for kk = [1, round(N/2)+1, N+1]
        P = arm_points(R{c}.Q(:,kk), l);
        plot(P(1,:), P(2,:), 'o-', 'LineWidth', 2);
    end
    plot(R{c}.X(1,:), R{c}.X(2,:), 'k--');
    title(cases(c).name, 'Interpreter','none'); xlabel('x [m]'); ylabel('y [m]');
end

% 2) Juntas, erro, manipulabilidade e distância
figure('Name','Resultados no tempo','Position',[50 450 1200 500]);
for c = 1:nc
    subplot(2,nc,c); plot(R{c}.t, rad2deg(R{c}.Q')); grid on
    title(cases(c).name,'Interpreter','none'); xlabel('t [s]'); ylabel('q [graus]');
    if c == 1, legend('q_1','q_2','q_3'); end
end
subplot(2,nc,nc+1); hold on; grid on
for c = 1:nc, plot(R{c}.t, vecnorm(R{c}.Xd - R{c}.X)); end
xlabel('t [s]'); ylabel('|erro da ponta| [m]'); legend({cases.name},'Interpreter','none');
subplot(2,nc,nc+2); hold on; grid on
for c = 1:nc, plot(R{c}.t, R{c}.manip); end
xlabel('t [s]'); ylabel('sqrt(det(J J^T))');
subplot(2,nc,nc+3); hold on; grid on
for c = 1:nc, plot(R{c}.t, R{c}.dmin); end
yline(0,'r--'); xlabel('t [s]'); ylabel('dist. elos - area vital [m]');

%% ===== FUNÇÕES LOCAIS =====
function X = fk3(q, l)                      % cinemática direta (4.58)
    a = cumsum(q);
    X = [sum(l.*cos(a)); sum(l.*sin(a))];
end

function J = jac3(q, l)                     % Jacobiano 2x3 (4.60)
    a = cumsum(q);  J = zeros(2,3);
    for j = 1:3
        J(1,j) = -sum(l(j:end).*sin(a(j:end)));
        J(2,j) =  sum(l(j:end).*cos(a(j:end)));
    end
end

function P = arm_points(q, l)               % base, cotovelo, pulso, ponta (colunas)
    a = cumsum(q);
    P = [0; 0];
    for j = 1:3
        P = [P, P(:,end) + l(j)*[cos(a(j)); sin(a(j))]]; %#ok<AGROW>
    end
end

function d = min_dist_circle(q, l, c, r)    % menor distância elos -> círculo (neg. = dentro)
    P = arm_points(q, l);  d = inf;
    for s = 1:3
        A = P(:,s);  B = P(:,s+1);  AB = B - A;
        tt = max(0, min(1, dot(c - A, AB)/dot(AB, AB)));
        d = min(d, norm(c - (A + tt*AB)) - r);
    end
end

function draw_scene(c, r, xl, ys, ye)
    rectangle('Position',[c(1)-r c(2)-r 2*r 2*r],'Curvature',[1 1],'FaceColor',[0.6 0 0],'EdgeColor','none');
    plot([xl xl],[ys ye],'m-','LineWidth',1.5);
    axis([-0.5 2.4 -1.5 2.4]);
end