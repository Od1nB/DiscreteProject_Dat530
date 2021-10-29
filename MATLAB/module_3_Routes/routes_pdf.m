function [png] = routes_pdf()
%ROUTES_PDF Summary of this function goes here
%   Detailed explanation goes here
png.PN_name = 'Module 3 Routes';
png.set_of_Ps = {'pRoutes', 'pStartRoute', 'pLastStop',...
    'pArriveAtBusStop', 'pInCar', 'pVehicleParked'};
png.set_of_Ts = {'tDriveToBusStopG', 'tDriveToBusStopR',...
    'tChangeDriver','tTakeBusToParking','tTakeCarToParking'};
png.set_of_As = {'pRoutes','tDriveToBusStopG', 1,...
                 'pRoutes','tDriveToBusStopR', 1,...
                 'tDriveToBusStopG', 'pStartRoute', 1,...
                 'tDriveToBusStopG', 'tChangeDriver',1
    };
