%% Load Data

% Load Hypsometric Data
hypsoLF = csvread('/Users/jucross/Documents/MDV-Lakes-Thesis/lake-model/data-raw/lake-data/hypsometry/LF_hypso.csv',1);
hypsoLH = csvread('/Users/jucross/Documents/MDV-Lakes-Thesis/lake-model/data-raw/lake-data/hypsometry/LH_hypso.csv',1);
hypsoLB = csvread('/Users/jucross/Documents/MDV-Lakes-Thesis/lake-model/data-raw/lake-data/hypsometry/LB_hypso.csv',1);

% Load Observed Lake Level Change Data
lakeDelta = csvread('/Users/jucross/Documents/MDV-Lakes-Thesis/lake-model/data-raw/lake-data/lake-level/lake_level_delta.csv',1);

%% Add Data to a Structure

% Add hypso to lake structure
% NOTE: lake.hypso.XX structure columns -> depth, area, volume
lake.hypso.LF = hypsoLF;
lake.hypso.LH = hypsoLH;
lake.hypso.LB = hypsoLB;

% Add observed lake level to structure
% NOTE: lake.levelObs.XX structure columns -> change, date number (1 1 1900)
lake.levelObs.LF = lakeDelta(1:37,1:2);
lake.levelObs.LH = lakeDelta(:,3:4);
lake.levelObs.LB = lakeDelta(1:37,5:6);
