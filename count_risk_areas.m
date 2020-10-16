function [risk_areas_count, risk_areas_tables] = count_risk_areas

%delete(strcat(properties.areas_path,'polygon_x_coordinates_',sprintf( '%05d', selectedArea),'.dat'));
Directory=dir(['risks', '/*.mat']);
%FileList=size(Directory,1);
%areas_count = FileList/2;
risk_areas_count=0;
risk_areas_tables=[];
for file = Directory'
    %current_file = load("risks/"+file.name);
    filename = file.name;
    first_split = strsplit(filename,"risk_assessment_");
    second_split = strsplit(char(first_split(1,2)),".mat");
    area_string = char( second_split(1,1));
    area_int = str2num(area_string);
    risk_areas_tables(risk_areas_count + 1) = area_int;
    risk_areas_count = risk_areas_count + 1;
end
