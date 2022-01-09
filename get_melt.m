% Adapted for modifications to Obryk et al 2017
% By Julian Cross

function [] = get_melt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load annual melt volumes from ICEMELT model
%   Schema to sum model basin contribution by lake basin
%       Lake Bonney    = 10 to 29
%       Lake Hoare      = 33 34 41 42
%       Lake Fryxell     = 43 to 72
% SUMMER MELT NOT ANNUAL TOTAL - IGNORE WINTER MELT

% Output Directory
    outDirectory='/Users/Julian/Documents/_Projects/MDV-Lakes-Thesis/melt-model/processed-data/';
    
    runDate='20211115_ADJ_M3/';
    runname= 'basin-multi-adj-ekh-alb-2007.mat';
    
    path2output=[outDirectory runDate runname];
    melt= fullfile(path2output);

% Load data
    load(melt);

% Initialize lake arrays
    LBYrVol = [];
    LHYrVol = [];
    LFYrVol = [];
    LNYrVol = [];
    
% Array to store combo of modeled and measured inflow
    LBBothVol = [];
    LHBothVol = [];
    LFBothVol = [];
    LNBothVol = [];
    
% Define basin order
    basinOrder=[10,...
    11,15,16,19,21,...
    24,25,26,29,31,...
    32,33,34,36,37,...
    38,39,41,42,43,...
    44,45,50,61,62,...
    63,64,65,66,71,...
    72,74,81,82];

% Populate lake volume arrays
    for b=1:35
        for d = 1:length(dates)
            if month(dates(d)) <= 4 || month(dates(d)) >= 10
                doB = find(basinkey == basinOrder(b));
                % Bonney
                if (basinOrder(b) <= 29)
                    LBDayVol(d,b) = modelTDQ(d,doB);
                % Hoare
                elseif (basinOrder(b) == 33 || basinOrder(b) == 34 || basinOrder(b) == 41 || basinOrder(b) == 42)
                    LHDayVol(d,b) = modelTDQ(d,doB);
                % Fryxell
                elseif(basinOrder(b) >= 43 && basinOrder(b) <= 73)
                    LFDayVol(d,b) = modelTDQ(d,doB);
                end
            else
                LBDayVol(d,b) = 0;
                LHDayVol(d,b) = 0;
                LFDayVol(d,b) = 0;
            end
        end
    end
    
    % Sum lake arrays
    lakeDayVol = [sum(LBDayVol,2) sum(LHDayVol,2) sum(LFDayVol,2)];
    
    % Add subaqueous and snowmelt fluxes (m3/day)
    for d = 1:length(dates)
        
        % Bonney - subaqueous flux - year round
        % Q_subaq_LB = 0;
        Q_subaq_LB = 86;
        lakeDayVol(d,1) = lakeDayVol(d,1) + Q_subaq_LB;
        
        % Hoare - subaqueous flux - year round
        % Q_subaq_LH = 0;
        Q_subaq_LH = 87;
        lakeDayVol(d,2) = lakeDayVol(d,2) + Q_subaq_LH;
        
        % Fryxell - snowmelt flux - DJF only
        % Q_snow_LF = 0;
        % Q_snow_LF = 5000;
        Q_snow_LF = 3750;
        if month(dates(d)) <= 2 || month(dates(d)) >= 11
            lakeDayVol(d,3) = lakeDayVol(d,3) + Q_snow_LF;
        end
    end
    
% Data output file
    outDirectory = 'Users/Julian/Documents/!School/PSU GEOG MS/MDV-Lakes-Thesis/lake-model/DATA/';

% Format and update input data files
    fileList = {'DATA/Q_glacier_LB.txt', 'DATA/Q_glacier_LH.txt', 'DATA/Q_glacier_LF.txt'};

    for f=1:3
        file = fileList{f};
        fileID = fopen(file,'w');
        fmt = '%d \t \t %f \n';
        fprintf(fileID, '%s \n', '% load Q_glacier data');
        fprintf(fileID, '%s \n', '% time (day) Q_glacier (m^3 day^-1)');
        for day = 1:length(dates)
            fprintf(fileID, fmt, [day lakeDayVol(day,f)]);
        end
        fmt = '%d \t \t %f';
    end
    
    close all
    
end
%