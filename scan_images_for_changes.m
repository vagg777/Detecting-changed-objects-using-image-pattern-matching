function [changed_areas] = scan_images_for_changes(changes_image)
f = waitbar(0,'[0%] Please wait...');
pause(.5)

waitbar(.10,f,'[10%] Counting defined areas');
pause(.5)

% Use count_defined_areas function to count the number of areas
areas_count = count_defined_areas;

waitbar(.20,f,'[20%] Converting image');
% Convert changes image to double
changes_image_double = im2double(changes_image);
% Apply threshold to ignore minor changes in areas
changes_image_double(changes_image_double<0.05) = 0;
% Add R, G, B dimensions in one array
changes_image_cat = changes_image_double(:,:,1) + changes_image_double(:,:,2) + changes_image_double(:,:,3);
% Get changes_image size
[m,n,k] = size(changes_image);

% Index to count changed areas
count = 1;
% Initialize changed_areas matrix
changed_areas = 0;
count = 1;

for i = 1 : 10 : m % Scan image in x-axis
    if i<=round(m*0.3) waitbar(.3,f,'[30%] Searching for changes');  
    elseif i<=round(m*0.5) waitbar(.5,f,'[50%] Searching for changes');        
    elseif i<=round(m*0.7) waitbar(.7,f,'[70%] Searching for changes');     
    elseif i<=round(m*0.9) waitbar(.9,f,'[90%] Searching for changes');
    end
    for j = 1 : 10 : n % Scan image in y-axis
        if changes_image_cat(i,j) ~= 0 % if there are changes in the specific pixel
            for k = 1 : areas_count % Loop for all areas
                % Read files with areas coordinations
                if exist(strcat('areas/polygon_x_coordinates_',sprintf( '%05d', k),'.dat'), 'file') == 2
                    x_coord = csvread(strcat('areas/polygon_x_coordinates_',sprintf( '%05d', k),'.dat'));
                    y_coord = csvread(strcat('areas/polygon_y_coordinates_',sprintf( '%05d', k),'.dat'));
                    if inpolygon(j,i,x_coord,y_coord) % Check if pixel that changed is inside any area
                        changed_areas(count) = k; % add area to changed_areas array
                        count = count + 1;
                    end
                    x_coord = 0; y_coord = 0; % Initialize for next loop
                else
                    %fprintf("Area %d does not exist or has been previously deleted!!!\n",k)
                end
            end
        end
    end
end

% Remove duplicates from changed_areas array
changed_areas = unique(changed_areas);
waitbar(1,f,'[100%] Finished!');
pause(0.5)
close(f)
end
