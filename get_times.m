% Adapted from Obryk et al 2017
% By Julian Cross
% Code originally by E. Waddington

function [times] = get_times
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set times and time increments for calculations of lake level 
% t_0     = start time (days)
% t_end   = end time    
% nsteps  = number of time intervals between t_0 and t_end
%

    % 1995 start
%     t_0     = 1;
%     t_end   = 6425;
%     n_steps = 6424;
    
    % 1996 start
    t_0     = 365;
    t_end   = 6425;
    n_steps = 6060;

%
% set up time step and vector of times for calculations
    dt = (t_end - t_0) / n_steps;
    t_vec = t_0 + [0: n_steps] * dt;
%
% form structure "times" to carry all timing info back to main program
    times.t_0     = t_0;
    times.t_end   = t_end;
    times.n_steps = n_steps;
    times.dt      = dt;
    times.t_vec   = t_vec;
%
end
%