function [busNr, departures, routeTime, deviation, changeDriver,...
    changeDriverStop, changeDriverTime] = loadData(file)
busRoutes = {"2","4","6","X60"};

[num,txt,raw] = xlsread(file);
busNr = [];
departures = [];
routeTime=[];
deviation=[];
changeDriver=[];
changeDriverStop=[];
changeDriverTime=[];

