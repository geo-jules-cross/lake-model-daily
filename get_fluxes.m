% Adapted from Obryk et al 2017
% By Julian Cross
% Code originally by E. Waddington

function [fluxes] = get_fluxes(times, flags)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Get lake input and output fluxes
% Q_glacier = direct glacial melt (m^3 yr^-1 w.e.)
% P = precipitation (m yr^-1 w.e.)
% S = sublimation   (m yr^-1 w.e.)
% E = evaporation   (m yr^-1 w.e.)
%
% on input, structure "times" holds all timing info, 
%      structure "flags" holds flags determining how to get the inputs
%
% on output structure "fluxes" holds time series describing
%     the source and sink functions
%
    t_vec = times.t_vec;
%
%
%------------------------------------------------------------
% read in, or set up time series for direct glacier melt here
%------------------------------------------------------------
%
%  e.g. inflow from melt streams coming off ice dam
%
    tester = flags.Q_glacier_flag;
    if( tester == 0 )
        %  read in GQ_direct_data from a file
        % -----------------------------------
        basin = flags.basin;  % check lake basin
        if( basin == 0) 
                 load DATA/Q_glacier_LB.txt;
                 t_data         = Q_glacier_LB(:,1);
                 Q_glacier_data = Q_glacier_LB(:,2);
                %
        elseif( basin == 1)
                load DATA/Q_glacier_LH.txt;
                t_data         = Q_glacier_LH(:,1);
                Q_glacier_data = Q_glacier_LH(:,2);
                %
        elseif( basin == 2)
            load DATA/Q_glacier_LF.txt;
            t_data         = Q_glacier_LF(:,1);
            Q_glacier_data = Q_glacier_LF(:,2);
        end
        %
    elseif ( tester == 1)
        basin = flags.basin;  % check lake basin
        if( basin == 0) 
                 load DATA/Q_streams_LB.txt;
                 t_data         = Q_streams_LB(:,1);
                 Q_glacier_data = Q_streams_LB(:,2);
                %
        elseif( basin == 1)
                load DATA/Q_streams_LH.txt;
                t_data         = Q_streams_LH(:,1);
                Q_glacier_data = Q_streams_LH(:,2);
                %
        elseif( basin == 2)
            load DATA/Q_streams_LF.txt;
            t_data         = Q_streams_LF(:,1);
            Q_glacier_data = Q_streams_LF(:,2);
        end
        %
    else  
        %
        %  or set up Q_glacier_data here
        % ------------------------------
         t_data = [t_vec(1) t_vec(end) ];
        Q_glacier_data = [0 0];%[ 3.5*1.82e7 3.5*1.82e7 ];% [ 1e7 1e7 ];
    end
    
%
% interpolate at times needed for evolution calculation
    fluxes.Q_glacier = interp1(t_data, Q_glacier_data, t_vec );

%
%
%---------------------------------------------------------
% read in, or set up time series for Precipitation P here
%---------------------------------------------------------
%
    tester = flags.P_flag;
%
    if( tester == 0 )
%
%  read in precipitation history on lakes from a file
% ----------------------------------------------------
     load DATA/P_data.txt;
  %
     t_data = P_data(:,1);
     P_data = P_data(:,2);
  %
    else
%
%  or set it up here
% ---------------
     t_data = [t_vec(1) t_vec(end) ];
     P_data = [0 0]; %[ 0.05 0.05 ];
%
    end  %  Precipitation: if( tester == 0 )
%
% interpolate at times needed for evolution calculation
    fluxes.P = interp1(t_data, P_data, t_vec );
%
%
%
%-------------------------------------------------------------------
% read in, or set up time series for S lake-surface sublimation here
%-------------------------------------------------------------------
%
    tester = flags.S_flag;
%
    if( tester == 0 )
%
%  read in sublimation history from a file
% ----------------------------------------
     load DATA/S_data.txt;
  %
     t_data = S_data(:,1);
     S_data = S_data(:,2);
  %
    else
%
%  or set up here
% ---------------
     t_data = [t_vec(1) t_vec(end) ];
     %S_data = [ 0.07 0.07 ];
     S_data = [ 0.5 0.5 ];
  %
    end   %  Sublimation: if( tester == 0 )
%
% interpolate at times needed for evolution calculation
    fluxes.S = interp1(t_data, S_data, t_vec );
%
%
%
%-------------------------------------------------------------------
% read in, or set up time series for E lake-surface Evaporation here
%-------------------------------------------------------------------
%
    tester = flags.E_flag;
%
    if( tester == 0 )
%
%  read in evaporation history from a file
% -----------------------------------------
     load DATA/E_data.txt;
  %
     t_data = E_data(:,1);
     E_data = E_data(:,2);
  %
    else
%
%  or set up here
% ---------------
     t_data = [t_vec(1) t_vec(end) ];
     E_data = [ 0 0 ];
  %
    end  %  Evaporation: if( tester == 0 )
%
% interpolate at times needed for evolution calculation
    fluxes.E = interp1(t_data, E_data, t_vec );
%
%
%
end   % function
%

