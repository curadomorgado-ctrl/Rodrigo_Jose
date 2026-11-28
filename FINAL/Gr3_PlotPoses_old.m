function PlotPoses3(out, L, n)
% Draws the 3-link robot at several instants in the same figure, one by
% one in real time (like the course slides): first pose blue,
% last pose red, others green.
% PlotPoses3(out, L, n)
%   L -> link lengths [l1 l2 l3]
%   n -> number of poses to draw (e.g. 15)

q = squeeze(out.q_data);
if size(q,1) == 3              % make it N x 3
    q = q';
end
t = out.tout;

close all;
figure;
hold on;
s = linspace(0, 2*pi, 100);
fill(0.55 + 0.35*cos(s), -0.6 + 0.35*sin(s), [0.55 0 0]);   % vital area
axis([-1 2.5 -1.5 2]);
axis equal;
grid on;
xlabel('x [m]');
ylabel('y [m]');

k = round(linspace(1, length(t), n));      % instants to draw

for i = k
    % Wait until the real time reaches this instant
    if i == k(1)
        tic;
    end
    while toc < t(i)
    end

    a1 = q(i,1);
    a2 = q(i,1) + q(i,2);
    a3 = q(i,1) + q(i,2) + q(i,3);
    x = [0, L(1)*cos(a1), L(1)*cos(a1)+L(2)*cos(a2), L(1)*cos(a1)+L(2)*cos(a2)+L(3)*cos(a3)];
    y = [0, L(1)*sin(a1), L(1)*sin(a1)+L(2)*sin(a2), L(1)*sin(a1)+L(2)*sin(a2)+L(3)*sin(a3)];

    if i == k(1)
        plot(x, y, 'b', 'LineWidth', 2);   % initial pose
    elseif i == k(end)
        plot(x, y, 'r', 'LineWidth', 2);   % final pose
    else
        plot(x, y, 'g');                   % intermediate poses
    end
    title(['t = ' num2str(t(i), '%.2f') ' s']);
    drawnow;

    % Show the initial pose for 2 s before starting
    if i == k(1)
        pause(2);
        tic;
    end
end
end