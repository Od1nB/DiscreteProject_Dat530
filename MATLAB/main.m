clear all; clc;

global global_info;
%Load data from file
[busNr, departures, routeTime, deviation, changeDriver,...
    changeDriverStop, changeDriverTime] = loadData('busRoutes.xlsx');

%Petri Net structure
pns = pnsstruct({'module_0_Connector/connector_pdf',...
    'module_1_Generator/generator_pdf',...
    'module_2_Preparation/preparation_pdf',...
    'module_3_Routes/routes_pdf',...
    'module_4_Driving/driving_pdf',...
    'module_5_Cleanup/cleanup_pdf',...
    });
pni = initialdynamics(pns,dyn);

% firing times
dyn.ft = {}
%Run Simulation
sim = gpensim(pni);