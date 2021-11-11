function[fire, transition] = COMMON_PRE(transition)
% function [fire, trans] = COMMON_PRE(trans)
global global_info;
%pWait = ntokens('pWait'); %check how many items tokens in pWait if
%neccesary

%Module 1 Generation
if (strcmp(transition.name, 'tGenerator'))
    fire = 1; 
    return
end
if (strcmp(transition.name, 'tBusDriverGenerator')) 
    % if the enabled transition is "tBusDriverGenerator", just exit, as 
    % conditions for its firing are coded in  its own 
    % specific file "tBusDriverGenerator.m"
    fire = 1;
    return
end

%Module 2 preparation 

%Check if can fire
if(strcmp(transition.name, 'tPick_up_bus_from_parking'))
    tokID = tokenAny('pWait',1);
    if (tokID == 0)
        fire = tokID;
        return
    end
    transition.new_color = 'bus';
    transition.selected_tokens =tokID;
    fire = tokID;
    return
%Check if can fire
elseif(strcmp(transition.name, 'tPick_up_car'))
    transition.new_color = 'vehicle';
    transition.override =1;
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
   avgDelay = 0.67; %40 seconds from Kolumbus
   diffTime = normrnd(avgDelay, 2.08); %125s std.dev delay from Kolumbus
   curr = curr + diffTime;
   transition.new_color = num2str(curr);
   transition.selected_tokens =tokenID;
   fire = (tokenID);
   end
   return
elseif (strcmp(transition.name, 'tRoute5'))
   tokenID = tokenAllColor('pBussdriver', 1, {'bus'});
   if( tokenID == 0)
       fire = 0;
   else
   transition.override = 1;
   curr = current_time();
    avgDelay = 1.68; %111 seconds from Kolumbus
   diffTime = normrnd(avgDelay, 4.06); %244s std.dev delay from Kolumbus
   if le(diffTime, -2)
       diffTime = -2;
   end
   curr = curr + diffTime; 
    transition.new_color = num2str(curr);
   transition.selected_tokens =tokenID;
   fire = (tokenID);
   end
   return
elseif (strcmp(transition.name, 'tRoute6'))
   tokenID = tokenAllColor('pBussdriver', 1, {'bus'});
   if( tokenID == 0)
       fire = 0;
   else
   transition.override = 1;
   curr = current_time();
   avgDelay = 1.8; %+112 seconds
   diffTime = normrnd(avgDelay,2.73); % +-164 seconds from Kolumbus
   curr = curr + diffTime;
   transition.new_color = num2str(curr);
   transition.selected_tokens =tokenID;
   fire = (tokenID);
   end
   return
   
elseif (strcmp(transition.name, 'preChange_tRoutex60'))
   tokenID = tokenAllColor('pBussdriver', 1, {'bus'});
   if( tokenID == 0)
       fire = 0;
   else
   transition.override = 1;
   curr = current_time();
    avgDelay = 0.85;
    diffTime = normrnd(avgDelay,2.24);
    curr = curr + diffTime;
   transition.new_color = num2str(curr);
   transition.selected_tokens =tokenID;
   fire = (tokenID);
   end
   return
   
elseif (strcmp(transition.name, 'postChange_tRoutex60'))
   tokenID = tokenAllColor('pBussdriver', 1, {'switch'});
   if( tokenID == 0)
       fire = 0;
   else
   transition.override = 1;
   curr = current_time();
   avgDelay = 0.42; %25 seconds 
    diffTime = normrnd(avgDelay, 1.12); 
   curr = curr + diffTime;
   transition.new_color = num2str(curr);
   transition.selected_tokens = tokenID;
   fire = (tokenID);
   end
   return
%Check if can fire
elseif(strcmp(transition.name, 'tDriveToBusStopBus'))
     tokID = tokenAllColor('pRoutes', 1, {'bus'});
     fire = tokID;
    return


%Check if can fire
elseif(strcmp(transition.name, 'tDriveToBusStopCar'))
    tokID = tokenAllColor('pRoutes', 1, {'vehicle'});
     fire = tokID;
    return

%Check if can fire
elseif(strcmp(transition.name, 'tTakeBusToParking'))
    tokID = tokenAllColor('pLastStop', 1, {'bus_done'});
    fire = tokID;
    return


%Check if can fire
elseif(strcmp(transition.name, 'tChangeDriver'))
    tokID = tokenAllColor('pLastStop', 1, {'switch'});
    tokID2 = tokenAny('pArriveAtBusStop',1);
    if(tokID ~= 0)
        if(tokID2 ~=0)
            fire = tokID;
            return
        end 
    end
    fire = 0;
    


%Check if can fire
elseif(strcmp(transition.name, 'tTakeCarToParking'))
   tokID = tokenAny('pInCar',1);
   transition.new_color = 'vehicle_done';
   transition.override = 1;
   fire = tokID;
   return

 %Module 4 Driving
 elseif(strcmp(transition.name, 'tRoute3_complete'))
    tokID1 = tokenArrivedEarly('pOnRoute3',1); %tokenAny -> tokenArrivedEarly
    colors = get_color('pOnRoute3',tokID1);
    startTime = str2double(colors{1});
    mediateTime = current_time() - startTime;
    tripTime = 60; 
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
    tokID1 = tokenArrivedEarly('pOnRoute5',1);
    colors = get_color('pOnRoute5',tokID1);
    startTime = str2double(colors{1});
    mediateTime = current_time() - startTime;
    tripTime = 18;
    if ge(mediateTime, tripTime) %check if drivingTime is correct
        transition.selected_tokens = tokID1;
        transition.new_color = 'bus_done';
        transition.override = 1;
        fire = (tokID1);
    else
        fire = 0; 
    end
    return
    
 elseif(strcmp(transition.name, 'tRoute6_complete'))
    tokID1 = tokenArrivedEarly('pOnRoute6',1);
    colors = get_color('pOnRoute6',tokID1);
    startTime = str2double(colors{1});
    mediateTime = current_time() - startTime;
    tripTime = 38;
    if ge(mediateTime, tripTime) %check if drivingTime is correct
        transition.selected_tokens = tokID1; 
        transition.new_color = 'bus_done';
        transition.override = 1;
        fire = (tokID1);
    else
        fire = 0; 
    end
    return
    
 elseif(strcmp(transition.name, 'postChange_tRoutex60_complete'))
    tokID1 = tokenArrivedEarly('postChange_pOnRoutex60',1);
    colors = get_color('postChange_pOnRoutex60',tokID1);
    startTime = str2double(colors{1});
    mediateTime = current_time() - startTime;
    tripTime = 13;
    if ge(mediateTime, tripTime) %check if drivingTime is correct
        transition.selected_tokens = tokID1;
        transition.new_color = 'bus_done';
        transition.override = 1;
        fire = (tokID1);
    else
        fire = 0;
    end
    return
    
 elseif(strcmp(transition.name, 'preChange_tRoutex60_complete'))
    tokID1 = tokenArrivedEarly('preChange_pOnRoutex60',1); %tokenArrivedEarly
    colors = get_color('preChange_pOnRoutex60',tokID1);
    startTime = str2double(colors{1});
    mediateTime = current_time() - startTime;
    tripTime = 26;
    if ge(mediateTime, tripTime)   
       transition.selected_tokens = tokID1; 
       transition.new_color = 'switch';
       transition.override = 1;
       fire = (tokID1);
    else
        fire = 0;
    end
    return
   
   
   
%module 5 cleanup

%Check if can fire
elseif(strcmp(transition.name, 'tWait'))
    tokID = tokenAllColor('pHasParked', 1, {'bus_done'});
    fire = tokID;
    return
    %Check if can fire
elseif(strcmp(transition.name, 'tLobby'))
    tokID = tokenAllColor('pHasParked', 1, {'vehicle_done'});
    fire = tokID;
    return
    


% Must have this to trigger all other transitions
else
    fire = 1;
    return
end




