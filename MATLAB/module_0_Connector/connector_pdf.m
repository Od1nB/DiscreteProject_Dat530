%
% connector pdf file for
% Kolumbus 
%
% October 2021
% Brynjar Ulriksen Steinbakk, Tor-Fredrik Torgersen, Odin Bjørnebo
function[png] = connector_pdf()
png.PN_name='main';
png.set_of_Ps = {};
png.set_of_Ts = {'tCONNECT1','tCONNECT2','tCONNECT3'};
png.set_of_As = {'pLOBBY','tCONNECT1',1,'tCONNECT1','pCHECK_IN',1, ...
    'pCHECK_OUT','tCONNECT2',1,'tCONNECT2','pSEC_IN',1, ...
    'pSEC_OUT','tCONNECT3',1,'tCONNECT3','pPASS_IN',1,};