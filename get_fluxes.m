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

        %  read in GQ_direct_data from a file
        % -----------------------------------
        basin = flags.basin;  % check lake basin
        if( basin == 1) 
            load DATA/Q_glacier_LB.txt;
            t_data         = Q_glacier_LB(:,1);
            Q_glacier_data = Q_glacier_LB(:,2);
            %
%             load DATA/Q_glacier_LB_sensitivity.txt;
%             t_data         = Q_glacier_LB_sensitivity(:,1);
%             Q_glacier_data = Q_glacier_LB_sensitivity(:,5);
            %
        elseif( basin == 2)
            load DATA/Q_glacier_LH.txt;
            t_data         = Q_glacier_LH(:,1);
            Q_glacier_data = Q_glacier_LH(:,2);
            %
%             load DATA/Q_glacier_LH_sensitivity.txt;
%             t_data         = Q_glacier_LH_sensitivity(:,1);
%             Q_glacier_data = Q_glacier_LH_sensitivity(:,5);
            %
        elseif( basin == 3)
            load DATA/Q_glacier_LF.txt;
            t_data         = Q_glacier_LF(:,1);
            Q_glacier_data = Q_glacier_LF(:,2);
            %
%             load DATA/Q_glacier_LF_sensitivity.txt;
%             t_data         = Q_glacier_LF_sensitivity(:,1);
%             Q_glacier_data = Q_glacier_LF_sensitivity(:,5);
%             
%             load DATA/Q_glacier_LF_test.txt;
%             t_data         = Q_glacier_LF_test(:,1);
%             Q_glacier_data = Q_glacier_LF_test(:,2);

%             load DATA/Q_glacier_LF_upland.txt;
%             t_data         = Q_glacier_LF_upland(:,1);
%             Q_glacier_data = Q_glacier_LF_upland(:,2);
        end
    
%
% interpolate at times needed for evolution calculation
    fluxes.Q_glacier = interp1(t_data, Q_glacier_data, t_vec );
%
%-------------------------------------------------------------------
% read in, or set up time series for S lake-surface sublimation here
%-------------------------------------------------------------------
%
    tester = flags.S_flag;
%
    if( tester == 0 )
        %  read in sublimation history from a file
        % ----------------------------------------
        basin = flags.basin;  % check lake basin
        if( basin == 1)
            load DATA/S_data_LB.txt;
            t_data = S_data_LB(:,1);
            S_data = S_data_LB(:,2);
            %
%             load DATA/S_data_LB_sensitivity.txt;
%             t_data = S_data_LB_sensitivity(:,1);
%             S_data = S_data_LB_sensitivity(:,5);
            %
        elseif( basin == 2)
            load DATA/S_data_LH.txt;
            t_data = S_data_LH(:,1);
            S_data = S_data_LH(:,2);
            %
%             load DATA/S_data_LH_sensitivity.txt;
%             t_data = S_data_LH_sensitivity(:,1);
%             S_data = S_data_LH_sensitivity(:,5);
            %
%              load DATA/S_data_LH_subsurface.txt;
%              t_data = S_data_LH_subsurface(:,1);
%              S_data = S_data_LH_subsurface(:,2);
             %
        elseif( basin == 3)
%              load DATA/S_data_LF.txt;
%              t_data = S_data_LF(:,1);
%              S_data = S_data_LF(:,2);
             %
             load DATA/S_data_LF_new.txt;
             t_data = S_data_LF_new(:,1);
             S_data = S_data_LF_new(:,2);
             %
%              load DATA/S_data_LF_sensitivity.txt;
%              t_data = S_data_LF_sensitivity(:,1);
%              S_data = S_data_LF_sensitivity(:,5);

%              load DATA/S_data_LF_snow.txt;
%              t_data = S_data_LF_snow(:,1);
%              S_data = S_data_LF_snow(:,2);
            
%              load DATA/S_data_LF_newsnow.txt;
%              t_data = S_data_LF_newsnow(:,1);
%              S_data = S_data_LF_newsnow(:,2);
 
%              load DATA/S_data_LF_subsurface.txt;
%              t_data = S_data_LF_subsurface(:,1);
%              S_data = S_data_LF_subsurface(:,2);
             %
        end
  %
    else
%
%  or set up here
% ---------------
     t_data = [t_vec(1) t_vec(end) ];
     S_data = [ 0.25 0.25 ];
  %
    end   %  Sublimation: if( tester == 0 )
%
% interpolate at times needed for evolution calculation
    fluxes.S = interp1(t_data, S_data, t_vec );

end   % function
%

