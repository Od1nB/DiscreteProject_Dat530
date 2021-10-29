clear all; clc;

pns = pnstruct('drive_PDF');

dyn.m0 = {'pStartRoute', 1};
%dyn.m0 = {'pStartRoute', 1, 'pstop',0, 'pLastStop',0};
dyn.ft = {'allothers', 5}; 
pni = initialdynamics(pns, dyn);
sim = gpensim(pni);

prncolormap(sim);
prnfinalcolors(sim); 