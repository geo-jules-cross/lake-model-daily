# Lake Model Options

[![DOI](https://zenodo.org/badge/244526280.svg)](https://zenodo.org/badge/latestdoi/244526280)

Options for the lake model can be set in the following ways:

1. Set options in the `get_input_flags.m` file. 
    - This function tells the main program where and how to setup inflows, climate, and hypsometry.
    - The `Q_glacier_flag` option sets what inflow file to use.
    - Sublimation outflow can be read from a file or generated as a time series.
    - The basin hypsometry can also be read from a file or generated manually.
    - Which lake basin to run can be set with the `flag.basin` option.
    - Finally, you can choose whether to rebuild the inflow and outflow files with the `flag.melt` and `flag.sublimation` options.
2. Set options in the `get_times.m` file.
    - This funtion sets the model run period and creates the `t_vec` array for time stepping through this period.
3. Set options in the `get_fluxes.m` file.
    - This function either defines or reads histories of inflows and lake climate, evaluated at the time steps set in `get_times.m`.
    - If it reads from a file, the data must be in the sub-directory `/DATA`.
4. Set options in the `get_geometry.m` file.
    - This function sets the initial lake level `h_0` and either reads basin hypsomtery from a file or generates it manually.
    - Hypsometry data must be stored in the `/DATA` sub-directory.
