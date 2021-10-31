%
% connector pdf file for
% Kolumbus 
%
% October 2021
% Brynjar Ulriksen Steinbakk, Tor-Fredrik Torgersen, Odin Bjørnebo
function[png] = connector_pdf()
png.PN_name='main';
png.set_of_Ps = {};
png.set_of_Ts = {'tCONNECT1','tCONNECT2','tCONNECT3','tCONNECT4','tCONNECT5'};
png.set_of_As = {'pAdministration','tCONNECT1',1,'tCONNECT1','pWait',1, ...
    'pvehicle_ready','tCONNECT2',1,'tCONNECT2','pRoutes',1, ...
    'pStartRoute','tCONNECT3',1,'tCONNECT3','pBussdriver',1,...
    'pBussRouteDone','tCONNECT4',1,'tCONNECT4','pLastStop',1,...
    'pVehicleParked','tCONNECT5',1,'tCONNECT5','pHasParked',1,};