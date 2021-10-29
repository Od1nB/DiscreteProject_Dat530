function [busNr, departures, routeTime, deviation, changeDriver,...
    changeDriverStop, changeDriverTime] = loadData(file)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
% This file loads data from the 'busRoutes' excel file, and prepares it for
% the main file.
%
% INPUT PARAMETERS:
%   file = fileName (the excel file name where data is stored)
%
% OUTPUT PARAMETERS: 
%   busNr = The number of the bus line (string, because some buses have
%   letters (x60))
%   departures = How many departures per hour for this bus line (int)
%   routeTime = How long does the route take? (int)
%   deviation = How many minutes off schedule time is the bus on average?
%   (int)
%   changeDriver = Will the bus change driver during the route? 1/0
%   changeDriverStop = The name of the bus stop where driver change happens
%   (string)
%   changeDriverTime = How many minutes after start does the driver change
%   happen (int)
%


busRouteName = {"2","4","6","X60"}; %the bus routes we will compare
[num,txt,raw] = xlsread('busRoutes.xlsx'); %file = 'busRoutes.xlsx'
disp(raw);
busNr = [];
departures = [];
routeTime=[];
deviation=[];
changeDriver=[];
changeDriverStop=[];
changeDriverTime=[];
a = 0; % Index tracker
% What do I want to do with the data?
for i=(1:size(raw,1))
    disp(raw(i,1));
    currentBus = int2str(raw(i,1));
    if strcmp(currentBus,'6')
        disp("im here");
        a=a+1;
        DEP(a) = raw(i,2);
        RouteTime(a) = raw(i,3);
        disp(DEP);
        disp(RouteTime);
    end
end       
    

