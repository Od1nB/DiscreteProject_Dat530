function [fire, transition] = tBusDriverGenerator_pre(transition)
%TBUSDRIVERGENERATOR Summary of this function goes here
%   Detailed explanation goes here
global global_info

time_to_generate_token = global_info.tokens_firing_times;
ctime = current_time();

%if lt(ctime, time_to_generate_token) %Not time to fire
%    fire = 0; return
%end

if lt(ctime, time_to_generate_token)
    n = timesfired('tBusDriverGenerator');
    %m = ["before",n];
    %disp(m);
    fire = lt(n,8);
    %if  lt(n, 2)
    %    fire = 1;
    %    return
    %end
    %fire = lt(n, 8);
elseif gt(ctime, time_to_generate_token)
    n = timesfired('tBusDriverGenerator');
    %m = ["after",n];
    %disp(m);
    fire = lt(n,18);
    %if  lt(n, 4)
    %    fire = 1;
    %    return
    %end
    %fire = lt(n, 16);
    %return
else
    fire = 0;
end
%else
%    d = ["ctime",ctime,"timetogenerate", time_to_generate_token,"gt",gt(ctime, time_to_generate_token)];
%    disp(d);
%    fire = 0;
%end
