clear all; clc;

global global_info;
%Load data from file
%[busNr, departures, routeTime, deviation, changeDriver,...
%    changeDriverStop, changeDriverTime] = loadData('busRoutes.xlsx');

global_info.STOP_AT = 150; %Stop after 50 time units, as this is timed P/T
%global_info.DELTA_TIME = 1;
global_info.tokens_firing_times =[0 60 100];

%Petri Net structure
pns = pnstruct({'connector_pdf',...
    'generator_pdf',...
    'preparation_pdf',...
    'routes_pdf',...
    'driving_pdf',...
    'cleanup_pdf',...
    });

% firing times
% these firing times will be changed to be stochastic with rand func

dyn.ft = {
    'tRoute3', 15,...
    'tRoute5', 7.5,...
    'tRoute6', 15,...
    'tBusDriverGenerator', 1,...
    'postChange_tRoutex60', 3,...
    'preChange_tRoutex60', 15,...
    'allOthers', 1,...
    };

% initial state
dyn.m0 ={'pTotalBusDrivers', 40}; %inital tokens

%Resources
%dynamicpart.re = {'bus',4,inf};
pni = initialdynamics(pns,dyn);


%Run Simulation
sim = gpensim(pni);
%prnsys(sim);
%prnss(sim); % print the simulation results 
plotp(sim, {'pOnRoute3', 'pOnRoute5','pOnRoute6', 'preChange_pOnRoutex60',...
    'postChange_pOnRoutex60', 'pCheckedOut', 'pTotalNumberOfBusdrivers'})
ylabel('Active buses on route');
xlabel('Time in minutes');
%plotp(sim, {'pOnRoute5','pOnRoute3', 'pCheckedOut','pTotalNumberOfBusdrivers','pArriveAtBusStop','postChange_pOnRoutex60'}) %plot routes
%plotp(sim, {'pWait','pBussdriver',...
%    'pBussRouteDone','pCheckedOut'}); % plot the results
%prnfinalcolors(sim);