function [png] = preparation_pdf()
%PREPARATION_pdf is the petri net definition of module 2
%  
png.PN_name = 'Module 2 Preparation';
png.set_of_Ps = {'pWait', 'pvehicle_ready'};
png.set_of_Ts = {'tPick_up_bus_from_parking', 'tPick_up_car'};
png.set_of_As = {'pWait', 'tPick_up_bus_from_parking', 1,...
                 'pWait', 'tPick_up_car', 1,...
                 'tPick_up_bus_from_parking', 'pvehicle_ready', 1,...
                 'tPick_up_car', 'pvehicle_ready', 1};

