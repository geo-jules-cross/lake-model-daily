%% Load IceMelt stream volume data

% Output Directory
modelOutSimple='/Users/jucross/Documents/MDV-Lakes-Thesis/lake-model/data-raw/melt-data/All-Config-NoAdj.mat';
% Load data
load(modelOutSimple);

%% Sum stream contribution by lake basin
% Schema for this Analysis
% Lake Bonney   - Santa Fe 10
%               - Priscu 21
%    			- Lawson 29
% Lake Chad     - House 34
% Lake Hoare    - Andersen 41
% Lake Fryxell   - Green 43
%               - Canada 45
%               - Delta 50
%               - Huey 61
%               - Aiken 62
%               - VonGuerard 63
%               - Harnish 65
%    			- Crescent 66
% No Lake       - Commonwealth 74

% Initialize lake arrays
LBYrVol = [];
LHYrVol = [];
LFYrVol = [];
LNYrVol = [];

% initialize stream arrays
LBStVol = [];
LHStVol = [];
LFStVol = [];
LNStVol = [];

% Populate Lake Volume Arrays
basinOrder = [10 21 29 34 41 43 45 50 66 61 62 63 65 71 74];
for b=1:15
    doB = find(basinkey == basinOrder(b));
    if (basinOrder(b) <= 29)
        LFYrVol = [LFYrVol modelSmVol(:,doB)];
        LFStVol = [LFStVol streamYrVol(:,doB)];
    elseif (basinOrder(b) <= 42)
        LHYrVol = [LHYrVol modelSmVol(:,doB)];
        LHStVol = [LHStVol streamYrVol(:,doB)];
    elseif(basinOrder(b) <= 73)
        LBYrVol = [LBYrVol modelSmVol(:,doB)];
        LBStVol = [LBStVol streamYrVol(:,doB)];
    else
        LNYrVol = [LNYrVol modelSmVol(:,doB)];
        LNStVol = [LNStVol streamYrVol(:,doB)];
    end
end

% SUMMER MELT NOT ANNUAL TOTAL - IGNORE WINTER MELT

lakeYrVolSimple = [sum(LBYrVol,2) sum(LHYrVol,2) sum(LFYrVol,2) sum(LNYrVol,2)];

lakeYrVolstream = [sum(LBStVol,2) sum(LHStVol,2) sum(LFStVol,2) sum(LNStVol,2)];

%% Clear simple sum variables

clearvars -except lakeYrVolSimple lakeYrVolstream

%% Load melt data from model 

% Output Directory
modelOut='/Users/jucross/Documents/MDV-Lakes-Thesis/lake-model/data-raw/melt-data/All-Config-NoAdj-Lake.mat';

% Load data
load(modelOut);

%% Sum model basin contribution by lake basin
% Schema for this sum
% Lake Fryxell - 10 to 29
% Lake Hoare - 31 to 42
% Lake Bonney - 43 to 73

% Initialize lake arrays
LBYrVol = [];
LCYrVol = [];
LHYrVol = [];
LFYrVol = [];
LNYrVol = [];

% Populate Lake Volume Arrays
basinOrder = [10,11,15,...
    16,19,21,...
    24,25,26,29,31,...
    32,33,34,36,37,...
    38,39,41,42,43,...
    44,45,50,61,62,...
    63,64,65,66,71,...
    72,73,74,81,82];

for b=1:36
    doB = find(basinkey == basinOrder(b));
    if (basinOrder(b) <= 29)
        LFYrVol = [LFYrVol modelSmVol(:,doB)];
    elseif (basinOrder(b) <= 42)
        LHYrVol = [LHYrVol modelSmVol(:,doB)];
    elseif(basinOrder(b) <= 73)
        LBYrVol = [LBYrVol modelSmVol(:,doB)];
    else
        LNYrVol = [LNYrVol modelSmVol(:,doB)];
    end
end

lakeYrVol = [sum(LBYrVol,2) sum(LHYrVol,2) sum(LFYrVol,2) sum(LNYrVol,2)];

%% Save Output

% Data Output Directory
outDirectory = '/Users/jucross/Documents/MDV-Lakes-Thesis/lake-model/data-raw/melt-data/lake-melt.mat';

% Save it
save(outDirectory, 'lakeYrVol', 'lakeYrVolSimple', 'lakeYrVolstream', 'LBYrVol', 'LFYrVol', 'LHYrVol', 'LNYrVol');