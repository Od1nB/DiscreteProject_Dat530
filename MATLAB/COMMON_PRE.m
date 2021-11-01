function[fire, transition] = COMMON_PRE(transition)
global global_info;

%pWait = ntokens('pWait'); %check how many items tokens in pWait if
%neccesary

%Check if can fire
if(strcmp(transition.name, 'tPick_up_bus_from_parking'))
    transition.new_color = 'bus';
    fire = 1;
end
%Check if can fire
if(strcmp(transition.name, 'tPick_up_car'))
    transition.new_color = 'vehicle';
    fire = 1;
end