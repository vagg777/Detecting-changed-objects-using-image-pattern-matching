function assess_risk_menu

properties = get_global_properties;

% Dialog box with user selection
list = {'Complete data for risk assessment','Display Risk schedule'};
[indx,tf] = listdlg('PromptString','RISK ASSESSMENT MENU - Select one of the following options:',...
    'SelectionMode','single','ListSize',[400,150],...
    'ListString',list);

% Handle user selection
if indx == 1
    fprintf('[%s] User selected to complete data for risk assessment\n', datestr(datetime('now')))
    assess_risk;          % Complete data for risk assessment
    close all;
elseif indx == 2
    [risk_areas_count, risk_areas_tables] = count_risk_areas;
    if risk_areas_count ~= 0
        display_area_risk_table(risk_areas_tables);
        fprintf('[%s] Displaying areas\'' risks\n', datestr(datetime('now')));
    else
        display_area_risk_table([]);
        fprintf('[%s] No areas\'' risks have been defined\n', datestr(datetime('now')));
    end
end