function save_risks_impl(user_input)

[properties] = get_global_properties;

selected_areas = 0;
hazard_type = user_input.hazard_type;
hazard_severity = str2num(user_input.hazard_severity);
hazard_probability = str2num(user_input.hazard_probability);
risk_assessment = hazard_severity * hazard_probability;
comments = user_input.comments;

if ~isempty(strfind(user_input.selected_areas,','))
    areas_total = strsplit(erase(user_input.selected_areas," "),',');
    for i = 1 : length(areas_total)
        current_filename=strcat(properties.risks_path,'risk_assessment_',sprintf( '%05d', str2num(string(areas_total(i)))),'.mat');
        selected_areas = str2num(string(areas_total(i)));
        save(current_filename,'selected_areas','hazard_type','hazard_probability','hazard_severity','risk_assessment','comments');
    end
elseif  ~isempty(strfind(user_input.selected_areas,'-'))
    areas_total = strsplit(erase(user_input.selected_areas," "),'-');
    for i = str2num(string(areas_total(1))) : str2num(string(areas_total(2)))
        current_filename=strcat(properties.risks_path,'risk_assessment_',sprintf( '%05d', i),'.mat');
        selected_areas = i;
        save(current_filename,'selected_areas','hazard_type','hazard_probability','hazard_severity','risk_assessment','comments');
    end
else
    areas_total = strsplit(user_input.selected_areas);
    for i = 1 : length(areas_total)
        current_filename=strcat(properties.risks_path,'risk_assessment_',sprintf( '%05d', str2num(string(areas_total(i)))),'.mat');
        selected_areas = str2num(string(areas_total(i)));
        save(current_filename,'selected_areas','hazard_type','hazard_probability','hazard_severity','risk_assessment','comments');
    end
end