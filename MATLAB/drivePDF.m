
function [png] = drivePDF() 
png.PN_name = 'Drive Module';
png.set_of_Ps = {'pstartR', 'pStopRoute', 'pstop'};
png.set_of_Ts = {'tIn','tOut','tNextStop'}; 
png.set_of_As = {'pStartRoute','tIn',1, 'tIn','pstop',1,... 
             'pstop','tNextStop',1, 'tNextStop','pstop',1,... 
             'pstop','tOut',1, 'tout','pStopRoute'};
end

