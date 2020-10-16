function areas_selection

% Call areas_selection_impl to select predefined areas/checkpoints 
areas_selection_impl;

% Dialog box
button = questdlg('Would you like to define another area?', ...
        'Area Selection', ...
        'Yes', 'No', 'Yes');
    
% The process is repeated until the user presses 'No'
while ~strcmp(button,'No')
    fprintf('[%s] User selected again to define a new area\n', datestr(datetime('now')))
    close all;              % close all figures
    areas_selection_impl;   % define a new area
    button = questdlg('Would you like to define another area?', ...
        'Area Selection', ...
        'Yes', 'No', 'Yes');
end
fprintf('[%s] User selected not to define new areas\n', datestr(datetime('now')))
close all;