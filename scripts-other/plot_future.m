% Plot Lake Resutls

%% Load Data

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

%% Generate modeled lake level change

% Bonney lake level change
lake.modeled.LB.date(:,1) = datetime(lake.t_vec,3,31) +calyears(0);
lake.modeled.LB.dh(:,1) = lake.h.glacier(1,:)'-62.30;


% Hoare lake level change
lake.modeled.LH.date(:,1) = datetime(lake.t_vec,3,31) +calyears(0);
lake.modeled.LH.dh(:,1) = lake.h.glacier(2,:)'-74.09;

% Fryxell lake level change
lake.modeled.LF.date(:,1) = datetime(lake.t_vec,3,31) +calyears(0);
lake.modeled.LF.dh(:,1) = lake.h.glacier(3,:)'-17.50;

%% Plot lake level change - Seperate plots

figure(2); clf; clear ha; ha = tight_subplot(3,1, [0.03 0.05], [.11 .01], [.05 .03]);
set(gcf,'units','normalized','outerposition',[0.1 0.05 0.6 0.9])

% Lake Bonney
axes(ha(1)); hold all; grid on;
% Measured
plot(lake.raw.LB.date(:), movmean(lake.raw.LB.dh(:),5),'-k','LineWidth', 1.5)
plot(lake.raw.LB.date(:), lake.raw.LB.dh(:),':','Color',[0.5 0.5 0.5],'LineWidth', 1.5)
% Modeled
plot(lake.modeled.LB.date(:), lake.modeled.LB.dh(:), 's--k','LineWidth', 1.5)
% Zero Line
line([datetime(1993,1,1), datetime(2031,1,1)],[0,0], 'Color','k', 'LineWidth', 1)

xticks([datetime(1993,1,1):calyears(1):datetime(2031,1,1)]);
datetick('x','KeepTicks')
xticklabels('')
xtickangle(45)
ylim([-1 3])
yticklabels('auto')
legend({'Obs - Surveyed','Obs - Running Mean', 'Simulated'}, 'Location', 'NorthWest');
text(datetime(2002,1,1), 2.5, 'Lake Bonney', 'FontWeight', 'bold', 'FontSize',14);

% Lake Hoare
axes(ha(2));  hold all; grid on;
% Measured
plot(lake.raw.LH.date(:), movmean(lake.raw.LH.dh(:),5),'-k','LineWidth', 1.5)
plot(lake.raw.LH.date(:), lake.raw.LH.dh(:),':','Color',[0.5 0.5 0.5],'LineWidth', 1.5)
% Modeled
plot(lake.modeled.LH.date(:), lake.modeled.LH.dh(:), 's--k','LineWidth', 1.5)
% Zero Line
line([datetime(1993,1,1), datetime(2031,1,1)],[0,0], 'Color','k', 'LineWidth', 1)

ylabel('Lake Level Change [m]')
xticks([datetime(1993,1,1):calyears(1):datetime(2031,1,1)]);
xtickangle(45)
datetick('x','KeepTicks')
xticklabels('')
ylim([-1 2])
yticklabels('auto')
%legend({'Obs - Surveyed','Obs - Running Mean', 'Simulated'}, 'Location', 'NorthWest');
text(datetime(2002,1,1), 1.5,'Lake Hoare', 'FontWeight', 'bold', 'FontSize',14);

% Lake Fryxell
axes(ha(3)); hold all; grid on;
% Measured
plot(lake.raw.LF.date(:), movmean(lake.raw.LF.dh(:),5),'-k','LineWidth', 1.5)
plot(lake.raw.LF.date(:), lake.raw.LF.dh(:),':','Color',[0.5 0.5 0.5],'LineWidth', 1.5)
% Modeled
plot(lake.modeled.LF.date(:), lake.modeled.LF.dh(:), 's--k','LineWidth', 1.5)
% Zero Line
line([datetime(1993,1,1), datetime(2031,1,1)],[0,0], 'Color','k', 'LineWidth', 1)

xlabel('Date')
xticks([datetime(1993,1,1):calyears(1):datetime(2031,1,1)]);
xtickangle(45)
dateformat = 'mmm yy';
datetick('x',dateformat, 'KeepTicks')
ylim([-1 2])
yticklabels('auto')
%legend({'Obs - Surveyed','Obs - Running Mean', 'Simulated'}, 'Location', 'NorthWest');
text(datetime(2002,1,1), 1.5,'Lake Fryxell', 'FontWeight', 'bold', 'FontSize',14);

set(ha(1:3),'XColor','k', 'YColor', 'k', 'FontWeight', 'bold', 'LineWidth', 1.25, 'FontSize', 14, 'GridColor', 'k', 'box', 'on');
set(ha(1:3),'Xlim', [datetime(1993,1,1) datetime(2031,1,1)]);
