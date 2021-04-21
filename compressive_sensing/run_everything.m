% run everything by executing this .m file
clear;
load('parameters.mat');
run_data_cleaning;
runSP;
run_sensor_data_SVD_vis;
run_compressive;