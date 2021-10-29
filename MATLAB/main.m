clear all; clc;

global global_info;
%Load data from file
[busNr, departures, routeTime, deviation, changeDriver,...
    changeDriverStop, changeDriverTime] = loadData('busRoutes.xlsx');

%Petri Net structure
pns = pnsstruct({'generator_pdf'});
pni = initialdynamics(pns,dyn);

% firing times
dyn.ft = {}
%Run Simulation
sim = gpensim(pni);