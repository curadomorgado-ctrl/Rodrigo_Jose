function plot_robot_3links(inputs)
    q1 = inputs(1);
    q2 = inputs(2);
    q3 = inputs(3);
    l1 = inputs(4);
    l2 = inputs(5);
    l3 = inputs(6);
    t  = inputs(7);
    
    
    P0 = [0; 0];
    P1 = [ l1*cos(q1);
           l1*sin(q1) ];
    P2 = [ l1*cos(q1) + l2*cos(q1+q2);
           l1*sin(q1) + l2*sin(q1+q2) ];
    P3 = [ l1*cos(q1) + l2*cos(q1+q2) + l3*cos(q1+q2+q3);
           l1*sin(q1) + l2*sin(q1+q2) + l3*sin(q1+q2+q3) ];
    X_coords = [P0(1), P1(1), P2(1), P3(1)];
    Y_coords = [P0(2), P1(2), P2(2), P3(2)];
    
    
    persistent fig_handle traj link_handle ee_handle ...
               q1_line q2_line q3_line vert_handle circle_handle
               
   
    xv = 1.5;
    Ay = 1.2;
    phi = linspace(0,2*pi,200);
    y_vert = Ay * sin(phi);
    x_vert = xv * ones(size(y_vert));
    
   
    Rc = 0.35;
    xc = 0.55;
    yc = -0.60;
    phi_c = linspace(0,2*pi,200);
    x_circle = xc + Rc*cos(phi_c);
    y_circle = yc + Rc*sin(phi_c);
    
    % ----- Criar figura -----
    if isempty(fig_handle) || ~isvalid(fig_handle)
        fig_handle = figure(1); clf;
        set(fig_handle, 'Position', [100 100 1200 500]);
        
      
        subplot(1,2,1); hold on;
        traj = animatedline('Color',[1 0 0], 'LineWidth',0.5);
        link_handle = plot(X_coords, Y_coords, 'LineWidth',5, ...
            'Color',[0 0.447 0.741], 'Marker','o', ...
            'MarkerSize',10, 'MarkerFaceColor','k');
        ee_handle = plot(P3(1), P3(2), 'ro', 'MarkerSize',6, 'MarkerFaceColor','r');
        
        
        vert_handle = plot(x_vert, y_vert, '--m', 'LineWidth', 1.5);
        
       
        circle_handle = patch(x_circle, y_circle, 'r', ...
                          'FaceColor', [1 0 0], ...     % vermelho sólido
                          'EdgeColor', [0.6 0 0], ...   % vermelho escuro para o contorno
                          'FaceAlpha', 1, ...
                          'LineWidth', 1.5);
                          
        max_reach = l1 + l2 + l3;
        axis_limit = max_reach * 1.1;
        axis([-axis_limit axis_limit -axis_limit axis_limit]);
        pbaspect([1 1 1]);
        grid on;
        xlabel('X [m]');
        ylabel('Y [m]');
        title('Three-Link Planar Robot Simulator');
        
       
        subplot(1,2,2); hold on;
        q1_line = animatedline('Color',[0 0.447 0.741],'LineWidth',1.5);
        q2_line = animatedline('Color',[0.9 0.3 0.1],'LineWidth',1.5);
        q3_line = animatedline('Color',[0.2 0.7 0.2],'LineWidth',1.5);
        
       
        legend({'q1','q2', 'q3'}, 'Location','best');
        
        xlabel('Time [s]');
        ylabel('Angle [rad]');
        title('Joint Angles Over Time');
        grid on;
    else
        figure(fig_handle);
        set(link_handle, 'XData', X_coords, 'YData', Y_coords);
        set(ee_handle,  'XData', P3(1), 'YData', P3(2));
        
       
        y_vert = Ay * sin(phi);
        set(vert_handle, 'XData', xv * ones(size(y_vert)), 'YData', y_vert);
        
       
        x_circle = xc + Rc*cos(phi_c);
        y_circle = yc + Rc*sin(phi_c);
        set(circle_handle, 'XData', x_circle, 'YData', y_circle);
    end
    

    addpoints(traj, P3(1), P3(2));
    addpoints(q1_line, t, q1);
    addpoints(q2_line, t, q2);
    addpoints(q3_line, t, q3);
    
    drawnow limitrate;
end