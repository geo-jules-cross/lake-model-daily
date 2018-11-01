% Adapted from Obryk et al 2017
% By Julian Cross
% Code originally by E. Waddington

function [ flags ] = get_input_flags
% set flags that tell main program whether to 
%    0 - read flux histories from external files or 
%    1 - generate time series in matlab function get_fluxes.m
%
%    0 - read hypsometry data from external file or 
%    1 - generate hypsometry data in matlab function get_geometry.m
%
%  flags are returned in a structure called "flags"
%
  flags.Q_glacier_flag = 0;    %  Direct glacier melt from
 	%  0 = Model melt flux
 	%  1 = Measured stream flux
 	%  2 = Interpolated

  flags.P_flag         	= 0;    %  Precipitation
  flags.S_flag         	= 0;    %  Sublimation
  flags.E_flag         	= 0;    %  Evaporation
%
  flags.A_h_flag       	= 0;    %  Hypsometry
%
%	Determine which basin to run
	flags.basin			 	= 0;	 % Basin to run 
	% 0 = all
	% 1 = bonney
	% 2 = hoare
    % 3 = fryxell

% Get melt?	
	flags.melt				= 1;	% Rebuild melt
%
end   %  function
%