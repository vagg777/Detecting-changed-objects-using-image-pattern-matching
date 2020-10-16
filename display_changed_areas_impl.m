function [filename1,filename2] = display_changed_areas_impl(I, J, changes)
% This function displays the user-selected predefined areas/checkpoints

% Use count_defined_areas function to count the number of areas
areas_count = count_defined_areas;
properties = get_global_properties;

% Dispay defined areas
for i = 1 : length(changes) % Loop for all areas
    % Read files with areas coordinations
    if exist(strcat('areas/polygon_x_coordinates_',sprintf( '%05d', changes(i)),'.dat'), 'file') == 2
        x_coord = csvread(strcat('areas/polygon_x_coordinates_',sprintf( '%05d', changes(i)),'.dat'));
        y_coord = csvread(strcat('areas/polygon_y_coordinates_',sprintf( '%05d', changes(i)),'.dat'));
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
        filepath_color = strcat(properties.risks_path,'risk_assessment_',sprintf( '%05d', changes(i)),'.mat');
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
            J = insertShape(J,'Polygon',pos_polygon, ...
                'Color', 'white', 'Opacity',0.8,'LineWidth',4);
        else
            switch hazard_severity_num_color
                case 1
                    if hazard_probability_num_color <= 4
                        I = insertShape(I,'Polygon',pos_polygon, ...
                            'Color', [0 176 80], 'Opacity',0.8,'LineWidth',4);
                        J = insertShape(J,'Polygon',pos_polygon, ...
                            'Color', [0 176 80], 'Opacity',0.8,'LineWidth',4);
                    elseif (hazard_probability_num_color > 4) && (hazard_probability_num_color <= 5)
                        I = insertShape(I,'Polygon',pos_polygon, ...
                            'Color', [146 208 80], 'Opacity',0.8,'LineWidth',4);
                        J = insertShape(J,'Polygon',pos_polygon, ...
                            'Color', [146 208 80], 'Opacity',0.8,'LineWidth',4);
                    else
                        I = insertShape(I,'Polygon',pos_polygon, ...
                            'Color', 'white', 'Opacity',0.8,'LineWidth',4);
                        J = insertShape(J,'Polygon',pos_polygon, ...
                            'Color', 'white', 'Opacity',0.8,'LineWidth',4);
                    end
                case 2
                    if hazard_probability_num_color <= 1
                        I = insertShape(I,'Polygon',pos_polygon, ...
                            'Color', [0 176 80], 'Opacity',0.8,'LineWidth',4);
                        J = insertShape(J,'Polygon',pos_polygon, ...
                            'Color', [0 176 80], 'Opacity',0.8,'LineWidth',4);
                    elseif (hazard_probability_num_color > 1) && (hazard_probability_num_color <= 4)
                        I = insertShape(I,'Polygon',pos_polygon, ...
                            'Color', [146 208 80], 'Opacity',0.8,'LineWidth',4);
                        J = insertShape(J,'Polygon',pos_polygon, ...
                            'Color', [146 208 80], 'Opacity',0.8,'LineWidth',4);
                    elseif (hazard_probability_num_color > 4) && (hazard_probability_num_color <= 5)
                        I = insertShape(I,'Polygon',pos_polygon, ...
                            'Color', [255 255 0], 'Opacity',0.8,'LineWidth',4);
                        J = insertShape(J,'Polygon',pos_polygon, ...
                            'Color', [255 255 0], 'Opacity',0.8,'LineWidth',4);
                    else
                        I = insertShape(I,'Polygon',pos_polygon, ...
                            'Color', 'white', 'Opacity',0.8,'LineWidth',4);
                        J = insertShape(J,'Polygon',pos_polygon, ...
                            'Color', 'white', 'Opacity',0.8,'LineWidth',4);
                    end
                case 3
                    if hazard_probability_num_color <= 2
                        I = insertShape(I,'Polygon',pos_polygon, ...
                            'Color', [146 208 80], 'Opacity',0.8,'LineWidth',4);
                        J = insertShape(J,'Polygon',pos_polygon, ...
                            'Color', [146 208 80], 'Opacity',0.8,'LineWidth',4);
                    elseif (hazard_probability_num_color > 2) && (hazard_probability_num_color <= 4)
                        I = insertShape(I,'Polygon',pos_polygon, ...
                            'Color', [255 255 0], 'Opacity',0.8,'LineWidth',4);
                        J = insertShape(J,'Polygon',pos_polygon, ...
                            'Color', [255 255 0], 'Opacity',0.8,'LineWidth',4);
                    elseif (hazard_probability_num_color > 4) && (hazard_probability_num_color <= 5)
                        I = insertShape(I,'Polygon',pos_polygon, ...
                            'Color', [255 102 0], 'Opacity',0.8,'LineWidth',4);
                        J = insertShape(J,'Polygon',pos_polygon, ...
                            'Color', [255 102 0], 'Opacity',0.8,'LineWidth',4);
                    else
                        I = insertShape(I,'Polygon',pos_polygon, ...
                            'Color', 'white', 'Opacity',0.8,'LineWidth',4);
                        J = insertShape(J,'Polygon',pos_polygon, ...
                            'Color', 'white', 'Opacity',0.8,'LineWidth',4);
                    end
                case 4
                    if hazard_probability_num_color <= 2
                        I = insertShape(I,'Polygon',pos_polygon, ...
                            'Color', [255 255 0], 'Opacity',0.8,'LineWidth',4);
                        J = insertShape(J,'Polygon',pos_polygon, ...
                            'Color', [255 255 0], 'Opacity',0.8,'LineWidth',4);
                    elseif (hazard_probability_num_color > 2) && (hazard_probability_num_color <= 4)
                        I = insertShape(I,'Polygon',pos_polygon, ...
                            'Color', [255 102 0], 'Opacity',0.8,'LineWidth',4);
                        J = insertShape(J,'Polygon',pos_polygon, ...
                            'Color', [255 102 0], 'Opacity',0.8,'LineWidth',4);
                    elseif (hazard_probability_num_color > 4) && (hazard_probability_num_color <= 5)
                        I = insertShape(I,'Polygon',pos_polygon, ...
                            'Color', [255 0 0], 'Opacity',0.8,'LineWidth',4);
                        J = insertShape(J,'Polygon',pos_polygon, ...
                            'Color', [255 0 0], 'Opacity',0.8,'LineWidth',4);
                    else
                        I = insertShape(I,'Polygon',pos_polygon, ...
                            'Color', 'white', 'Opacity',0.8,'LineWidth',4);
                        J = insertShape(J,'Polygon',pos_polygon, ...
                            'Color', 'white', 'Opacity',0.8,'LineWidth',4);
                    end
                case 5
                    if hazard_probability_num_color <= 3
                        I = insertShape(I,'Polygon',pos_polygon, ...
                            'Color', [255 102 0], 'Opacity',0.8,'LineWidth',4);
                        J = insertShape(J,'Polygon',pos_polygon, ...
                            'Color', [255 102 0], 'Opacity',0.8,'LineWidth',4);
                    elseif (hazard_probability_num_color > 3) && (hazard_probability_num_color <= 5)
                        I = insertShape(I,'Polygon',pos_polygon, ...
                            'Color', [255 0 0], 'Opacity',0.8,'LineWidth',4);
                        J = insertShape(J,'Polygon',pos_polygon, ...
                            'Color', [255 0 0], 'Opacity',0.8,'LineWidth',4);
                    else
                        I = insertShape(I,'Polygon',pos_polygon, ...
                            'Color', 'white', 'Opacity',0.8,'LineWidth',4);
                        J = insertShape(J,'Polygon',pos_polygon, ...
                            'Color', 'white', 'Opacity',0.8,'LineWidth',4);
                    end
                otherwise
                    I = insertShape(I,'Polygon',pos_polygon, ...
                        'Color', 'white', 'Opacity',0.8,'LineWidth',4);
                    J = insertShape(J,'Polygon',pos_polygon, ...
                        'Color', 'white', 'Opacity',0.8,'LineWidth',4);
            end
        end
        % Create labels in areas
        I = insertText(I,text_position,num2str(changes(i)), 'FontSize',20);
        J = insertText(J,text_position,num2str(changes(i)), 'FontSize',20);
        % Re-initiate polygon for next area
        pos_polygon = 0;
    else
        %fprintf("Area %d does not exist or has been previously deleted!!!\n",i)
    end
    
end

[m,n] = size(changes);    % get the number of changed areas
if (n==1)                 % 1 change
    fprintf('[%s] Our tool has detected changes in the following area:\n\n', datestr(datetime('now')))
else                      % multiple changes
    fprintf('[%s] Our tool has detected %d changes in the following areas:\n\n', datestr(datetime('now')), n)
end

for i = 1:n
    if i~=n fprintf('-  Changes have been detected in area: %s\n', int2str(changes(i)))
    else fprintf('-  Changes have been detected in area: %s\n\n', int2str(changes(i)))  % on the last iteration, add an extra '\n'
    end
end

% Display image and areas
warning('off', 'Images:initSize:adjustingMag');
image_compare_tool(I, J);
[filename1,filename2] = save_files(I,J);

end