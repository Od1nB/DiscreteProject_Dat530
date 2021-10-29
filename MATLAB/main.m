clear all; clc;

global global_info;
%Load data from file
[busNr, departures, routeTime, deviation, changeDriver,...
    changeDriverStop, changeDriverTime] = loadData('busRoutes.xlsx');

%Petri Net structure

%Run Simulation
