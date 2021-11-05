%
% generator pdf file for
% Kolumbus 
%
% October 2021
% Brynjar Ulriksen Steinbakk, Tor-Fredrik Torgersen, Odin Bjørnebo
function [png] = generator_pdf()
png.PN_name = 'Generator module';
png.set_of_Ps = {'pAdministration', 'pTotalBusDrivers'};
png.set_of_Ts = {'tBusDriverGenerator'};
png.set_of_As = {'tBusDriverGenerator','pAdministration',1, ...
    'pTotalBusDrivers','tBusDriverGenerator',1};
end

