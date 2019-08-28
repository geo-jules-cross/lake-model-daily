%clear;

%% Load Data

% load('C:\Users\jucross\Documents\MDV-Lakes-Thesis\melt-model\result-analysis\modelSkill_Tmp.mat');
% 
load('DATA/lake.mat');

%% Plot Inflows and Outflows

times = get_times;

t_0     = times.t_0;
t_end   = times.t_end;
n_steps = times.n_steps;
dt      = times.dt;
t_vec   = times.t_vec;

flags = get_input_flags;

% Start loop through selected basins (set in get_input_flags)
switch flags.basin
    case {1, 2, 3}
        basinloop = 1;
    case 0
        basinloop = 3;
end

figure(1); clf;
set(gcf,'units','normalized','outerposition',[0.2 0.1 0.6 0.8])

subplot(2,1,1)
c = ['k','r','b'];
hold on; box on; grid on;

% Lake basin loop
for b = 1:basinloop
    
    flags.basin = b;
    
    if(flags.melt == 1)
        get_melt;
    end
    
    fluxes = get_fluxes(times,flags);
    
    % S_offset
    if b == 3
        s_offset = -0.05;
    elseif b == 2
        s_offset = +0.02;
    elseif b == 1
        s_offset = +0.01;
    end

    S = fluxes.S + s_offset;
    
    Q_glacier(b,:) = fluxes.Q_glacier;
    S(b,:) = -1*(fluxes.S.*lake.A(b,:));
    

    yyaxis left
    plot(t_vec, Q_glacier, 'linewidth', 1.2, 'linestyle','-', 'color', c(b))
    set(gca,'XColor','k', 'YColor', 'k', 'FontWeight', 'bold', 'FontSize', 14, 'GridColor', 'k');
    ylabel('Lake Inflow  [m^3 yr^{-1}]')
    ylim([-3*1e6 6*1e6])
    xtickangle(45)
    
    yyaxis right
    plot(t_vec, S, 'linewidth', 1.2, 'linestyle','-','color', c(b))
    set(gca,'XColor','k', 'YColor', 'k', 'FontWeight', 'bold', 'FontSize', 14, 'GridColor', 'k');
    ylabel('Lake Outflow  [m^3 yr^{-1}]')
    ylim([-3*1e6 6*1e6])
    xlim([1994 2013])
    xticks([1994:1:2013])
%     xticklabels('');
%     xlabel('Year')
    set(gca, 'FontSize', 14, 'linewidth', 1.5)
end

plot([1994:2013], zeros(20), '-k', 'LineWidth', 1.5)

subplot(2,1,2)
hold on; box on; grid on;
h = bar(t_vec', (lake.dV/1000000)', 'grouped');
h(1).FaceColor = 'k';
h(2).FaceColor = 'r';
h(3).FaceColor = 'b';

set(gca,'XColor','k', 'YColor', 'k', 'FontWeight', 'bold', 'FontSize', 14, 'GridColor', 'k');

ylabel('\Delta V  [x10^{6} m^3 yr^{-1}]')
ylim([-0.5 1.5])
xlim([1994 2014])
xticks([1994:1:2014])
xtickangle(45)
xlabel('Year')
set(gca, 'FontSize', 14, 'linewidth', 1.5)

plot([1994:2013], zeros(20), '-k', 'LineWidth', 1.5)

%% Plot Inflows and Outflows - Combo with Streamflow
% 
% % 
% % load('DATA/lake-stream-in.mat');
% 
% times = get_times;
% 
% t_0     = times.t_0;
% t_end   = times.t_end;
% n_steps = times.n_steps;
% dt      = times.dt;
% t_vec   = times.t_vec;
% 
% flags = get_input_flags;
% 
% % Start loop through selected basins (set in get_input_flags)
% switch flags.basin
%     case {1, 2, 3}
%         basinloop = 1;
%     case 0
%         basinloop = 3;
% end
% 
% figure(2); clf;
% set(gcf,'units','normalized','outerposition',[0.2 0.1 0.6 0.8])
% 
% subplot(2,1,1)
% c = ['k','r','b'];
% hold on; box on; grid on;
% 
% % Lake basin loop
% for b = 1:basinloop
%     
%     flags.basin = b;
%     
%     if(flags.melt == 1)
%         get_melt;
%     end
%     
%     fluxes = get_fluxes(times,flags);
%     
%     Q_g = lake.combo;
%     S = -1*(fluxes.S.*lake.A(b,:));
%     
% 
%     yyaxis left
%     plot(t_vec, Q_combo(b,:), 'linewidth', 1.2, 'linestyle','-', 'color', c(b))
%     set(gca,'XColor','k', 'YColor', 'k', 'FontWeight', 'bold', 'FontSize', 14, 'GridColor', 'k');
%     ylabel('Lake Inflow  [m^3 yr^{-1}]')
%     ylim([-3*1e6 6*1e6])
%     xtickangle(45)
%     
%     yyaxis right
%     plot(t_vec, S, 'linewidth', 1.2, 'linestyle','-','color', c(b))
%     set(gca,'XColor','k', 'YColor', 'k', 'FontWeight', 'bold', 'FontSize', 14, 'GridColor', 'k');
%     ylabel('Lake Outflow  [m^3 yr^{-1}]')
%     ylim([-3*1e6 6*1e6])
%     xlim([1994 2013])
%     xticks([1994:1:2013])
% %     xticklabels('');
% %     xlabel('Year')
%     set(gca, 'FontSize', 14, 'linewidth', 1.5)
% end
% 
% plot([1994:2013], zeros(20), '-k', 'LineWidth', 1.5)
% 
% subplot(2,1,2)
% hold on; box on; grid on;
% h = bar(t_vec', lake.dV', 'grouped');
% h(1).FaceColor = 'k';
% h(2).FaceColor = 'r';
% h(3).FaceColor = 'b';
% 
% set(gca,'XColor','k', 'YColor', 'k', 'FontWeight', 'bold', 'FontSize', 14, 'GridColor', 'k');
% 
% ylabel('\Delta V  [m^3 yr^{-1}]')
% ylim([-20*1e5 50*1e5])
% xlim([1994 2013])
% xticks([1994:1:2013])
% xtickangle(45)
% xlabel('Year')
% set(gca, 'FontSize', 14, 'linewidth', 1.5)
% 
% plot([1994:2013], zeros(20), '-k', 'LineWidth', 1.5)

%% Cummulative Error by Lake
% 
% % Output Directory
% outDirectory='/Users/jucross/Documents/MDV-Lakes-Thesis/melt-model/processed-data/';
% 
% % Specify run to process and load data
% r = 2;
% 
% switch r % change run name with select case
%     case 1
%         runDate='20190709_PARAMS/';
%         runname= 'base-params-streams.mat';
%         path2output=[outDirectory runDate runname];
%         run= load(path2output);
%     case 2
%         runDate='20190709_MODIS/';
%         runname= 'base-MODIS-streams.mat';
%         path2output=[outDirectory runDate runname];
%         run= load(path2output);
%     case 3
%         runDate='20190709_ALBEDO/';
%         runname= 'base-MODIS-07-streams.mat';
%         path2output=[outDirectory runDate runname];
%         run= load(path2output);
% end
% 
% % Store Observed Values and Predicted Values
% 
% fprintf('Storing total daily discharge from each run...\n');
% 
% streams.dates = run.streams.dates;
% 
% TDQ.run.obs = run.streams.TDQ;
% TDQ.run.mod = run.modelTDQ;
% 
% basinkey = run.basinkey;
% 
% % Years to Run
% years2run = (1995:2012);
% 
% % Calculate model effciency across all subset years
% fprintf('Finding observed and modeled Total Daily Q...\n');
% 
% obsSum=[]; modSum=[]; % initialize containers
% 
% % Initialize counting index
% ind = 0;
% 
% % Subset basins
% for l=1:3
%     ind = ind +1;
%     switch l
%         case 1
%             basins2run = [10 21 29];
%         case 2
%             basins2run = [34 41];
%         case 3
%             basins2run = [43 45 50 66 61 62 63 65 71 74];
%     end
%     
%     basinOrder = [10 21 29 34 41 43 45 50 66 61 62 63 65 71 74];
%     
% 
%     
%     c = 1;
%     for day=1:length(TDQ.run.mod) % dont count days with no measurements of streamflow
% 
%         obsSum(day,1)=0;
%         modSum(day,1)=0;
%         
%         for b=1:15
%             if ismember(basinOrder(b),basins2run)
%                 if (TDQ.run.obs(c,b)>=0)  % Measured streamflow this day and eliminate NaN from comparisons
%                     obsSum(day,1)=obsSum(day,1) + TDQ.run.obs(c,b);
%                     modSum(day,1)=modSum(day,1) + TDQ.run.mod(c,b);
%                 end
%             end
%         end
%         c = c + 1;
%     end
%     
%     err = obsSum - modSum;
%     cumError(:,l) = cumsum(err);
%     
% end

%% Cummualtive Error Plots

% % Create plot
% figure (1); clf; hold all;
% set(gcf, 'Name', 'all-volume-compare');
% set(gcf,'units','normalized','outerposition',[0.2 0.4 0.6 0.5])
% set(gca,'XColor','k', 'YColor', 'k', 'FontWeight', 'bold', 'FontSize', 14, 'GridColor', 'k');
% 
% % Absolute
% yyaxis left
% plot(streams.dates,cumError,'-k','LineWidth', 1);
% ylim([-1*1e6 10*1e6])
% ylabel('Error [m^3]', 'FontSize', 18)
% 
% xlabel('Year', 'FontSize', 18)
% xlim([streams.dates(1)-(2*365) streams.dates(end)]);
% datetick('x','keeplimits');
% xtickangle(45)
% set(gca,'XColor','k', 'YColor', 'k', 'FontWeight', 'bold', 'FontSize', 14, 'GridColor', 'k');
% 
% % Normalized
% yyaxis right
% plot(streams.dates,cumError/13650000,'--k','LineWidth', 1);
% ylim([-0.073 0.733])
% ylabel('Area Normalized Error [m]', 'FontSize', 18)
% 
% xlabel('Year', 'FontSize', 18)
% xlim([streams.dates(1)-(2*365) streams.dates(end)+(2*365)]);
% datetick('x','keeplimits');
% xtickangle(45)
% set(gca,'XColor','k', 'YColor', 'k', 'FontWeight', 'bold', 'FontSize', 14, 'GridColor', 'k');
% 
% legendArray = {'Cummulative Error (Obs-Mod)'};
% %legendArray = {'Q_{OBS}','Q_{MOD}', 'Cummulative Error (Obs-Mod)'};
% legend(legendArray, 'Location', 'southeast');
% legend boxoff