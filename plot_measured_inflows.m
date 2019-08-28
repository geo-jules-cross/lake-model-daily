% Plot Measured Lake Inflows

clear ;
%% Load Data

structure = load('DATA\lake.mat');

lake = structure.lake;

clear structure;

% load Bonney measured lake level
fid = fopen('DATA/dh_lake_LB.txt');
LB = textscan(fid, '%{yyyy}D %f', 'HeaderLines', 2);
lake.measured.LB.date(:,1) = LB{1,1};
lake.measured.LB.dh(:,1) = LB{1,2};
fid = fopen('DATA/dh_raw_LB.txt');
LB = textscan(fid, '%{M/d/yyyy}D %f', 'HeaderLines', 2);
lake.raw.LB.date(:,1) = LB{1,1}-calyears(0);
lake.raw.LB.dh(:,1) = LB{1,2};
clear LB

% load Hoare measured lake level
fid = fopen('DATA/dh_lake_LH.txt');
LH = textscan(fid, '%{yyyy}D %f', 'HeaderLines', 2);
lake.measured.LH.date(:,1) = LH{1,1};
lake.measured.LH.dh(:,1) = LH{1,2};
fid = fopen('DATA/dh_raw_LH.txt');
LH = textscan(fid, '%{M/d/yyyy}D %f', 'HeaderLines', 2);
lake.raw.LH.date(:,1) = LH{1,1}-calyears(0);
lake.raw.LH.dh(:,1) = LH{1,2};
clear LH

% load Fryxell measured lake level
fid = fopen('DATA/dh_lake_LF.txt');
LF = textscan(fid, '%{yyyy}D %f', 'HeaderLines', 2);
lake.measured.LF.date(:,1) = LF{1,1};
lake.measured.LF.dh(:,1) = LF{1,2};
fid = fopen('DATA/dh_raw_LF.txt');
LF = textscan(fid, '%{M/d/yyyy}D %f', 'HeaderLines', 2);
lake.raw.LF.date(:,1) = LF{1,1}-calyears(0);
lake.raw.LF.dh(:,1) = LF{1,2};
clear LF

%% Reverse Engineer Lake Model to Calcualte Actual Inflows and Volume Change

% Call routines
flags = get_input_flags;

% Start loop through selected basins (set in get_input_flags)
switch flags.basin
    case {1, 2, 3}
        basinloop = 1;
    case 0
        basinloop = 3;
end

n_steps = 24;
t_vec = 1994:2018;

% Lake basin loop
for b = 1:basinloop
    
    flags.basin = b;
    
    
    geometry = get_geometry(flags);
    
    % extract elements from structure "geometry"
    h_0       = geometry.h_0;
    h_data    = geometry.h_data;
    A_data    = geometry.A_data;
    dh_nodes  = geometry.dh_nodes;
    N_h_nodes = geometry.N_h_nodes;
    h_nodes   = geometry.h_nodes;
    A_nodes   = geometry.A_nodes;
    V_nodes   = geometry.V_nodes;
    h_cutoff  = geometry.h_cutoff;
    it_max    = geometry.it_max;
    
    %   set up vectors to store results h(t), A(t), and V(t)
    h = nan(1,n_steps);
    A = h;
    V = h;
    
    % Initialize lake-surface elevation, lake area, and lake volume at t_start
    h_new = h_0;
    A_new = interp1(h_nodes, A_nodes, h_new );
    V_new = interp1(h_nodes, V_nodes, h_new );
    
    % Put initial state into time-series vectors h(t), A(t), and V(t)
    h(1)  = h_new;
    A(1)  = A_new;
    V(1)  = V_new;

    % Start time stepping here
    % ------------------------
    for j = 1:n_steps
        
        disp(['Time step  ', num2str(j)]);
        
        % initialize iteration counter
        j_iter = 0;
        
        % At first iteration, use an outrageously large estimate for
        % h_prev_iter (surface height at previous iteration) in order
        % to get into the j_iter loop (there was no zeroth iteration)
        h_prev_iter = 99999;
        
        % move lake solution from previous time step into "old" variables
        h_old = h_new;
        A_old = A_new;
        V_old = V_new;
        
        % inner iterative loop on A_new (nonlinearity)
        % --------------------------------------------
        
        % update iteration number
        j_iter = j_iter+1;
        %
        disp(['      Iteration  ', num2str(j_iter)] );
        
        % save lake surface at previous iteration as h_prev_iter
        h_prev_iter = h_new;
        
        h_new = lake.measured.LF.dh(j,1)+ h_0;
        
        % get corresponding new area and surface elevation
        A_new = interp1(h_nodes, A_nodes, h_new );
        V_new = interp1(h_nodes, V_nodes, h_new );
        
        deltaV(j+1)= V(j)-V_new;
        
        % test for convergence failure
        if(j_iter >= it_max)
            
            disp(['Iterations did not converge at time step ',num2str(j)]);
            break
        end  % if(j_iter > itmax)
        
        
        % iteration has converged and we now have V_new at t+dt
        % save h, A, and V at time t+dt
        h(j+1) = h_new;
        A(j+1) = A_new;
        V(j+1) = V_new;
        
    end  %  for j = 1:n_steps
    
    lake_Meas.basin(b).h_nodes(:) = h_nodes;
    lake_Meas.basin(b).A_nodes(:) = A_nodes;
    lake_Meas.basin(b).V_nodes(:) = V_nodes;
    lake_Meas.basin(b).deltaV(:) = deltaV;
    
end
%% Plot lake level change - All one plot

figure(1); clf; 
set(gcf,'units','normalized','outerposition',[0.1 0.1 0.8 0.8])
ha = tight_subplot(2,1, [0.03 0.07], [.05 .05], [.05 .03]);


axes(ha(1))
hold all; box on; grid on;
set(gca,'XColor','k', 'YColor', 'k', 'FontWeight', 'bold', 'FontSize',14,'LineWidth', 1.5, 'GridColor', 'k');

% Measured Annual
% plot(lake.measured.LB.date(:), lake.measured.LB.dh(:), '-','Color',[0.5 0.5 0.5],'LineWidth', 1.5)
% plot(lake.measured.LH.date(:), lake.measured.LH.dh(:), '-','Color',[0.5 0.5 0.5],'LineWidth', 1.5)
% plot(lake.measured.LF.date(:), lake.measured.LF.dh(:), '-','Color',[0.5 0.5 0.5],'LineWidth', 1.5)

% Measured All
plot(lake.raw.LB.date(:), lake.raw.LB.dh(:),':','Color',[0.5 0.5 0.5],'LineWidth', 1.5)
plot(lake.raw.LH.date(:), lake.raw.LH.dh(:),':','Color',[0.5 0.5 0.5],'LineWidth', 1.5)
plot(lake.raw.LF.date(:), lake.raw.LF.dh(:),':','Color',[0.5 0.5 0.5],'LineWidth', 1.5)

% Measured Smoothed
plot(lake.raw.LB.date(:), movmean(lake.raw.LB.dh(:),5),'-k','LineWidth', 1.5)
plot(lake.raw.LH.date(:), movmean(lake.raw.LH.dh(:),5),'-r','LineWidth', 1.5)
plot(lake.raw.LF.date(:), movmean(lake.raw.LF.dh(:),5),'-b','LineWidth', 1.5)

ylabel('Lake Level Change [m]')
%ylim([-1 1.5])
ylim([-1 4])

set(ha, 'YTickLabelMode', 'auto')

line([datetime(1990,1,1), datetime(2019,1,1)],[0,0], 'Color','k', 'LineWidth', 1.5)
%xlabel('Year')
set(gca,'XTick', [datetime(1990,1,1):calyears(1):datetime(2019,1,1)]);
xlim([datetime(1990,1,1) datetime(2019,1,1)])
datetick('x', 'keepticks', 'keeplimits')
xticklabels(' ');
xtickangle(45)

% legend({'Bonney - Surveyed', 'Hoare', 'Fryxell',...
%     'Bonney - Running Mean', 'Hoare', 'Fryxell'});
% %     'Bonney - Modeled', 'Hoare', 'Fryxell',});

axes(ha(2))
hold on; box on; grid on;
set(gca,'XColor','k', 'YColor', 'k', 'FontWeight', 'bold', 'FontSize',14,'LineWidth', 1.5, 'GridColor', 'k');

bar_data(1,:) = lake_Meas.basin(3).deltaV/1000000;
bar_data(2,:) = lake_Meas.basin(2).deltaV/1000000;
bar_data(3,:) = lake_Meas.basin(1).deltaV/1000000;

bar = bar(t_vec', -bar_data(:,:)', 'grouped');
bar(1).FaceColor = 'k';
bar(2).FaceColor = 'r';
bar(3).FaceColor = 'b';

ylabel('\Delta V  [x10^{6} m^3 yr^{-1}]')
ylim([-1 4])
xlim([1990 2019])
xticks((1990:1:2019))
xtickangle(45)
xlabel('Year')

set(ha, 'XTickLabelMode', 'auto') 
set(ha, 'YTickLabelMode', 'auto')

set(gca, 'FontSize', 14, 'linewidth', 1.5)

plot((1990:2019), zeros(30), '-k', 'LineWidth', 1.5)