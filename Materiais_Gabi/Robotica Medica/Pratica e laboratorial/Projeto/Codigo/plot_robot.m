function plot_robot(inputs, mode)
    if nargin < 2
        mode = 1;
    end
    
    q1 = inputs(1);
    q2 = inputs(2);
    l1 = inputs(3);
    l2 = inputs(4);
    t  = inputs(5);
    
  
    if length(inputs) >= 7
        err_x = inputs(6);
        err_y = inputs(7);
    else
        err_x = 0;
        err_y = 0;
    end
    
    
    P0 = [0; 0];
    P1 = [l1 * cos(q1); l1 * sin(q1)];
    P2 = [l1*cos(q1) + l2*cos(q1+q2); ...
          l1*sin(q1) + l2*sin(q1+q2)];
    X_coords = [P0(1), P1(1), P2(1)];
    Y_coords = [P0(2), P1(2), P2(2)];
    
   
    persistent traj fig_handle link_handle ee_handle ...
               q1_line q2_line ex_line ey_line ...
               ell_handle other_handle bone_handle
               
    
    xc_ell  = 0.21;
    yc_ell  = 0.24;
    a_ell   = 0.15;
    b_ell   = 0.10;
    phi_vec = linspace(0, 2*pi, 100);
    x_ellipse = xc_ell + a_ell * cos(phi_vec);
    y_ellipse = yc_ell + b_ell * sin(phi_vec);
    
    
    if isempty(fig_handle) || ~isvalid(fig_handle)
        fig_handle = figure(1);
        clf;
        set(fig_handle, 'Position', [100 100 1200 600]); 
        
        
        subplot(2,2,[1 3]); 
        hold on;
        traj = animatedline('Color',[1 0 0], 'LineWidth',0.5);
        link_handle = plot(X_coords, Y_coords, ...
            'LineWidth',5, ...
            'Color',[0 0.447 0.741], ...
            'Marker','o', ...
            'MarkerSize',10, ...
            'MarkerFaceColor','k');
        ee_handle = plot(P2(1), P2(2), ...
            'ro', 'MarkerSize',5, 'MarkerFaceColor','r');
            
        
        switch mode
            case 2
                ell_handle = plot(x_ellipse, y_ellipse, ...
                    '--g', 'LineWidth', 1.5);
            case 3
                xb = 0.21;
                yb = 0.24;
                Ay = 0.1;
                y_vert = yb + Ay * sin(phi_vec);
                x_vert = xb * ones(size(y_vert));
                other_handle = plot(x_vert, y_vert, ...
                    '--m', 'LineWidth',1.5);
            case 4
                y_bone    = 0.2;
                x_start   = 0.25;
                max_reach = l1 + l2;
                x_end     = max_reach * 1.1;
                bone_handle = plot([x_start x_end], ...
                                   [y_bone y_bone], ...
                                   'k', 'LineWidth', 1);
            case 5
                xc  = 0.35;
                yc  = -0.35;
                a   = 0.15;
                b   = 0.15;
                phi = linspace(0,2*pi,100);
                x_vert = xc + a * sin(phi);
                y_vert = yc - b * sin(phi);
                other_handle = plot(x_vert, y_vert, ...
                    'k', 'LineWidth',1);
        end
        max_reach  = l1 + l2;
        axis_limit = max_reach * 1.1;
        axis([-axis_limit axis_limit -axis_limit axis_limit]);
        pbaspect([1 1 1]);
        grid on;
        xlabel('X [m]');
        ylabel('Y [m]');
        title('Robot Simulation');
        
        
        if mode == 1
            
            subplot(2,2,[2 4]); 
        else
            
            subplot(2,2,2);
        end
        
        hold on;
        q1_line = animatedline('Color',[0 0.447 0.741], 'LineWidth',1.5);
        q2_line = animatedline('Color',[0.9 0.3 0.1], 'LineWidth',1.5);
        legend({'q1','q2'}, 'Location','best');
        ylabel('Angle [rad]');
        title('Joint Angles');
        grid on;
     
        if mode >= 2
            subplot(2,2,4);
            hold on;
            ex_line = animatedline('Color','m', 'LineWidth',1.5); 
            ey_line = animatedline('Color','k', 'LineWidth',1.5); 
            legend({'e_x','e_y'}, 'Location','best');
            xlabel('Time [s]');
            ylabel('Error [m]');
            title('Tracking Error');
            grid on;
        end
        
    else
        
        figure(fig_handle);
        
        set(link_handle, 'XData', X_coords, 'YData', Y_coords);
        set(ee_handle,   'XData', P2(1),    'YData', P2(2));
        
        switch mode
            case 2
                if exist('ell_handle','var') && isvalid(ell_handle)
                    set(ell_handle,'XData',x_ellipse,'YData',y_ellipse);
                end
            case 3
                if exist('other_handle','var') && isvalid(other_handle)
                    xb = 0.21;
                    yb = 0.24;
                    Ay = 0.1;
                    y_vert = yb + Ay * sin(phi_vec);
                    set(other_handle, ...
                        'XData', xb*ones(size(y_vert)), ...
                        'YData', y_vert);
                end
            case 4
                if exist('bone_handle','var') && isvalid(bone_handle)
                    y_bone    = 0.2;
                    x_start   = 0.25;
                    max_reach = l1 + l2;
                    x_end     = max_reach * 1.1;
                    set(bone_handle, ...
                        'XData',[x_start x_end], ...
                        'YData',[y_bone y_bone]);
                end
            case 5
                if exist('other_handle','var') && isvalid(other_handle)
                    xc  = 0.35;
                    yc  = -0.35;
                    a   = 0.15;
                    b   = 0.15;
                    phi = linspace(0,2*pi,100);
                    x_vert = xc + a * sin(phi);
                    y_vert = yc - b * sin(phi);
                    set(other_handle,'XData',x_vert,'YData',y_vert);
                end
        end
    end
    
   
    addpoints(traj, P2(1), P2(2));
    addpoints(q1_line, t, q1);
    addpoints(q2_line, t, q2);
    
   
    if mode >= 2
        if ~isempty(ex_line) && isvalid(ex_line)
            addpoints(ex_line, t, err_x);
            addpoints(ey_line, t, err_y);
        end
    end
    
    drawnow limitrate;
end