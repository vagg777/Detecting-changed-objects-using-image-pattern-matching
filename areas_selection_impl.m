function areas_selection_impl
% This function helps the user select predefined areas/checkpoints

% Include defined areas in image
image = include_areas_in_image;
% Read global parameters
properties = get_global_properties;
% Use count_defined_areas function to count the number of areas
areas_count = count_defined_areas;
% Use zoom tool to display the image and select a new area
warning('off', 'Images:initSize:adjustingMag');
f = image_zoom_tool(image);

% Mark a polygon with the new area
[x_new_area,y_new_area] = getline(f, 'closed');
% Save the x and y coordinates in areas folder

Directory=dir(['areas', '/*.dat']);

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
areas_possible_number = max + 1;

for i = 1 : areas_possible_number
    current_filename=strcat(properties.areas_path,'polygon_x_coordinates_',sprintf( '%05d', i),'.dat');
    if exist(current_filename, 'file') == 2
        % no one cares
    else
        csvwrite(strcat(properties.areas_path,'polygon_x_coordinates_',sprintf( '%05d', i),'.dat'),x_new_area);
        csvwrite(strcat(properties.areas_path,'polygon_y_coordinates_',sprintf( '%05d', i),'.dat'),y_new_area);
        fprintf('[%s] Area %d successfully defined\n', datestr(datetime('now')), i);
        break;
    end
end

