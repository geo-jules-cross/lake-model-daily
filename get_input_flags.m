% Adapted from Obryk et al 2017
% By Julian Cross
% Code originally by E. Waddington

function [ flags ] = get_input_flags
% set flags that tell main program whether to 
%
%     0 - use modeled meltwater inflow
%     1 - use measured stream inflow
%     2 - use interpolated inflow
%     3 - use measured where available otherwise modeled

  flags.Q_glacier_flag = 3;
%
%     0 - read flux histories from external files or 
%     1 - generate time series in matlab function get_fluxes.m
%
  flags.P_flag         	= 0;    %  Precipitation
  flags.S_flag         	= 0;    %  Sublimation
  flags.E_flag         	= 0;    %  Evaporation
%
%     0 - read hypsometry data from external file or 
%     1 - generate hypsometry data in matlab function get_geometry.m
%
  flags.A_h_flag       	= 0;    %  Hypsometry
%
%	Determine which basin to run
%     0 - all
%     1 - bonney
%     2 - hoare
%     3 - fryxell
%
	flags.basin			 	= 0;	 % Basin to run 

%
% Get melt?	
%
	flags.melt				= 0;	% Rebuild melt
%
%
%  flags are returned in a structure called "flags"
%
end   %  function
%