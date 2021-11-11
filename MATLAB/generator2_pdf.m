%
% generator pdf file for
% Kolumbus 
%
% October 2021
% Brynjar Ulriksen Steinbakk, Tor-Fredrik Torgersen, Odin Bjørnebo
function [png] = generator2_pdf()
png.PN_name = 'Generator2 module';
png.set_of_Ps = {'pNumberOfRounds','pAdministration'};
png.set_of_Ts = {'tGenerator'};
png.set_of_As = {'pNumberOfRounds','tGenerator',1, ...
    'tGenerator','pAdministration',16};
end

