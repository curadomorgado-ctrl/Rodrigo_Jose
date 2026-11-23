function PlotPoses3(out, L, qdp, dt)
% Draws the 3-link robot every dt seconds, one by one in real time.
% First pose blue, last pose red, the others green (like the slides).
% The desired posture qdp is drawn in black (not drawn if qdp is zero).
% The model needs a To Workspace block on q named q_data.

% Vital area (edit here)
xc = 0.53;   yc = -0.55;    % centre [m]
D  = 0.7;                   % diameter [m]

q = squeeze(out.q_data);
if size(q,1) == 3           % make it N x 3
    q = q';
end
t = out.tout;

close all;
figure;
hold on;
s = linspace(0, 2*pi, 100);
fill(xc + D/2*cos(s), yc + D/2*sin(s), [0.55 0 0]);   % vital area
axis([-1 2.5 -1.5 2]);
axis equal;
grid on;
xlabel('x [m]');
ylabel('y [m]');

% Desired posture qdp (black)
if any(qdp)
    a = cumsum(qdp);
    x = cumsum([0, L(1)*cos(a(1)), L(2)*cos(a(2)), L(3)*cos(a(3))]);
    y = cumsum([0, L(1)*sin(a(1)), L(2)*sin(a(2)), L(3)*sin(a(3))]);
    plot(x, y, 'k', 'LineWidth', 1.5);
end

tk = 0:dt:t(end);           % instants to draw
n  = length(tk);

for j = 1:n
    i = find(t >= tk(j), 1);   % sample closest to that instant

    % Joint and end-effector positions
    a = cumsum(q(i,:));
    x = cumsum([0, L(1)*cos(a(1)), L(2)*cos(a(2)), L(3)*cos(a(3))]);
    y = cumsum([0, L(1)*sin(a(1)), L(2)*sin(a(2)), L(3)*sin(a(3))]);

    if j == 1
        plot(x, y, 'b', 'LineWidth', 2);       % initial pose
        title('t = 0.00 s');
        drawnow;
        pause(2);                              % wait before starting
        tic;
    else
        while toc < t(i)                       % wait for the real time
        end
        if j == n
            plot(x, y, 'r', 'LineWidth', 2);   % final pose
        else
            plot(x, y, 'g');                   % intermediate poses
        end
        title(['t = ' num2str(t(i), '%.2f') ' s']);
        drawnow;
    end
end
end