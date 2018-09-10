% Adapted from Obryk et al 2017
% By Julian Cross
% Code originally by E. Waddington

%change h for every plot

% --------------
% Now plot stuff 
% --------------
    j_fig = 0;

%% --------------------------
% plot lake-basin hypsometry
% --------------------------
    j_fig = j_fig+1;
    figure(j_fig)
    hold on;box on; grid on;
    plot(A_nodes*1e-6, h_nodes, 'linewidth', 1.2, 'linestyle','-', ...
       'color', [0 1 0])
    xlabel('lake area  (km^2)')
    ylabel('Lake depth (m)')
    title('    Lake-basin hypsometry ')
    %set(gca, 'ylim', [0, 0.5*max(h_nodes)] )
    set(gca, 'ylim', [0, max(h_nodes)] )
    set(gca, 'FontSize', 12, 'linewidth', 1)

%% --------------------------
% plot history of inflows and outflows and their sum
% ---------------------------
    j_fig = j_fig+1;
    figure(j_fig)
    hold on;box on; grid on;
    plot(t_vec, Q_glacier/100000, 'linewidth', 1.2, 'linestyle','-', ...
       'color', [0 1 0])
    plot(t_vec, P, 'linewidth', 1.2, 'Marker','none', ...
       'Linestyle', ':', 'color', [0 1 0])
    plot(t_vec, S, 'linewidth', 1.2, 'linestyle','--', ...
       'color', [0 0 1])
    plot(t_vec, E, 'linewidth', 1.2, 'linestyle','-.', ...
       'color', [1 0 0])
  %
    plot(t_vec, P-S-E, 'linewidth', 1.2, 'linestyle','-', ...
       'color', [0 0 0])
   %
    xlabel('Year')
    ylabel('Lake-edge fluxes  (m^3 a^{-1})')
    title('Lake inputs: Green - Q\_glacier. Green - P. Blue - S. Red - E. Black - total')
  %  set(gca, 'ylim', [-0.1e5, 1.2e5] )
    set(gca, 'FontSize', 12, 'linewidth', 1)

%% --------------------------
% plot lake-level history h(t)
% ---------------------------
    j_fig = j_fig+1;
    figure(j_fig)
    hold on;box on; grid on;
    plot(t_vec, h, 'linewidth', 1.2, 'linestyle','-', ...
       'color', [0 0 1])
    xlabel('Year')
    ylabel('Lake depth (m)')
    title('    Lake-level history ')
 %   set(gca, 'ylim', [0, 0.75*max(h_nodes)] )
    set(gca, 'FontSize', 12, 'linewidth', 1)
%
% add analytical solution if A(h) is linear
    if( ~isnan(h_ss) )
       plot(t_analytical/1e3, h_real, 'linewidth', 2.5, ...
        'Marker', '.', 'MarkerSize',12,'linestyle', 'none', ...
        'color', [0 0 0])
    end

%% --------------------------
% plot lake-area history A(t)
% ---------------------------
    j_fig = j_fig+1;
    figure(j_fig)
    hold on;box on; grid on;
    plot(t_vec, A/1e6, 'linewidth', 1.2, 'linestyle','-', ...
       'color', [1 0 0])
    xlabel('Year')
    ylabel('Lake area (km^2)')
    title('    Lake-area history ')
  %  set(gca, 'ylim', [0, 200] )
    set(gca, 'FontSize', 12, 'linewidth', 1)

%% --------------------------
% plot lake-volume history V(t)
% ---------------------------
    j_fig = j_fig+1;
    figure(j_fig)
    hold on;box on; grid on;
    plot(t_vec, V/1e6, 'linewidth', 1.2, 'linestyle','-', ...
       'color', [0 1 0])
    xlabel('Year')
    ylabel('Lake volume (km^3)')
    title('    Lake-volume history ')
    set(gca, 'FontSize', 12, 'linewidth', 1)


%% --------------------------
% figure()
%     hold on;box on; grid on;
%     plot(t_vec/1e3, h, 'linewidth', 1.2, 'linestyle','-', ...
%        'color', [0 0 1])
%     xlabel('Time  (ka)')
%     ylabel('Lake depth (m)')
%     title('    Lake-level history ')
%  %   set(gca, 'ylim', [0, 0.75*max(h_nodes)] )
%     set(gca, 'FontSize', 12, 'linewidth', 1)
    
%     figure
%     plot(t_vec/1e3, h_07, 'linewidth', 1, 'linestyle','-')
%     xlabel('Time  (ka)')
%     ylabel('Lake depth (m)')
%     title('    Lake-level history ')
%     set(gca, 'FontSize', 12, 'linewidth', 1)
%     hold on
    
%     %%%%%%
%     %spline function inflow
%     figure
%     plot(t_vec/1e3, Q_streams/1e7, 'linewidth', 1, 'linestyle','-')
%     xlabel('Time  (ka)')
%     ylabel('Volumetric input (m^3 \times 10^7)')
%     %title('    Lake-level history ')
%     set(gca, 'FontSize', 12, 'linewidth', 1)
  