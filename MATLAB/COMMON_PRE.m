function[fire, transition] = COMMON_PRE(transition)
% function [fire, trans] = COMMON_PRE(trans)
global global_info;

%pWait = ntokens('pWait'); %check how many items tokens in pWait if
%neccesary

%Module 2 preparation 

%Check if can fire
if(strcmp(transition.name, 'tPick_up_bus_from_parking'))
    transition.new_color = 'bus';
    fire = 1;

%Check if can fire
elseif(strcmp(transition.name, 'tPick_up_car'))
    transition.new_color = 'vehicle';
    fire = 1;


%module 3 routes

%Check if can fire
elseif(strcmp(transition.name, 'tDriveToBusStopBus'))
    tokID = tokenAny('pRoutes',1);
    colors = get_color('pRoutes',tokID);
    if(strcmp(colors{1},'bus' )) %check if correct color
        fire = 1;
    else
        fire = 0;
    end


%Check if can fire
elseif(strcmp(transition.name, 'tDriveToBusStopCar'))
    tokID = tokenAny('pRoutes',1);
    colors = get_color('pRoutes',tokID);
    if(strcmp(colors{1},'vehicle' )) %check if correct color
        fire = 1;
    else
        fire = 0;
    end


%Check if can fire
elseif(strcmp(transition.name, 'tTakeBusToParking'))
    tokID = tokenAny('pLastStop',1);
    colors = get_color('pLastStop',tokID);
    %if(strcmp(colors{1},'bus_done' )) %check if correct color
    fire = 1;
    %else
    %    fire = 0;
    %end


%Check if can fire
elseif(strcmp(transition.name, 'tChangeDriver'))
    tokID = tokenAny('pLastStop',1);
    colors = get_color('pLastStop',tokID);
    %if(strcmp(colors{1},'switch' )) %check if correct color
    fire = 1;
    %else
    %    fire = 0;
    %end


%Check if can fire
elseif(strcmp(transition.name, 'tTakeCarToParking'))
   transition.new_color = 'vehicle_done';
   transition.override = 1;
   fire = 1;
else
    fire = 1;
end

%module 5 cleanup

