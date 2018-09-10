%% Load Data

% Load Lake Melt Data
outDirectory = '/Users/jucross/Documents/MDV-Lakes-Thesis/lake-model/data-raw/melt-data/lake-melt.mat';
load(outDirectory);

%% Model

%% Plots

% Taylor Valley - Melt by Lake Basin - BAR CHART

figure(10007); clf;
set(gcf, 'Name', 'all-season-lake-melt');
set(gcf,'units','normalized','outerposition',[0 0.0375 1 0.96]);

bar(lakeYrVol,'stacked')
legend('Location','Best');
