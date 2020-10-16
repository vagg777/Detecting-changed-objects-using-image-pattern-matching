function [I] = include_areas_in_image
% This function displays the user-selected predefined areas/checkpoints
% Read the initial image
f = waitbar(0,'[0%] Please wait...');
pause(.5)

waitbar(.10,f,'[10%] Loading your data');
pause(.5)

properties = get_global_properties;
I = imread([properties.images_path properties.initial_image]);

% Use count_defined_areas function to count the number of areas
areas_count = count_defined_areas;
% Display defined areas
waitbar(.20,f,'[20%] Processing your data');
if areas_count > 0
    for i = 1 : areas_count % Loop for all areas
        if i==round(areas_count*0.3) waitbar(.3,f,'[30%] Processing your data');        
        elseif i==round(areas_count*0.6) waitbar(.6,f,'[60%] Processing your data');     
        elseif i==round(areas_count*0.9) waitbar(.9,f,'[90%] Processing your data');     
        end
        % Read files with areas coordinations
        if exist(strcat('areas/polygon_x_coordinates_',sprintf( '%05d', i),'.dat'), 'file') == 2
            x_coord = csvread(strcat('areas/polygon_x_coordinates_',sprintf( '%05d', i),'.dat'));
            y_coord = csvread(strcat('areas/polygon_y_coordinates_',sprintf( '%05d', i),'.dat'));
            [m_x, n_x] = size(x_coord);
            [m_y, n_y] = size(y_coord);
            % Initiate polygon for insertShape function
            pos_polygon = zeros(1,m_x+m_y);
            % Creating polygon
            counter = 1;
            for j = 1 : m_y
                pos_polygon(1,counter) = x_coord(j);
                counter = counter + 1;
                pos_polygon(1,counter) = y_coord(j);
                counter = counter + 1;
            end
            % Create label coordinates
            text_position = [pos_polygon(1,1) pos_polygon(1,2)];
            % Inserts all areas in the initial image
            filepath_color = strcat(properties.risks_path,'risk_assessment_',sprintf( '%05d', i),'.mat');
            if exist(filepath_color) == 2
                data_color = load(filepath_color);
                hazard_severity_num_color = str2double(char(strcat(num2str(data_color.hazard_severity))));
                hazard_probability_num_color = str2double(char(strcat(num2str(data_color.hazard_probability))));
            else
                hazard_severity_num_color = 0;
                hazard_probability_num_color = 0;
            end
            if hazard_severity_num_color == 0
                I = insertShape(I,'Polygon',pos_polygon, ...
                    'Color', 'white', 'Opacity',0.8,'LineWidth',4);
            else
                switch hazard_severity_num_color
                    case 1
                        if hazard_probability_num_color <= 4
                            I = insertShape(I,'Polygon',pos_polygon, ...
                                'Color', [0 176 80], 'Opacity',0.8,'LineWidth',4);
                        elseif (hazard_probability_num_color > 4) && (hazard_probability_num_color <= 5)
                            I = insertShape(I,'Polygon',pos_polygon, ...
                                'Color', [146 208 80], 'Opacity',0.8,'LineWidth',4);
                        else
                            I = insertShape(I,'Polygon',pos_polygon, ...
                                'Color', 'white', 'Opacity',0.8,'LineWidth',4);
                        end
                    case 2
                        if hazard_probability_num_color <= 1
                            I = insertShape(I,'Polygon',pos_polygon, ...
                                'Color', [0 176 80], 'Opacity',0.8,'LineWidth',4);
                        elseif (hazard_probability_num_color > 1) && (hazard_probability_num_color <= 4)
                            I = insertShape(I,'Polygon',pos_polygon, ...
                                'Color', [146 208 80], 'Opacity',0.8,'LineWidth',4);
                        elseif (hazard_probability_num_color > 4) && (hazard_probability_num_color <= 5)
                            I = insertShape(I,'Polygon',pos_polygon, ...
                                'Color', [255 255 0], 'Opacity',0.8,'LineWidth',4);
                        else
                            I = insertShape(I,'Polygon',pos_polygon, ...
                                'Color', 'white', 'Opacity',0.8,'LineWidth',4);
                        end
                    case 3
                        if hazard_probability_num_color <= 2
                            I = insertShape(I,'Polygon',pos_polygon, ...
                                'Color', [146 208 80], 'Opacity',0.8,'LineWidth',4);
                        elseif (hazard_probability_num_color > 2) && (hazard_probability_num_color <= 4)
                            I = insertShape(I,'Polygon',pos_polygon, ...
                                'Color', [255 255 0], 'Opacity',0.8,'LineWidth',4);
                        elseif (hazard_probability_num_color > 4) && (hazard_probability_num_color <= 5)
                            I = insertShape(I,'Polygon',pos_polygon, ...
                                'Color', [255 102 0], 'Opacity',0.8,'LineWidth',4);
                        else
                            I = insertShape(I,'Polygon',pos_polygon, ...
                                'Color', 'white', 'Opacity',0.8,'LineWidth',4);
                        end
                    case 4
                        if hazard_probability_num_color <= 2
                            I = insertShape(I,'Polygon',pos_polygon, ...
                                'Color', [255 255 0], 'Opacity',0.8,'LineWidth',4);
                        elseif (hazard_probability_num_color > 2) && (hazard_probability_num_color <= 4)
                            I = insertShape(I,'Polygon',pos_polygon, ...
                                'Color', [255 102 0], 'Opacity',0.8,'LineWidth',4);
                        elseif (hazard_probability_num_color > 4) && (hazard_probability_num_color <= 5)
                            I = insertShape(I,'Polygon',pos_polygon, ...
                                'Color', [255 0 0], 'Opacity',0.8,'LineWidth',4);
                        else
                            I = insertShape(I,'Polygon',pos_polygon, ...
                                'Color', 'white', 'Opacity',0.8,'LineWidth',4);
                        end
                    case 5
                        if hazard_probability_num_color <= 3
                            I = insertShape(I,'Polygon',pos_polygon, ...
                                'Color', [255 102 0], 'Opacity',0.8,'LineWidth',4);
                        elseif (hazard_probability_num_color > 3) && (hazard_probability_num_color <= 5)
                            I = insertShape(I,'Polygon',pos_polygon, ...
                                'Color', [255 0 0], 'Opacity',0.8,'LineWidth',4);
                        else
                            I = insertShape(I,'Polygon',pos_polygon, ...
                                'Color', 'white', 'Opacity',0.8,'LineWidth',4);
                        end
                    otherwise
                        I = insertShape(I,'Polygon',pos_polygon, ...
                            'Color', 'white', 'Opacity',0.8,'LineWidth',4);
                end
            end
            % Create labels in areas
            I = insertText(I,text_position,num2str(i), 'FontSize',20);
            % Re-initiate polygon for next area
            pos_polygon = 0;
        else
            %fprintf("Area %d does not exist or has been previously deleted!!!\n",i)
        end
    end
else
    fprintf('[%s] No areas have been defined\n', datestr(datetime('now')))
end
waitbar(1,f,'[100%] Finished!');
pause(0.5)
close(f)

fprintf('[%s] A total of %d defined areas is displayed\n', datestr(datetime('now')), areas_count)
