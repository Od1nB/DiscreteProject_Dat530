function [fire, transition] = MOD_cleanup_PRE(transition)

if (strcmp(transition.name, 'tWait')) 
    fire =1;
elseif (strcmp(transition.name,'tLobby'))
    fire =1;
else
    error('transition name does not match')
end
    