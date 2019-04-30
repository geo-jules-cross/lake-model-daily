% Plot Lake Resutls

clear ;
%% Load Data

structure = load('DATA\lake.mat');

lake = structure.lake;

clear structure;

% load Bonney measured lake level
fid = fopen('DATA/h_lake_LB.txt');
LB = textscan(fid, '%{M/d/yyyy}D %f', 'HeaderLines', 2);
lake.measured.LB.date(:,1) = LB{1,1};
lake.measured.LB.dh(:,1) = LB{1,2};
clear LB

% load Hoare measured lake level
fid = fopen('DATA/h_lake_LH.txt');
LH = textscan(fid, '%{M/d/yyyy}D %f', 'HeaderLines', 2);
lake.measured.LH.date(:,1) = LH{1,1};
lake.measured.LH.dh(:,1) = LH{1,2};
clear LH

% load Fryxell measured lake level
fid = fopen('DATA/h_lake_LF.txt');
LF = textscan(fid, '%{M/d/yyyy}D %f', 'HeaderLines', 2);
lake.measured.LF.date(:,1) = LF{1,1};
lake.measured.LF.dh(:,1) = LF{1,2};
clear LF

%% Generate modeled lake level change

% Bonney lake level change
fid = fopen('DATA/Q_glacier_LB.txt');
LB = textscan(fid, '%{yyyy}D %f', 'HeaderLines', 2);
lake.modeled.LB.year(:,1) = LB{1,1};
lake.modeled.LB.date(:,1) = datetime(year(lake.modeled.LB.year(:)), 3, 31);
lake.modeled.LB.dh(:,1) = lake.h(1,:)'-lake.h(1,1);
clear LB

% Hoare lake level change
fid = fopen('DATA/Q_glacier_LH.txt');
LH = textscan(fid, '%{yyyy}D %f', 'HeaderLines', 2);
lake.modeled.LH.year(:,1) = LH{1,1};
lake.modeled.LH.date(:,1) = datetime(year(lake.modeled.LH.year(:)), 3, 31);
lake.modeled.LH.dh(:,1) = lake.h(2,:)'-lake.h(2,1);
clear LH

% Fryxell lake level change
fid = fopen('DATA/Q_glacier_LF.txt');
LF = textscan(fid, '%{yyyy}D %f', 'HeaderLines', 2);
lake.modeled.LF.year(:,1) = LF{1,1};
lake.modeled.LF.date(:,1) = datetime(year(lake.modeled.LF.year(:)), 3, 31);
lake.modeled.LF.dh(:,1) = lake.h(3,:)'-lake.h(3,1);
clear LF

save('lake.mat', 'lake')

%% Plot lake level change

figure(1); clf; hold all;

set(gca,'FontSize',14,'LineWidth',1.5);
set(gcf,'units','normalized','outerposition',[0.25 0.5 0.5 0.4])

% Measured
plot(lake.measured.LB.date(:), lake.measured.LB.dh(:), 'o--r')
plot(lake.measured.LH.date(:), lake.measured.LH.dh(:), 'o--g')
plot(lake.measured.LF.date(:), lake.measured.LF.dh(:), 'o--b')

% Modeled
plot(lake.modeled.LB.date(:), lake.modeled.LB.dh(:), 'o-r')
plot(lake.modeled.LH.date(:), lake.modeled.LH.dh(:), 'o-g')
plot(lake.modeled.LF.date(:), lake.modeled.LF.dh(:), 'o-b')

ylabel('Lake Level Change (m)')

xlabel('Year')
xlim([datetime(1995,1,1) datetime(2019,1,1)])
NumTicks = 26;
L = get(gca,'XLim');
%set(gca,'XTick',linspace(L(1),L(2),NumTicks))
datetick('x')