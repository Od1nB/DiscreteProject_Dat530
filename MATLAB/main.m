clear all; clc;

global global_info;
%Load data from file
%[busNr, departures, routeTime, deviation, changeDriver,...
%    changeDriverStop, changeDriverTime] = loadData('busRoutes.xlsx');

%Petri Net structure
pns = pnstruct({'connector_pdf',...
    'generator_pdf',...
    'preparation_pdf',...
    'routes_pdf',...
    'driving_pdf',...
    'cleanup_pdf',...
    });

% firing times
dyn.ft = {'tBusDriverGenerator', 1};

% initial state
dyn.m0 ={};

pni = initialdynamics(pns,dyn);


%Run Simulation
sim = gpensim(pni);