% Plot Lake Results

clear ;
%% Load Data

structure = load('DATA/lake.mat');

lake = structure.lake;

clear structure;

structure = load('DATA/lake-stream-in.mat');

lake_streams = structure.lake;

clear structure;

% load Bonney measured lake level
fid = fopen('DATA/dh_lake_LB_1996.txt');
LB = textscan(fid, '%{yyyy}D %f', 'HeaderLines', 2);
lake.measured.LB.date(:,1) = LB{1,1};
lake.measured.LB.dh(:,1) = LB{1,2};
fid = fopen('DATA/dh_raw_LB_1996.txt');
LB = textscan(fid, '%{M/d/yy}D %f', 'HeaderLines', 2);
lake.raw.LB.date(:,1) = LB{1,1}-calyears(0);
lake.raw.LB.dh(:,1) = LB{1,2};
clear LB

% load Hoare measured lake level
fid = fopen('DATA/dh_lake_LH_1996.txt');
LH = textscan(fid, '%{yyyy}D %f', 'HeaderLines', 2);
lake.measured.LH.date(:,1) = LH{1,1};
lake.measured.LH.dh(:,1) = LH{1,2};
fid = fopen('DATA/dh_raw_LH_1996.txt');
LH = textscan(fid, '%{M/d/yy}D %f', 'HeaderLines', 2);
lake.raw.LH.date(:,1) = LH{1,1}-calyears(0);
lake.raw.LH.dh(:,1) = LH{1,2};
clear LH

% load Fryxell measured lake level
fid = fopen('DATA/dh_lake_LF_1996.txt');
LF = textscan(fid, '%{yyyy}D %f', 'HeaderLines', 2);
lake.measured.LF.date(:,1) = LF{1,1};
lake.measured.LF.dh(:,1) = LF{1,2};
fid = fopen('DATA/dh_raw_LF_1996.txt');
LF = textscan(fid, '%{M/d/yy}D %f', 'HeaderLines', 2);
lake.raw.LF.date(:,1) = LF{1,1}-calyears(0);
lake.raw.LF.dh(:,1) = LF{1,2};
clear LF

%% Generate modeled lake level change

% Bonney lake level change
% bonney_datum = 62.29;
bonney_datum = 62.30;

lake.modeled.LB.date(:,1) = datetime(lake.t_vec,3,31) +calyears(0);
lake_streams.modeled.LB.date(:,1) = datetime(lake_streams.t_vec,3,31) +calyears(0);
    % lake.modeled.LB.year(:,1) = LB{1,1};
    % datetime(year(lake.modeled.LB.year(:)),1,1);%+calyears(1);
    % datetime(year(lake.modeled.LB.year(:)), 3, 31);
lake.modeled.LB.dh(:,1) = lake.h.glacier(1,:)'-bonney_datum;
lake_streams.modeled.LBcombo.dh(:,1) = lake_streams.h.combo(1,:)'-bonney_datum;
lake_streams.modeled.LBlow.dh(:,1) = lake_streams.h.low(1,:)'-bonney_datum;
lake_streams.modeled.LBhigh.dh(:,1) = lake_streams.h.high(1,:)'-bonney_datum;

% Hoare lake level change
% hoare_datum = 74.04;
hoare_datum = 73.92;

lake.modeled.LH.date(:,1) = datetime(lake.t_vec,3,31) +calyears(0);
lake_streams.modeled.LH.date(:,1) = datetime(lake_streams.t_vec,3,31) +calyears(0);
lake.modeled.LH.dh(:,1) = lake.h.glacier(2,:)'-hoare_datum;
lake_streams.modeled.LHcombo.dh(:,1) = lake_streams.h.combo(2,:)'-hoare_datum;
lake_streams.modeled.LHlow.dh(:,1) = lake_streams.h.low(2,:)'-hoare_datum;
lake_streams.modeled.LHhigh.dh(:,1) = lake_streams.h.high(2,:)'-hoare_datum;

% Fryxell lake level change
% fryxell_datum = 17.41;
fryxell_datum = 17.28;

lake.modeled.LF.date(:,1) = datetime(lake.t_vec,3,31) +calyears(0);
lake_streams.modeled.LF.date(:,1) = datetime(lake_streams.t_vec,3,31) +calyears(0);
lake.modeled.LF.dh(:,1) = lake.h.glacier(3,:)'-fryxell_datum;
lake_streams.modeled.LFcombo.dh(:,1) = lake_streams.h.combo(3,:)'-fryxell_datum;
lake_streams.modeled.LFlow.dh(:,1) = lake_streams.h.low(3,:)'-fryxell_datum;
lake_streams.modeled.LFhigh.dh(:,1) = lake_streams.h.high(3,:)'-fryxell_datum;

save('lake.mat', 'lake')

close all
%% Plot lake level change - All one plot

% figure(1); clf; hold all; box on; grid on;
% set(gcf,'units','normalized','outerposition',[0.1 0.3 0.6 0.6])
% 
% set(gca,'XColor','k', 'YColor', 'k', 'FontWeight', 'bold', 'FontSize',14,'LineWidth', 1.5, 'GridColor', 'k');
% 
% % Measured Annual
% % plot(lake.measured.LB.date(:), lake.measured.LB.dh(:), '-','Color',[0.5 0.5 0.5],'LineWidth', 1.5)
% % plot(lake.measured.LH.date(:), lake.measured.LH.dh(:), '-','Color',[0.5 0.5 0.5],'LineWidth', 1.5)
% % plot(lake.measured.LF.date(:), lake.measured.LF.dh(:), '-','Color',[0.5 0.5 0.5],'LineWidth', 1.5)
% 
% % Measured All
% % plot(lake.raw.LB.date(:), lake.raw.LB.dh(:),':','Color',[0.5 0.5 0.5],'LineWidth', 1.5, 'HandleVisibility','off')
% % plot(lake.raw.LH.date(:), lake.raw.LH.dh(:),':','Color',[0.5 0.5 0.5],'LineWidth', 1.5, 'HandleVisibility','off')
% % plot(lake.raw.LF.date(:), lake.raw.LF.dh(:),':','Color',[0.5 0.5 0.5],'LineWidth', 1.5, 'HandleVisibility','off')
% 
% % Measured Smoothed
% % plot(lake.raw.LB.date(:), movmean(lake.raw.LB.dh(:),5),'-k','LineWidth', 1.5)
% % plot(lake.raw.LH.date(:), movmean(lake.raw.LH.dh(:),5),'-r','LineWidth', 1.5)
% % plot(lake.raw.LF.date(:), movmean(lake.raw.LF.dh(:),5),'-b','LineWidth', 1.5)
% 
% % Modeled
% plot(lake.modeled.LB.date(:), lake.modeled.LB.dh(:), 's--k','LineWidth', 1.5)
% plot(lake.modeled.LH.date(:), lake.modeled.LH.dh(:), 's--r','LineWidth', 1.5)
% plot(lake.modeled.LF.date(:), lake.modeled.LF.dh(:), 's--b','LineWidth', 1.5)
% 
% ylabel('Lake Level Change [m]')
% %ylim([-1 1.5])
% ylim([-1 2.5])
% 
% line([datetime(1990,1,1), datetime(2019,1,1)],[0,0], 'Color','k', 'LineWidth', 1)
% xlabel('Year')
% set(gca,'XTick', [datetime(1990,1,1):calyears(2):datetime(2019,1,1)]);
% xlim([datetime(1994,1,1) datetime(2014,1,1)])
% datetick('x', 'keepticks', 'keeplimits')
% xtickangle(45)
% 
% legend({'Bonney', 'Hoare', 'Fryxell'});
% 
% % legend({'Bonney - Surveyed', 'Hoare', 'Fryxell',...
% %     'Bonney - Running Mean', 'Hoare', 'Fryxell'});
% %      'Bonney - Modeled', 'Hoare', 'Fryxell',});

%% Plot lake level change - Seperate plots

figure(2); clf; clear ha; ha = tight_subplot(3,1, [0.03 0.05], [.11 .01], [.08 .03]);
set(gcf,'units','normalized','outerposition',[0.1 0.05 0.6 0.9])

% Lake Bonney
axes(ha(1)); hold all; grid on;

% Measured
plot(lake.raw.LB.date(:), movmean(lake.raw.LB.dh(:),5),'-k','LineWidth', 1.5)
plot(lake.raw.LB.date(:), lake.raw.LB.dh(:),':','Color',[0.5 0.5 0.5],'LineWidth', 2)
% Modeled
plot(lake.modeled.LB.date(:), lake.modeled.LB.dh(:), 's--k','LineWidth', 1.5)
% Zero Line
line([datetime(1993,1,1), datetime(2018,1,1)],[0,0], 'Color','k', 'LineWidth', 1, 'HandleVisibility','off')
% Modeled w/ Stream Inflows
x_data = lake_streams.modeled.LB.date(:);
y_data = lake_streams.modeled.LBcombo.dh(:);
lower_confidence_band_y = lake_streams.modeled.LBlow.dh(:);
upper_confidence_band_y = lake_streams.modeled.LBhigh.dh(:);
x_plot = [x_data' fliplr(x_data')];
y_plot = [lower_confidence_band_y' fliplr(upper_confidence_band_y')];
% fill(x_plot, y_plot, [0.5 0.5 0.5], 'FaceAlpha',0.2, 'EdgeColor',[0.5 0.5 0.5], 'EdgeAlpha',0.2)
% plot(x_data, y_data, '-.k','LineWidth', 1, 'HandleVisibility','off')

xticks([datetime(1993,1,1):calyears(1):datetime(2014,1,1)]);
datetick('x','KeepTicks')
xticklabels('')
xtickangle(45)
ylim([-1 3])
yticklabels('auto')
legend({'Obs - Running Mean', 'Obs - Surveyed', 'Simulated'}, 'Location', 'NorthWest', 'box', 'off');
text(datetime(2002,1,1), 2.5, 'Lake Bonney', 'FontWeight', 'bold', 'FontSize',14);

% Lake Hoare
axes(ha(2));  hold all; grid on;

% Measured
plot(lake.raw.LH.date(:), movmean(lake.raw.LH.dh(:),5),'-k','LineWidth', 1.5)
plot(lake.raw.LH.date(:), lake.raw.LH.dh(:),':','Color',[0.5 0.5 0.5],'LineWidth', 2)
% Modeled
plot(lake.modeled.LH.date(:), lake.modeled.LH.dh(:), 's--k','LineWidth', 1.5)
% Zero Line
line([datetime(1993,1,1), datetime(2018,1,1)],[0,0], 'Color','k', 'LineWidth', 1, 'HandleVisibility','off')
% Modeled w/ Stream Inflows
x_data = lake_streams.modeled.LH.date(:);
y_data = lake_streams.modeled.LHcombo.dh(:);
lower_confidence_band_y = lake_streams.modeled.LHlow.dh(:);
upper_confidence_band_y = lake_streams.modeled.LHhigh.dh(:);
x_plot = [x_data' fliplr(x_data')];
y_plot = [lower_confidence_band_y' fliplr(upper_confidence_band_y')];
% fill(x_plot, y_plot, [0.5 0.5 0.5], 'FaceAlpha',0.2, 'EdgeColor',[0.5 0.5 0.5], 'EdgeAlpha',0.2)
% plot(x_data, y_data, '-.k','LineWidth', 1, 'HandleVisibility','off')

ylabel('Lake Level Change [m]')
xticks([datetime(1993,1,1):calyears(1):datetime(2014,1,1)]);
xtickangle(45)
datetick('x','KeepTicks')
xticklabels('')
ylim([-1 1])
yticklabels('auto')
%legend({'Obs - Surveyed','Obs - Running Mean', 'Simulated'}, 'Location', 'NorthWest');
text(datetime(2002,1,1), 0.75,'Lake Hoare', 'FontWeight', 'bold', 'FontSize',14);

% Lake Fryxell
axes(ha(3)); hold all; grid on;

% Measured
plot(lake.raw.LF.date(:), movmean(lake.raw.LF.dh(:),5),'-k','LineWidth', 1.5)
plot(lake.raw.LF.date(:), lake.raw.LF.dh(:),':','Color',[0.5 0.5 0.5],'LineWidth', 2)
% Modeled
plot(lake.modeled.LF.date(:), lake.modeled.LF.dh(:), 's--k','LineWidth', 1.5)
% Zero Line
line([datetime(1993,1,1), datetime(2018,1,1)],[0,0], 'Color','k', 'LineWidth', 1, 'HandleVisibility','off')
% Modeled w/ Stream Inflows
x_data = lake_streams.modeled.LF.date(:);
y_data = lake_streams.modeled.LFcombo.dh(:);
lower_confidence_band_y = lake_streams.modeled.LFlow.dh(:);
upper_confidence_band_y = lake_streams.modeled.LFhigh.dh(:);
x_plot = [x_data' fliplr(x_data')];
y_plot = [lower_confidence_band_y' fliplr(upper_confidence_band_y')];
% fill(x_plot, y_plot, [0.5 0.5 0.5], 'FaceAlpha',0.2, 'EdgeColor',[0.5 0.5 0.5], 'EdgeAlpha',0.2)
% plot(x_data, y_data, '-.k','LineWidth', 1, 'HandleVisibility','off')

xlabel('Date')
xticks([datetime(1993,1,1):calyears(1):datetime(2014,1,1)]);
xtickangle(45)
dateformat = 'mmm yy';
datetick('x',dateformat, 'KeepTicks')
ylim([-1 1])
yticklabels('auto')
%legend({'Obs - Surveyed','Obs - Running Mean', 'Simulated'}, 'Location', 'NorthWest');
text(datetime(2002,1,1), 0.75,'Lake Fryxell', 'FontWeight', 'bold', 'FontSize',14);

set(ha(1:3),'XColor','k', 'YColor', 'k', 'FontWeight', 'bold', 'LineWidth', 1.25, 'FontSize', 14, 'GridColor', 'k', 'box', 'on');
set(ha(1:3),'Xlim', [datetime(1993,1,1) datetime(2014,1,1)]);

%% Plot lake level change w/ SUBLIMATION - Seperate plots

% figure(3); clf; clear ha; ha = tight_subplot(4,1, [0.1 0.05], [.11 .01], [.05 .05]);
% set(gcf,'units','normalized','outerposition',[0.1 0 0.8 1])
% 
% 
% % Sublimation
% axes(ha(1));
% hold all;
% bar(lake.S(:,:)','grouped')
% 
% set(gca,'XColor','k', 'YColor', 'k', 'FontWeight', 'bold', 'FontSize',14,'LineWidth', 1.5, 'GridColor', 'k');
% xlabel('')
% xlim([0 24])
% ylim([0 1])
% xticks([0:24]);
% yticklabels('auto')
% legend({'Lake Bonney', 'Lake Hoare', 'Lake Fryxell'}, 'NorthWest');
% box('on')
% 
% % Lake Bonney
% axes(ha(2));
% hold all;
% % Measured
% plot(lake.measured.LB.date(:), lake.measured.LB.dh(:), 's-k', 'LineWidth', 1.5)
% % Modeled
% plot(lake.modeled.LB.date(:), lake.modeled.LB.dh(:), '--k','LineWidth', 1.5)
% % zero
% line([datetime(1994,1,1), datetime(2018,1,1)],[0,0], 'Color','k', 'LineWidth', 1)
% set(gca,'XColor','k', 'YColor', 'k', 'FontWeight', 'bold', 'FontSize',14,'LineWidth', 1.5, 'GridColor', 'k');
% 
% xlim([datetime(1994,1,1) datetime(2018,1,1)])
% datetick('x')
% xticklabels('')
% xtickangle(45)
% ylim([-1 4])
% yticklabels('auto')
% legend({'Observed', 'Simulated'}, 'Location', 'NorthWest');
% text(datetime(2005,1,1), 3, 'Lake Bonney', 'FontWeight', 'bold', 'FontSize',14);
% box('on')
% 
% % Lake Hoare
% axes(ha(3));
% hold all;
% % Measured
% plot(lake.measured.LH.date(:), lake.measured.LH.dh(:), 'd-k', 'LineWidth', 1.5)
% % Modeled
% plot(lake.modeled.LH.date(:), lake.modeled.LH.dh(:), '--k', 'LineWidth', 1.5)
% % zero
% line([datetime(1994,1,1), datetime(2018,1,1)],[0,0], 'Color','k', 'LineWidth', 1)
% set(gca,'XColor','k', 'YColor', 'k', 'FontWeight', 'bold', 'FontSize',14,'LineWidth', 1.5, 'GridColor', 'k');
% 
% ylabel('Lake Level Change (m)')
% xlim([datetime(1994,1,1) datetime(2018,1,1)])
% xtickangle(45)
% datetick('x')
% xticklabels('')
% ylim([-1 4])
% yticklabels('auto')
% legend({'Observed', 'Simulated'}, 'Location', 'NorthWest');
% text(datetime(2005,1,1), 3,'Lake Hoare', 'FontWeight', 'bold', 'FontSize',14);
% box('on')
% 
% % Lake Fryxell
% axes(ha(4));
% hold all;
% % Measured
% plot(lake.measured.LF.date(:), lake.measured.LF.dh(:), 'o-k','LineWidth', 1.5)
% % Modeled
% plot(lake.modeled.LF.date(:), lake.modeled.LF.dh(:), '--k','LineWidth', 1.5)
% % zero
% line([datetime(1994,1,1), datetime(2018,1,1)],[0,0], 'Color','k', 'LineWidth', 1)
% set(gca,'XColor','k', 'YColor', 'k', 'FontWeight', 'bold', 'FontSize',14,'LineWidth', 1.5, 'GridColor', 'k');
% 
% xlabel('Water Year')
% xlim([datetime(1994,1,1) datetime(2018,1,1)])
% xtickangle(45)
% datetick('x')
% ylim([-1 4])
% yticklabels('auto')
% legend({'Observed', 'Simulated'}, 'Location', 'NorthWest');
% text(datetime(2005,1,1), 3,'Lake Fryxell', 'FontWeight', 'bold', 'FontSize',14);
% box('on')