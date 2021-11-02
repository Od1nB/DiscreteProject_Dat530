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
elseif (strcmp(transition.name, 'tRoute3'))
   transition.override = 1;
   curr = current_time();
   transition.new_color = num2str(curr);
   fire = 1;

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
    if(strcmp(colors{1},'bus_done' )) %check if correct color
        fire = 1;
    else
        fire = 0;
    end


%Check if can fire
elseif(strcmp(transition.name, 'tChangeDriver'))
    tokID = tokenAny('pLastStop',1);
    colors = get_color('pLastStop',tokID);
    if(strcmp(colors{1},'switch' )) %check if correct color
        fire = 1;
    else
        fire = 0;
    end


%Check if can fire
elseif(strcmp(transition.name, 'tTakeCarToParking'))
   transition.new_color = 'vehicle_done';
   transition.override = 1;
   fire = 1;

 %Module 4 Driving
 elseif(strcmp(transition.name, 'tRoute3_complete'))
    tokID = tokenAny('pOnRoute3',1);
    colors = get_color('pOnRoute3',tokID);
    startTime = str2double(colors{1});
    mediateTime = current_time() - startTime;
    tripTime = 60;
    
    if ge(mediateTime, tripTime) %check if drivingTime is correct
        fire = 1;
        transition.new_color = 'bus_done';
        transition.override = 1;
    else
        fire = 0;
    end
   % if(strcmp(colors{1},'switch' )) %check if correct color
   %     fire = 1;
   % else
   %     fire = 0;
   % end
   %transition.new_color = 'bus_done';
   %transition.override = 1;
   %fire = 1;
 elseif(strcmp(transition.name, 'tRoute5_complete'))
   transition.new_color = 'bus_done';
   transition.override = 1;
   fire = 1;
 elseif(strcmp(transition.name, 'tRoute6_complete'))
   transition.new_color = 'bus_done';
   transition.override = 1;
   fire = 1;
 elseif(strcmp(transition.name, 'postChange_tRoutex60_complete'))
   transition.new_color = 'bus_done';
   transition.override = 1;
   fire = 1;
 elseif(strcmp(transition.name, 'preChange_tRoutex60_complete'))
   transition.new_color = 'switch';
   transition.override = 1;
   fire = 1;

   
   
   
%module 5 cleanup

%Check if can fire
elseif(strcmp(transition.name, 'tWait'))
    tokID = tokenAny('pHasParked',1);
    colors = get_color('pHasParked',tokID);
    if(strcmp(colors{1},'bus_done' )) %check if correct color
        fire = 1;
    else
        fire = 0;
    end

    %Check if can fire
elseif(strcmp(transition.name, 'tLobby'))
    tokID = tokenAny('pHasParked',1);
    colors = get_color('pHasParked',tokID);
    if(strcmp(colors{1},'vehicle_done' )) %check if correct color
        fire = 1;
    else
        fire = 0;
    end


 








% Must have this to trigger all other transitions
else
    fire = 1;
end



