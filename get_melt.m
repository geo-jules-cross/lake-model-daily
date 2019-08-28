% Adapted for modifications to Obryk et al 2017
% By Julian Cross

function [] = get_melt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load annual melt volumes from ICEMELT model
%   Schema to sum model basin contribution by lake basin
%       Lake Bonney    = 10 to 29
%       Lake Hoare      = 33 34 41 42
%       Lake Fryxell     = 43 to 73
% SUMMER MELT NOT ANNUAL TOTAL - IGNORE WINTER MELT

% Output Directory
    meltDirectory='/Users/jucross/Documents/MDV-Lakes-Thesis/lake-model/data-raw/melt-data';

% Model melt data to use - change this
    meltData = 'albedo-many-adj-30.mat';
%     meltData = 'albedo-many-adj-new.mat';
%     meltData = 'adj-albedo-notbasins.mat';
%     meltData = 'adj-albedo-07.mat';
%     meltData = 'base-MODIS.mat';
    melt = fullfile(meltDirectory, meltData);

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
    basinOrder = [10,...
        11,15,16,19,21,...
        24,25,26,29,31,...
        32,33,34,36,37,...
        38,39,41,42,43,...
        44,45,50,61,62,...
        63,64,65,66,71,...
        72,73,74,81,82];
    
% Stream Basin ID
    streamOrder=[...
        62,41,45,74,66,...
        50,43,65,34,61,...
        29,71,21,10,63];
  
% Populate lake volume arrays
    %doS = 1; % Stream counter
    for b=1:36
        for y=1:18
            
            % Setup a constant inflow (subaqueous melt) - I need to make this a
            % seperate inflow.
            % Lake Bonney
%             Q_subaqueous_LB(1:18,1) = 31400;
            Q_subaqueous_LB(1:18,1) = 31500;
%             Q_subaqueous_LB(1:18,1) = 0;
            % Lake Hoare
%             Q_subaqueous_LH(1:18,1) = 21700;
            Q_subaqueous_LH(1:18,1) = 31800;
%             Q_subaqueous_LH(1:18,1) = 0;
            
            doB = find(basinkey == basinOrder(b));
            if (basinOrder(b) <= 29)
                if (ismember(basinOrder(b),streamOrder))
                    if (streamYrVol(y,find(streamOrder==basinOrder(b)))>0)
                        LBBothVol(y,b) = streamYrVol(y,find(streamOrder==basinOrder(b)));
                        LBBothHighVol(y,b) = (LBBothVol(y,b)*1.2);
                        LBBothLowVol(y,b) = (LBBothVol(y,b)*0.8);
                    else
                        LBBothVol(y,b) = modelSmVol(y,doB);
                        LBBothHighVol(y,b) = modelSmVol(y,doB);
                        LBBothLowVol(y,b) = modelSmVol(y,doB);
                    end
                    LBYrVol(y,b) = modelSmVol(y,doB);
                else
                    LBBothVol(y,b) = modelSmVol(y,doB);
                    LBYrVol(y,b) = modelSmVol(y,doB);
                    LBBothHighVol(y,b) = modelSmVol(y,doB);
                    LBBothLowVol(y,b) = modelSmVol(y,doB);
                end
            elseif (basinOrder(b) == 33 || basinOrder(b) == 34 || basinOrder(b) == 41 || basinOrder(b) == 42)
                %elseif(basinOrder(b) >= 33 && basinOrder(b) <= 42)
                if (ismember(basinOrder(b),streamOrder))
                    if (streamYrVol(y,find(streamOrder==basinOrder(b)))>0)
                        LHBothVol(y,b) = streamYrVol(y,find(streamOrder==basinOrder(b)));
                        LHBothHighVol(y,b) = (LHBothVol(y,b)*1.2);
                        LHBothLowVol(y,b) = (LHBothVol(y,b)*0.8);
                    else
                        LHBothVol(y,b) = modelSmVol(y,doB);
                        LHBothHighVol(y,b) = modelSmVol(y,doB);
                        LHBothLowVol(y,b) = modelSmVol(y,doB);
                    end
                    LHYrVol(y,b) = modelSmVol(y,doB);
                else
                    LHBothVol(y,b) = modelSmVol(y,doB);
                    LHYrVol(y,b) = modelSmVol(y,doB);
                    LHBothHighVol(y,b) = modelSmVol(y,doB);
                    LHBothLowVol(y,b) = modelSmVol(y,doB);
                end
            elseif(basinOrder(b) >= 43 && basinOrder(b) <= 73)
                %elseif((basinOrder(b) >= 36 && basinOrder(b) <= 39 || basinOrder(b) >= 43 && basinOrder(b) <= 73))
                if (ismember(basinOrder(b),streamOrder))
                    if (streamYrVol(y,find(streamOrder==basinOrder(b)))>0)
                        LFBothVol(y,b) = streamYrVol(y,find(streamOrder==basinOrder(b)));
                        LFBothHighVol(y,b) = LFBothVol(y,b)*1.2;
                        LFBothLowVol(y,b) = LFBothVol(y,b)*0.8;
                    else
                        LFBothVol(y,b) = modelSmVol(y,doB);
                        LFBothHighVol(y,b) = modelSmVol(y,doB);
                        LFBothLowVol(y,b) = modelSmVol(y,doB);
                    end
                    LFYrVol(y,b) = modelSmVol(y,doB);
                else
                    LFBothVol(y,b) = modelSmVol(y,doB);
                    LFYrVol(y,b) = modelSmVol(y,doB);
                    LFBothHighVol(y,b) = modelSmVol(y,doB);
                    LFBothLowVol(y,b) = modelSmVol(y,doB);
                end
            else
                if (ismember(basinOrder(b),streamOrder))
                    if (streamYrVol(y,find(streamOrder==basinOrder(b)))>0)
                        LNBothVol(y,b) = streamYrVol(y,find(streamOrder==basinOrder(b)));
                        LNBothHighVol(y,b) = LNBothVol(y,b)*1.2;
                        LNBothLowVol(y,b) = LNBothVol(y,b)*0.8;
                    else
                        LNBothVol(y,b) = modelSmVol(y,doB);
                        LNBothHighVol(y,b) = modelSmVol(y,doB);
                        LNBothLowVol(y,b) = modelSmVol(y,doB);
                    end
                    LNYrVol(y,b) = modelSmVol(y,doB);
                else
                    LNBothVol(y,b) = modelSmVol(y,doB);
                    LNYrVol(y,b) = modelSmVol(y,doB);
                    LNBothHighVol(y,b) = modelSmVol(y,doB);
                    LNBothLowVol(y,b) = modelSmVol(y,doB);
                end
            end
        end
        %doS = doS + 1;
    end

% Sum lake arrays
    lakeYrVol = [sum(LBYrVol,2)+Q_subaqueous_LB sum(LHYrVol,2)+Q_subaqueous_LH sum(LFYrVol,2) sum(LNYrVol,2)];
    lakeBothYrVol = [sum(LBBothVol,2)+Q_subaqueous_LB sum(LHBothVol,2)+Q_subaqueous_LH sum(LFBothVol,2) sum(LNBothVol,2)];
    lakeBothHighYrVol = [sum(LBBothHighVol,2)+Q_subaqueous_LB sum(LHBothHighVol,2)+Q_subaqueous_LH sum(LFBothHighVol,2) sum(LNBothHighVol,2)];
    lakeBothLowYrVol = [sum(LBBothLowVol,2)+Q_subaqueous_LB sum(LHBothLowVol,2)+Q_subaqueous_LH sum(LFBothLowVol,2) sum(LNBothLowVol,2)];
    
% Data output file
    outDirectory = '/Users/jucross/Documents/MDV-Lakes-Thesis/lake-model/DATA/';

% Format and update input data files
    fileList = {'DATA/Q_glacier_LB.txt', 'DATA/Q_glacier_LH.txt', 'DATA/Q_glacier_LF.txt'};

    for f=1:3
        file = fileList{f};
        fileID = fopen(file,'w');
        fmt = '%d \t \t %f \n';
        fprintf(fileID, '%s \n', '% load Q_glacier data');
        fprintf(fileID, '%s \n', '% time (years) Q_glacier (m^3 year^-1)');
        fprintf(fileID, fmt, [1995 0]);
        for yr=1995:2012 
            fprintf(fileID, fmt, [yr+1 lakeYrVol(yr-1994,f)]);
        end
    end

    % Combo
    fileList = {'DATA/Q_combo_LB.txt', 'DATA/Q_combo_LH.txt', 'DATA/Q_combo_LF.txt'};

    for f=1:3
        file = fileList{f};
        fileID = fopen(file,'w');
        fmt = '%d \t \t %f \n';
        fprintf(fileID, '%s \n', '% load Q_combo data');
        fprintf(fileID, '%s \n', '% time (years) Q_combo (m^3 year^-1)');
        fprintf(fileID, fmt, [1995 0]);
        for yr=1995:2012 
            fprintf(fileID, fmt, [yr+1 lakeBothYrVol(yr-1994,f)]);
        end
    end
    
    % Combo High
    fileList = {'DATA/Q_comboHigh_LB.txt', 'DATA/Q_comboHigh_LH.txt', 'DATA/Q_comboHigh_LF.txt'};

    for f=1:3
        file = fileList{f};
        fileID = fopen(file,'w');
        fmt = '%d \t \t %f \n';
        fprintf(fileID, '%s \n', '% load Q_comboHigh data');
        fprintf(fileID, '%s \n', '% time (years) Q_comboHigh (m^3 year^-1)');
        fprintf(fileID, fmt, [1995 0]);
        for yr=1995:2012 
            fprintf(fileID, fmt, [yr+1 lakeBothHighYrVol(yr-1994,f)]);
        end
    end
    
    % Combo
    fileList = {'DATA/Q_comboLow_LB.txt', 'DATA/Q_comboLow_LH.txt', 'DATA/Q_comboLow_LF.txt'};

    for f=1:3
        file = fileList{f};
        fileID = fopen(file,'w');
        fmt = '%d \t \t %f \n';
        fprintf(fileID, '%s \n', '% load Q_comboLow data');
        fprintf(fileID, '%s \n', '% time (years) Q_comboLow (m^3 year^-1)');
        fprintf(fileID, fmt, [1995 0]);
        for yr=1995:2012 
            fprintf(fileID, fmt, [yr+1 lakeBothLowYrVol(yr-1994,f)]);
        end
    end
    
    close all
    
end
%