function [fire, transition] = tNextStop(transition)
%TNEXTSTOP Summary of this function goes here
%   Detailed explanation goes here
tokID = tokenAny('pstop', 1);
colors = get_color('pstop',tokID);

transition.new_color = num2str(colors + 1);

fire = 1;


