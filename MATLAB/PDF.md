# PDFs
For making petrinet modules you first need to make a PDF to describe your system.

These are made as MATLAB functions, start with something like this

```function [png] = modulename_PDF() ``` \
set a name \
```png.PN_name = 'Module Name';``` \
define your nodes: \
```png.set_of_Ps = {'pNode1', 'pNode2', 'pNode3'};``` \
then define your transactions: \
```png.set_of_Ts = {'tIN','tOUT','tNEXT'};``` \
Then you should set the arcs between each of the transitions and nodes. This is a spot where it is easy write an error, and the MATLAB compiler will not help you with
petrinet compile erros. So to be sure, write the arcs like this `'pNode1', tTransition1, 1, ...` and then do a newline, so it is easier to spot an error. First variable is
from, second is to and third is difficulty/time, and continue until you have something like this: \
```
png.set_of_As = {'pNode1','tIn',1,...
                  'tIn','pNode2',1,...
                  ...
```

Then the total file will look something like this: \
``` MATLAB
function [png] = modulename_PDF()
png.PN_name = 'Module Name';
png.set_of_Ps = {'pNode1', 'pNode2', 'pNode3'};
png.set_of_Ts = {'tIN','tOUT','tNEXT'}; 
png.set_of_As = {'pNode1','tIn',1,...
                  'tIn','pNode2',1,...
                  ...};
```
