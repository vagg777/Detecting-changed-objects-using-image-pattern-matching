function [areas_count] = count_defined_areas

%delete(strcat(properties.areas_path,'polygon_x_coordinates_',sprintf( '%05d', selectedArea),'.dat'));
Directory=dir(['areas', '/*.dat']);
%FileList=size(Directory,1);
%areas_count = FileList/2;
max=0;
for file = Directory'
    %current_file = load("areas/",file.name);
    filename = file.name;
    first_split = strsplit(filename,"coordinates_");
    second_split = strsplit(char(first_split(1,2)),".dat");
    area_string = char( second_split(1,1));
    area_int = str2num(area_string);
    if (area_int > max) 
        max = area_int;
    end
end
areas_count = max;