% Adapted from Obryk et al 2017
% By Julian Cross
% Code originally by E. Waddington

function [ flags ] = get_input_flags
% set flags that tell main program whether to 
%
%     0 - read flux histories from external files or 
%     1 - generate time series in matlab function get_fluxes.m
%
    flags.S_flag         	= 0;    %  Sublimation
%
%     0 - read hypsometry data from external file or 
%     1 - generate hypsometry data in matlab function get_geometry.m
%
    flags.A_h_flag       	= 0;    %  Hypsometry
%
%     0 - no
%     1 - yes
    
    flags.melt              = 1;    % Rebuild melt
%
%     0 - no
%     1 - yes
    
    flags.sublimation		= 1;	% Rebuild sublimation
%
%	Determine which basin to run
%     0 - all
%     1 - bonney
%     2 - hoare
%     3 - fryxell
%
    flags.basin			 	= 0;	 % Basin to run 
%
%  flags are returned in a structure called "flags"
%
end   %  function
%