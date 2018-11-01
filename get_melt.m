% Adapted for modifications to Obryk et al 2017
% By Julian Cross

function [] = get_melt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load annual melt volumes from ICEMELT model
%   Schema to sum model basin contribution by lake basin
%       Lake Fryxell    = 10 to 29
%       Lake Hoare      = 31 to 42
%       Lake Bonney     = 43 to 73
% SUMMER MELT NOT ANNUAL TOTAL - IGNORE WINTER MELT

% Output Directory
    meltDirectory='/Users/jucross/Documents/MDV-Lakes-Thesis/lake-model/data-raw/melt-data';

% Model melt data to use - change this
    meltData = 'MODIS-Albedo.mat';
    melt = fullfile(meltDirectory, meltData);

% Load data
    load(melt);

% Initialize lake arrays
    LBYrVol = [];
    LCYrVol = [];
    LHYrVol = [];
    LFYrVol = [];
    LNYrVol = [];

% Define basin order
    basinOrder = [10,...
        11,15,16,19,21,...
        24,25,26,29,31,...
        32,33,34,36,37,...
        38,39,41,42,43,...
        44,45,50,61,62,...
        63,64,65,66,71,...
        72,73,74,81,82];

% Populate lake volume arrays
    for b=1:36
        doB = find(basinkey == basinOrder(b));
        if (basinOrder(b) <= 29)
            LFYrVol = [LFYrVol modelYrVol(:,doB)];
        elseif (basinOrder(b) <= 42)
            LHYrVol = [LHYrVol modelYrVol(:,doB)];
        elseif(basinOrder(b) <= 73)
            LBYrVol = [LBYrVol modelYrVol(:,doB)];
        else
            LNYrVol = [LNYrVol modelYrVol(:,doB)];
        end
    end

% Sum lake arrays
    lakeYrVol = [sum(LBYrVol,2) sum(LHYrVol,2) sum(LFYrVol,2) sum(LNYrVol,2)];

% Data output file
    outDirectory = '/Users/jucross/Documents/MDV-Lakes-Thesis/lake-model/DATA/';

% Format and update input data file
    fileList = {'DATA/Q_glacier_LB.txt', 'DATA/Q_glacier_LH.txt', 'DATA/Q_glacier_LF.txt'};

    for f=1:3
        file = fileList{f};
        fileID = fopen(file,'w');
        fmt = '%d \t \t %f \n';
        fprintf(fileID, '%s \n', '% load Q_glacier data');
        fprintf(fileID, '%s \n', '% time (years) Q_glacier (m^3 year^-1)');
        for yr=1995:2012 
            fprintf(fileID, fmt, [yr+1 lakeYrVol(yr-1994,f)]);
        end
    end

end
%