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
    return
%Check if can fire
elseif(strcmp(transition.name, 'tPick_up_car'))
    transition.new_color = 'vehicle';
    fire = 1;
    return

%module 3 routes
elseif (strcmp(transition.name, 'tRoute3'))
   tokenID = tokenAllColor('pBussdriver', 1, {'bus'});
   if( tokenID == 0)
       fire = 0;
   else
   transition.override = 1;
   curr = current_time();
   transition.new_color = num2str(curr);
   transition.selectedTokens =tokenID;
   fire = tokenID;
   end
   return
elseif (strcmp(transition.name, 'tRoute5'))
   tokenID = tokenAllColor('pBussdriver', 1, {'bus'});
   if( tokenID == 0)
       fire = 0;
   else
   transition.override = 1;
   curr = current_time();
   transition.new_color = num2str(curr);
   transition.selectedTokens =tokenID;
   fire = tokenID;
   end
   return
elseif (strcmp(transition.name, 'tRoute6'))
   tokenID = tokenAllColor('pBussdriver', 1, {'bus'});
   if( tokenID == 0)
       fire = 0;
   else
   transition.override = 1;
   curr = current_time();
   transition.new_color = num2str(curr);
   transition.selectedTokens =tokenID;
   fire = tokenID;
   end
   return
   
elseif (strcmp(transition.name, 'preChange_tRoutex60'))
   tokenID = tokenAllColor('pBussdriver', 1, {'bus'});
   if( tokenID == 0)
       fire = 0;
   else
   transition.override = 1;
   curr = current_time();
   transition.new_color = num2str(curr);
   transition.selectedTokens =tokenID;
   fire = tokenID;
   end
   return
   
elseif (strcmp(transition.name, 'postChange_tRoutex60'))
   tokenID = tokenAllColor('pBussdriver', 1, {'switch'});
   if( tokenID == 0)
       fire = 0;
   else
   transition.override = 1;
   curr = current_time();
   transition.new_color = num2str(curr);
   transition.selectedTokens = tokenID;
   fire = tokenID;
   end
   return
%Check if can fire
elseif(strcmp(transition.name, 'tDriveToBusStopBus'))
    tokID = tokenAny('pRoutes',1);
    colors = get_color('pRoutes',tokID);
    if(strcmp(colors{1},'bus' )) %check if correct color
        fire = 1;
    else
        fire = 0;
    end
    return


%Check if can fire
elseif(strcmp(transition.name, 'tDriveToBusStopCar'))
    tokID = tokenAny('pRoutes',1);
    colors = get_color('pRoutes',tokID);
    if(strcmp(colors{1},'vehicle' )) %check if correct color
        fire = 1;
    else
        fire = 0;
    end
    return


%Check if can fire
elseif(strcmp(transition.name, 'tTakeBusToParking'))
    tokID = tokenAny('pLastStop',1);
    colors = get_color('pLastStop',tokID);
    if(strcmp(colors{1},'bus_done' )) %check if correct color
        fire = 1;
    else
        fire = 0;
    end
    return


%Check if can fire
elseif(strcmp(transition.name, 'tChangeDriver'))
    tokID = tokenAny('pLastStop',1);
    colors = get_color('pLastStop',tokID);
    if(strcmp(colors{1},'switch' )) %check if correct color
        fire = 1;
    else
        fire = 0;
    end
    return


%Check if can fire
elseif(strcmp(transition.name, 'tTakeCarToParking'))
   transition.new_color = 'vehicle_done';
   transition.override = 1;
   fire = 1;
   return

 %Module 4 Driving
 elseif(strcmp(transition.name, 'tRoute3_complete'))
    tokID1 = tokenArrivedEarly('pOnRoute3',1); %tokenAny -> tokenArrivedEarly
    colors = get_color('pOnRoute3',tokID1);
    startTime = str2double(colors{1});
    avgDelay = 0.67; %40 seconds from Kolumbus
    startTime = startTime+avgDelay;% startTime - avg. delay
    mediateTime = current_time() - startTime;
    tripTime = 60+avgDelay; % Minus the time the startTime is delyed?
    diffTime = normrnd(avgDelay, 2.08); %125s std.dev delay from Kolumbus
    mediateTime = mediateTime + diffTime; % timeTaken + random delay
    if ge(mediateTime, tripTime) %check if drivingTime is correct
        transition.selected_tokens = tokID1;
        transition.new_color = 'bus_done';
        transition.override = 1;
        fire = (tokID1);
    else
        fire = 0;
    end
    return

    
 elseif(strcmp(transition.name, 'tRoute5_complete'))
    tokID = tokenArrivedEarly('pOnRoute5',1);
    colors = get_color('pOnRoute5',tokID);
    startTime = str2double(colors{1});
    mediateTime = current_time() - startTime;
    tripTime = 18;
    
    if ge(mediateTime, tripTime) %check if drivingTime is correct
        transition.new_color = 'bus_done';
        transition.override = 1;
        fire = 1;
    else
        fire = 0; 
    end
    return
    
 elseif(strcmp(transition.name, 'tRoute6_complete'))
    tokID = tokenArrivedEarly('pOnRoute6',1);
    colors = get_color('pOnRoute6',tokID);
    startTime = str2double(colors{1});
    mediateTime = current_time() - startTime;
    tripTime = 38;
    
    if ge(mediateTime, tripTime) %check if drivingTime is correct
        transition.new_color = 'bus_done';
        transition.override = 1;
        fire = 1;
    else
        fire = 0; 
    end
    return
    
 elseif(strcmp(transition.name, 'postChange_tRoutex60_complete'))
    tokID = tokenArrivedEarly('postChange_pOnRoutex60',1);
    colors = get_color('postChange_pOnRoutex60',tokID);
    startTime = str2double(colors{1});
    mediateTime = current_time() - startTime;
    tripTime = 13;
    
    if ge(mediateTime, tripTime) %check if drivingTime is correct
        transition.new_color = 'bus_done';
        transition.override = 1;
        fire = 1;
    else
        fire = 0;
    end
    return
    
 elseif(strcmp(transition.name, 'preChange_tRoutex60_complete'))
    tokID = tokenArrivedEarly('preChange_pOnRoutex60',1); %tokenArrivedEarly
    colors = get_color('preChange_pOnRoutex60',tokID);
    startTime = str2double(colors{1});
    mediateTime = current_time() - startTime;
    tripTime = 26;
    if ge(mediateTime, tripTime)   
       transition.new_color = 'switch';
       transition.override = 1;
       fire = 1;
    else
        fire = 0;
    end
    return
   
   
   
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
    return
    %Check if can fire
elseif(strcmp(transition.name, 'tLobby'))
    tokID = tokenAny('pHasParked',1);
    colors = get_color('pHasParked',tokID);
    if(strcmp(colors{1},'vehicle_done' )) %check if correct color
        fire = 1;
    else
        fire = 0;
    end
    return

 








% Must have this to trigger all other transitions
else
    fire = 1;
    return
end




