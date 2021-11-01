%
% Cleanup pdf file for
% Kolumbus 
%
% October 2021
% Brynjar Ulriksen Steinbakk, Tor-Fredrik Torgersen, Odin Bjørnebo
function [png] = cleanup_pdf()
png.PN_name = 'Cleanup module';
png.set_of_Ps = {'pHasParked','pAdminLobby','pCheckedOut'};
png.set_of_Ts = {'tWait', 'tLobby','tCheckOut'};
png.set_of_As = {
                 'pHasParked','tWait',1,...
                 'pHasParked','tLobby',1,...
                 'tWait','pAdminLobby',1,...
                 'tLobby','pAdminLobby',1,...
                 'pAdminLobby','tCheckOut',1,...
                 'tCheckOut','pCheckedOut',1};
end

