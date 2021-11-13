%
% Module 1: Generator pdf
% Kolumbus 
%
% October 2021
% Brynjar Ulriksen Steinbakk, Tor-Fredrik Torgersen, Odin Bjørnebo
function [png] = generator_pdf()
png.PN_name = 'Generator module';
png.set_of_Ps = {'pNumberOfRounds','pAdministration'};
png.set_of_Ts = {'tGenerator'};
png.set_of_As = {
                 'pNumberOfRounds','tGenerator',1, ...
                 'tGenerator','pAdministration', 16
                };

