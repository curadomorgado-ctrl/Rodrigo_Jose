function PlotRobot(out, l1, l2, xref, yref)
% Animates the 2-link robot in real time and plots q1 and q2 over time.
% PlotRobot(out, l1, l2)             -> robot only
% PlotRobot(out, l1, l2, xref, yref) -> robot + reference path (dashed green)
% The Simulink model needs a To Workspace block on q named q_data.

if nargin < 4                  % no reference path given
    xref = [];
    yref = [];
end

% Time and joint angles from the simulation
t = out.tout;
q = squeeze(out.q_data);
if size(q,1) == 2              % make it N x 2
    q = q';
end
q1 = q(:,1);
q2 = q(:,2);

% Forward kinematics
x1 = l1*cos(q1);               % elbow
y1 = l1*sin(q1);
x2 = x1 + l2*cos(q1+q2);       % end-effector
y2 = y1 + l2*sin(q1+q2);
xc = [l1/2*cos(q1), x1 + l2/2*cos(q1+q2)];   % centres of mass
yc = [l1/2*sin(q1), y1 + l2/2*sin(q1+q2)];

close all;
figure('Position', [100 100 1100 450]);

% Left: robot
subplot(1, 2, 1);
plot(xref, yref, 'g--', 'LineWidth', 1.5);    % reference path
hold on;
path = plot(x2(1), y2(1), ':', 'Color', [0.3 0.75 0.93], 'LineWidth', 2);
arm  = plot([0 x1(1) x2(1)], [0 y1(1) y2(1)], 'k-o', 'LineWidth', 3, 'MarkerSize', 8, 'MarkerFaceColor', 'w');
tip  = plot(x2(1), y2(1), 'mo', 'MarkerSize', 10, 'MarkerFaceColor', 'm');
cm   = plot(xc(1,:), yc(1,:), 'o', 'MarkerSize', 6, 'Color', [0.55 0.27 0.07], 'MarkerFaceColor', [0.55 0.27 0.07]);
axis([-0.55 0.55 -0.55 0.55]);
axis square;
grid on;
xlabel('x [m]');
ylabel('y [m]');
ttl = title('t = 0.00 s');

% Right: joint angles
subplot(1, 2, 2);
line1 = plot(t(1), q1(1), 'LineWidth', 1.5);
hold on;
line2 = plot(t(1), q2(1), 'LineWidth', 1.5);
axis([0 t(end) min([q1; q2])-0.2 max([q1; q2])+0.2]);
grid on;
xlabel('t [s]');
ylabel('q [rad]');
legend('q_1', 'q_2');
title('Joint angles');

% Show the initial position for 2 s
drawnow;
pause(2);

% Real-time animation
tic;
while toc < t(end)
    k = find(t <= toc, 1, 'last');     % sample at the current real time
    set(arm,   'XData', [0 x1(k) x2(k)], 'YData', [0 y1(k) y2(k)]);
    set(tip,   'XData', x2(k),   'YData', y2(k));
    set(cm,    'XData', xc(k,:), 'YData', yc(k,:));
    set(path,  'XData', x2(1:k), 'YData', y2(1:k));
    set(line1, 'XData', t(1:k),  'YData', q1(1:k));
    set(line2, 'XData', t(1:k),  'YData', q2(1:k));
    set(ttl,   'String', ['t = ' num2str(t(k), '%.2f') ' s']);
    drawnow;
end
end