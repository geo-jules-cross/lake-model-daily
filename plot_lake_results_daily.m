% Plot Lake Results

clear ;
%% Load Data

structure = load('DATA/lake.mat');

lake = structure.lake;

clear structure;

% load Bonney measured lake level
fid = fopen('DATA/dh_daily_LB_1995.txt');
% fid = fopen('DATA/dh_daily_LB_1996.txt');
LB = textscan(fid, '%q %f %f', 'HeaderLines', 2);
lake.measured.LB.date(:,1) = datenum(LB{1,1});
lake.measured.LB.dh(:,1) = LB{1,3};
clear LB

% load Hoare measured lake level
fid = fopen('DATA/dh_daily_LH_1995.txt');
% fid = fopen('DATA/dh_daily_LH_1996.txt');
LH = textscan(fid, '%q %f %f', 'HeaderLines', 2);
lake.measured.LH.date(:,1) = datenum(LH{1,1});
lake.measured.LH.dh(:,1) = LH{1,3};
clear LH

% load Fryxell measured lake level
fid = fopen('DATA/dh_daily_LF_1995.txt');
% fid = fopen('DATA/dh_daily_LF_1996.txt');
LF = textscan(fid, '%q %f %f', 'HeaderLines', 2);
lake.measured.LF.date(:,1) = datenum(LF{1,1});
lake.measured.LF.dh(:,1) = LF{1,3};
clear LF

%% Generate modeled lake level change

% Bonney lake level change
bonney_datum = 62.29;
% bonney_datum = 62.295;

lake.modeled.LB.date(:,1) =lake.t_vec + 728840;
lake.modeled.LB.dh(:,1) = lake.h.glacier(1,:)'-bonney_datum;

% Hoare lake level change
hoare_datum = 74.04;
% hoare_datum = 74.03;

lake.modeled.LH.date(:,1) = lake.t_vec + 728840;
lake.modeled.LH.dh(:,1) = lake.h.glacier(2,:)'-hoare_datum;

% Fryxell lake level change
fryxell_datum = 17.41;
% fryxell_datum = 17.35;

lake.modeled.LF.date(:,1) = lake.t_vec + 728840;
lake.modeled.LF.dh(:,1) = lake.h.glacier(3,:)'-fryxell_datum;

save('lake.mat', 'lake')

close all

%% Make continuous observation series across model days

for d = 1:6425
    if(ismember(lake.modeled.LB.date(d,1),lake.measured.LB.date(:,1))==1)
        lake.measured.LB.dh_all(d,1) = lake.measured.LB.dh(lake.measured.LB.date == lake.modeled.LB.date(d,1),1);
    else
        lake.measured.LB.dh_all(d,1) = NaN;
    end
end

for d = 1:6425
    if(ismember(lake.modeled.LH.date(d,1),lake.measured.LH.date(:,1))==1)
        lake.measured.LH.dh_all(d,1) = lake.measured.LH.dh(lake.measured.LH.date == lake.modeled.LH.date(d,1), 1);
    else
        lake.measured.LH.dh_all(d,1) = NaN;
    end
end

for d = 1:6425
    if(ismember(lake.modeled.LF.date(d,1),lake.measured.LF.date(:,1))==1)
        lake.measured.LF.dh_all(d,1) = lake.measured.LF.dh(lake.measured.LF.date == lake.modeled.LF.date(d,1), 1);
    else
        lake.measured.LF.dh_all(d,1) = NaN;
    end
end
%% Plot lake level change - All one plot

figure(1); clf; hold all; box on; grid on;
set(gcf,'units','normalized','outerposition',[0.1 0.3 0.6 0.6])

c = [0.5 0.5 0.5];

set(gca,'XColor','k', 'YColor', 'k', 'FontWeight', 'bold', 'FontSize',14,'LineWidth', 1.5, 'GridColor', 'k');

% Measured Daily
% plot(datetime(lake.measured.LB.date(:),'ConvertFrom', 'DateNum'), lake.measured.LB.dh(:), ':','Color',c,'LineWidth', 2)
plot(datetime(lake.measured.LH.date(:),'ConvertFrom', 'DateNum'), lake.measured.LH.dh(:), ':','Color','r','LineWidth', 2)
plot(datetime(lake.measured.LF.date(:),'ConvertFrom', 'DateNum'), lake.measured.LF.dh(:), ':','Color','b','LineWidth', 2)

% Modeled
% plot(datetime(lake.modeled.LB.date(:),'ConvertFrom', 'DateNum'), lake.modeled.LB.dh(:), '-.k','LineWidth', 1.5)
plot(datetime(lake.modeled.LH.date(:),'ConvertFrom', 'DateNum'), lake.modeled.LH.dh(:), '-.r','LineWidth', 1.5)
plot(datetime(lake.modeled.LF.date(:),'ConvertFrom', 'DateNum'), lake.modeled.LF.dh(:), '-.b','LineWidth', 1.5)

ylabel('Lake Level Change [m]')
ylim([-1 4.5])

line([datetime(1990,1,1), datetime(2020,1,1)],[0,0], 'Color','k', 'LineWidth', 1)
xlabel('Year')
set(gca,'XTick', [datetime(1990,1,1):calyears(1):datetime(2020,1,1)])
dateformat = 'mmm yy';
datetick('x',dateformat, 'KeepTicks')
xlim([datetime(1994,1,1) datetime(2020,1,1)])
xtickangle(45)

% legend({'Bonney', 'Hoare', 'Fryxell'});

% legend({'Bonney - observed',...
%      'Bonney - simulated'});
 
 legend({'Hoare - observed', 'Fryxell',...
     'Hoare - simulated', 'Fryxell'});

%% Plot lake level change - Seperate plots

figure(2); clf; clear ha; ha = tight_subplot(3,1, [0.03 0.05], [.11 .01], [.08 .03]);
set(gcf,'units','normalized','outerposition',[0.1 0.05 0.6 0.9])

c = [0.5 0.5 0.5];

% Lake Bonney
axes(ha(1)); hold all; grid on;

x = lake.modeled.LB.date(:);
xObs = lake.measured.LB.date(:);
yObs = lake.measured.LB.dh(:);
yAll = lake.measured.LB.dh_all(:);
ySim = lake.modeled.LB.dh(:);
idy = ~isnan(yAll);
% Measured
plot(datetime(xObs,'ConvertFrom', 'DateNum'), yObs, ':','Color',c,'LineWidth', 1)
plot(datetime(x,'ConvertFrom', 'DateNum'), yAll, ':','Color',c,'LineWidth', 2.5)
% Modeled
plot(datetime(x,'ConvertFrom', 'DateNum'), ySim, '-.k','LineWidth', 1.5)

% Zero Line
line([datetime(1993,1,1), datetime(2018,1,1)],[0,0], 'Color','k', 'LineWidth', 1, 'HandleVisibility','off')

xticks([datetime(1993,1,1):calyears(1):datetime(2014,1,1)]);
datetick('x','KeepTicks')
xticklabels('')
xtickangle(45)
ylim([-1 4])
yticklabels('auto')
legend({'Obs - daily all', 'Obs - "blue box"', 'Sim - daily'}, 'Location', 'NorthWest', 'box', 'off');
text(datetime(2002,1,1), 3.5, 'Lake Bonney', 'FontWeight', 'bold', 'FontSize',14);

% Lake Hoare
axes(ha(2)); hold all; grid on;

x = lake.modeled.LH.date(:);
xObs = lake.measured.LH.date(:);
yObs = lake.measured.LH.dh(:);
yAll = lake.measured.LH.dh_all(:);
ySim = lake.modeled.LH.dh(:);
% Measured
plot(datetime(xObs,'ConvertFrom', 'DateNum'), yObs, ':','Color',c,'LineWidth', 1)
plot(datetime(x,'ConvertFrom', 'DateNum'), yAll, ':','Color',c,'LineWidth', 2.5)
% Modeled
plot(datetime(x,'ConvertFrom', 'DateNum'), ySim, '-.k','LineWidth', 1.5)

% Zero Line
line([datetime(1993,1,1), datetime(2018,1,1)],[0,0], 'Color','k', 'LineWidth', 1, 'HandleVisibility','off')

ylabel('Lake Level Change [m]')
xticks([datetime(1993,1,1):calyears(1):datetime(2014,1,1)]);
xtickangle(45)
datetick('x','KeepTicks')
xticklabels('')
ylim([-1 1.5])
yticklabels('auto')
text(datetime(2002,1,1), 1.25,'Lake Hoare', 'FontWeight', 'bold', 'FontSize',14);

% Lake Fryxell
axes(ha(3)); hold all; grid on;

x = lake.modeled.LF.date(:);
xObs = lake.measured.LF.date(:);
yObs = lake.measured.LF.dh(:);
yAll = lake.measured.LF.dh_all(:);
ySim = lake.modeled.LF.dh(:);
% Measured
plot(datetime(xObs,'ConvertFrom', 'DateNum'), yObs, ':','Color',c,'LineWidth', 1)
plot(datetime(x,'ConvertFrom', 'DateNum'), yAll, ':','Color',c,'LineWidth', 2.5)
% Modeled
plot(datetime(x,'ConvertFrom', 'DateNum'), ySim, '-.k','LineWidth', 1.5)

% Zero Line
line([datetime(1993,1,1), datetime(2018,1,1)],[0,0], 'Color','k', 'LineWidth', 1, 'HandleVisibility','off')

xlabel('Date')
xticks([datetime(1993,1,1):calyears(1):datetime(2014,1,1)]);
xtickangle(45)
dateformat = 'mmm yy';
datetick('x',dateformat, 'KeepTicks')
ylim([-1 1.5])
yticklabels('auto')
text(datetime(2002,1,1), 1.25,'Lake Fryxell', 'FontWeight', 'bold', 'FontSize',14);

set(ha(1:3),'XColor','k', 'YColor', 'k', 'FontWeight', 'bold', 'LineWidth', 1.25, 'FontSize', 14, 'GridColor', 'k', 'box', 'on');
set(ha(1:3),'Xlim', [datetime(1993,1,1) datetime(2014,1,1)]);

%% Plot annual lake water balance for specific year and lake

figure(3); clf; clear ha; ha = tight_subplot(3,1, [0.03 0.05], [.11 .01], [.08 .03]);
set(gcf,'units','normalized','outerposition',[0.05 0.05 0.9 0.9])

% Set which lake and year
l = 1;
year = 2002;

switch l
    case 1
        dt_obs = lake.measured.LB.date;
        dh_obs = lake.measured.LB.dh;
        dt_sim = lake.modeled.LB.date;
        dh_sim = lake.modeled.LB.dh;
        I_sim = lake.Q_glacier(1,:)';
        O_sim = lake.S(1,:)';
    case 2
        dt_obs = lake.measured.LH.date;
        dh_obs = lake.measured.LH.dh;
        dt_sim = lake.modeled.LH.date;
        dh_sim = lake.modeled.LH.dh;
        I_sim = lake.Q_glacier(2,:)';
        O_sim = lake.S(2,:)';
    case 3
        dt_obs = lake.measured.LF.date;
        dh_obs = lake.measured.LF.dh;
        dt_sim = lake.modeled.LF.date;
        dh_sim = lake.modeled.LF.dh;
        I_sim = lake.Q_glacier(3,:)';
        O_sim = lake.S(3,:)';
end

% Lake-stage
axes(ha(1)); hold all; grid on;
% Measured
plot(datetime(dt_obs(:),'ConvertFrom', 'DateNum'), dh_obs(:), ':','Color',c,'LineWidth', 2)
% Modeled
plot(datetime(dt_sim(:),'ConvertFrom', 'DateNum'), dh_sim(:)-0.72, '-.k','LineWidth', 1.5)
yticklabels('auto')
%ylim([1 1.8])

xlim([datetime(year-1,4,1) datetime(year,3,31)])
datetick('x','KeepTicks')
xticklabels('')

legend({'Obs', 'Sim'}, 'Location', 'NorthWest', 'box', 'off');

% Inflows
axes(ha(2)); hold all; grid on;
% Modeled
yyaxis left
area(datetime(dt_sim(:),'ConvertFrom', 'DateNum'), I_sim(:), 'FaceColor', c, 'EdgeColor', c)
yticklabels('auto')
% Cummulative sum
yyaxis right
plot(datetime(dt_sim(:),'ConvertFrom', 'DateNum'), cumsum(I_sim(:)), '--k','LineWidth', 1.5)
yticklabels('auto')
ax = gca;
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';

xlim([datetime(year-1,4,1) datetime(year,3,31)])
datetick('x','KeepTicks')
xticklabels('')

legend({'Daily', 'Cumulative'}, 'Location', 'NorthWest', 'box', 'off');

% Outflows
axes(ha(3)); hold all; grid on;
% Modeled
yyaxis left
area(datetime(dt_sim(:),'ConvertFrom', 'DateNum'), O_sim(:), 'FaceColor', c, 'EdgeColor', c)
yticklabels('auto')
% Cummulative sum
yyaxis right
plot(datetime(dt_sim(:),'ConvertFrom', 'DateNum'), -cumsum(O_sim(:)), '--k','LineWidth', 1.5)
yticklabels('auto')
ax = gca;
ax.YAxis(1).Color = 'k';
ax.YAxis(2).Color = 'k';

xlim([datetime(year-1,4,1) datetime(year,3,31)])
xticks([datetime(year-1,4,1):calmonths(1):datetime(year,3,31)]);
xtickangle(45)
dateformat = 'mmm yyyy';
datetick('x',dateformat, 'KeepTicks')

legend({'Daily', 'Cumulative'}, 'Location', 'NorthWest', 'box', 'off');

set(ha(1:3),'XColor','k', 'YColor', 'k', 'FontWeight', 'bold', 'LineWidth', 1.25, 'FontSize', 14, 'GridColor', 'k', 'box', 'on');