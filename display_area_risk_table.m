function display_area_risk_table(changed_areas)

properties = get_global_properties;
final_table = cell(1,6);

figure('Name','Risk schedule','NumberTitle','off');
headers = {'<html><center>Area</center></html>', ...
    '<html><center>Hazard<br />type</center></html>', ...
    '<html><center>Probability<br />(A)</center></html>', ...
    '<html><center>Severity<br />(B)</center></html>', ...
    '<html><center>Risk assessment<br />(A x B)</center></html>', ...
    'Comments'};

Directory=dir(['risks', '/*.mat']);
i=1;
%FileList=size(Directory,1);
%areas_count = FileList/2;
[m,n] = size(changed_areas);
areas_with_no_table_count = 0;
areas_with_no_table = 0;
k = 1;
for j = 1:n % Loop for all changed areas
    filepath = strcat(properties.risks_path,'risk_assessment_',sprintf( '%05d', changed_areas(j)),'.mat');
    if exist(filepath) == 2
        data = load(filepath);
        data.hazard_type = strcat('''',data.hazard_type,'''');
        data.comments = strcat('''',data.comments,'''');
        data.hazard_severity = strcat('<html><center>',num2str(data.hazard_severity),'</center></html>');
        data.selected_areas = strcat('<html><center>',num2str(data.selected_areas),'</center></html>');
        data.hazard_probability = strcat('<html><center>',num2str(data.hazard_probability),'</center></html>');
        data.risk_assessment = strcat('<html><center>',num2str(data.risk_assessment),'</center></html>');
        data1{1,1} = data.selected_areas;
        data1{1,2} = data.hazard_type;
        data1{1,3} = data.hazard_probability;
        data1{1,4} = data.hazard_severity;
        data1{1,5} = data.risk_assessment;
        data1{1,6} = data.comments;
        %data1 = data1.';
        final_table(i,:) = data1;
        i=i+1;
    else
        areas_with_no_table_count = areas_with_no_table_count + 1;
        areas_with_no_table(areas_with_no_table_count) = changed_areas(j);
    end
end

hTable = uitable('Data',final_table, 'ColumnEditable',false, ...
    'ColumnName',headers, 'RowName',[], ...
    'ColumnWidth','auto', 'FontWeight', 'bold',...
    'Units','norm', 'Position',[0,.10,1,.85]);

jScroll = findjobj(hTable);
jTable = jScroll.getViewport.getView;
jTable.setAutoResizeMode(jTable.AUTO_RESIZE_SUBSEQUENT_COLUMNS);
javaaddpath('archive/ColoredFieldCellRenderer.zip');
cr = ColoredFieldCellRenderer(java.awt.Color.white);
cr.setDisabled(true);  % to bg-color the entire column

if ~isempty(final_table{1,1})
    
    % Set specific cell colors (background and/or foreground)
    for rowIdx = 1 : size(final_table,1)
        % Background for significant rows based on risk_assessment
        hazard_probability_html = string(final_table(rowIdx,3));
        first_split_hazard_probability = strsplit(hazard_probability_html,"<html><center>");
        second_split_hazard_probability = strsplit(char(first_split_hazard_probability(1,2)),"</center></html>");
        hazard_probability_string = char( second_split_hazard_probability(1,1));
        hazard_probability_num = str2double(hazard_probability_string);
        
        hazard_severity_html = string(final_table(rowIdx,4));
        first_split_hazard_severity = strsplit(hazard_severity_html,"<html><center>");
        second_split_hazard_severity = strsplit(char(first_split_hazard_severity(1,2)),"</center></html>");
        hazard_severity_string = char( second_split_hazard_severity(1,1));
        hazard_severity_num = str2double(hazard_severity_string);
        
        selected_areas_html = string(final_table(rowIdx,1));
        first_split_selected_areas = strsplit(selected_areas_html,"<html><center>");
        second_split_selected_areas = strsplit(char(first_split_selected_areas(1,2)),"</center></html>");
        selected_areas_string = char( second_split_selected_areas(1,1));
        selected_areas_num = str2double(selected_areas_string);
        
        % Apply colors
        % (0/255,176/255,80/255) -> deep green
        % (146/255,208/255,80/255) -> light green
        % (255/255,255/255,0/255) -> yellow
        % (0/255,176/255,80/255) -> orange
        % (0/255,176/255,80/255) -> red
        switch hazard_severity_num
            case 1
                if hazard_probability_num <= 4
                    for colIdx = 1 : length(headers)
                        cr.setCellBgColor(rowIdx-1,colIdx-1,java.awt.Color(0/255,176/255,80/255));
                    end
                elseif (hazard_probability_num > 4) && (hazard_probability_num <= 5)
                    for colIdx = 1 : length(headers)
                        cr.setCellBgColor(rowIdx-1,colIdx-1,java.awt.Color(146/255,208/255,80/255));
                    end
                else
                    fprintf('[%s] Values for area %d are outside the normal values (Hazard Probability %d)!\n', datestr(datetime('now')), selected_areas_num, hazard_probability_num)
                end
            case 2
                if hazard_probability_num <= 1
                    for colIdx = 1 : length(headers)
                        cr.setCellBgColor(rowIdx-1,colIdx-1,java.awt.Color(0/255,176/255,80/255));
                    end
                elseif (hazard_probability_num > 1) && (hazard_probability_num <= 4)
                    for colIdx = 1 : length(headers)
                        cr.setCellBgColor(rowIdx-1,colIdx-1,java.awt.Color(146/255,208/255,80/255));
                    end
                elseif (hazard_probability_num > 4) && (hazard_probability_num <= 5)
                    for colIdx = 1 : length(headers)
                        cr.setCellBgColor(rowIdx-1,colIdx-1,java.awt.Color(255/255,255/255,0/255));
                    end
                else
                    fprintf('[%s] Values for area %d are outside the normal values (Hazard Probability %d)!\n', datestr(datetime('now')), selected_areas_num, hazard_probability_num)
                end
            case 3
                if hazard_probability_num <= 2
                    for colIdx = 1 : length(headers)
                        cr.setCellBgColor(rowIdx-1,colIdx-1,java.awt.Color(146/255,208/255,80/255));
                    end
                elseif (hazard_probability_num > 2) && (hazard_probability_num <= 4)
                    for colIdx = 1 : length(headers)
                        cr.setCellBgColor(rowIdx-1,colIdx-1,java.awt.Color(255/255,255/255,0/255));
                    end
                elseif (hazard_probability_num > 4) && (hazard_probability_num <= 5)
                    for colIdx = 1 : length(headers)
                        cr.setCellBgColor(rowIdx-1,colIdx-1,java.awt.Color(255/255,102/255,0/255));
                    end
                else
                    fprintf('[%s] Values for area %d are outside the normal values (Hazard Probability %d)!\n', datestr(datetime('now')), selected_areas_num, hazard_probability_num)
                end
            case 4
                if hazard_probability_num <= 2
                    for colIdx = 1 : length(headers)
                        cr.setCellBgColor(rowIdx-1,colIdx-1,java.awt.Color(255/255,255/255,0/255));
                    end
                elseif (hazard_probability_num > 2) && (hazard_probability_num <= 4)
                    for colIdx = 1 : length(headers)
                        cr.setCellBgColor(rowIdx-1,colIdx-1,java.awt.Color(255/255,102/255,0/255));
                    end
                elseif (hazard_probability_num > 4) && (hazard_probability_num <= 5)
                    for colIdx = 1 : length(headers)
                        cr.setCellBgColor(rowIdx-1,colIdx-1,java.awt.Color(255/255,0/255,0/255));
                    end
                else
                    fprintf('[%s] Values for area %d are outside the normal values (Hazard Probability %d)!\n', datestr(datetime('now')), selected_areas_num, hazard_probability_num)
                end
            case 5
                if hazard_probability_num <= 3
                    for colIdx = 1 : length(headers)
                        cr.setCellBgColor(rowIdx-1,colIdx-1,java.awt.Color(255/255,102/255,0/255));
                    end
                elseif (hazard_probability_num > 3) && (hazard_probability_num <= 5)
                    for colIdx = 1 : length(headers)
                        cr.setCellBgColor(rowIdx-1,colIdx-1,java.awt.Color(255/255,0/255,0/255));
                    end
                else
                    fprintf('[%s] Values for area %d are outside the normal values (Hazard Probability %d)!\n', datestr(datetime('now')), selected_areas_num, hazard_probability_num)
                end
            otherwise
                fprintf('[%s] Values for area %d are outside the normal values (Hazard Severity %d)!\n', datestr(datetime('now')), selected_areas_num, hazard_severity_num)
        end
    end
    
    % Replace Matlab's table model with something more renderer-friendly...
    jTable.setModel(javax.swing.table.DefaultTableModel(final_table,headers));
    set(hTable,'ColumnFormat',[]);
    
    % Finally assign the renderer object to all the table columns
    for colIdx = 1 : length(headers)
        jTable.getColumnModel.getColumn(colIdx-1).setCellRenderer(cr);
    end
    if areas_with_no_table_count ~= 0 && areas_with_no_table_count ~= 1
        areas_with_no_table_string = "";
        for i = 1:length(areas_with_no_table)
            areas_with_no_table_string = strcat(areas_with_no_table_string,num2str(areas_with_no_table(i))," "); 
        end
        fprintf('[%s] Number of requested areas with no risk schedule table: %d [ areas: %s]\n', datestr(datetime('now')),areas_with_no_table_count,areas_with_no_table_string)
    elseif areas_with_no_table_count == 1
        areas_with_no_table_string = "";
        for i = 1:length(areas_with_no_table)
            areas_with_no_table_string = strcat(areas_with_no_table_string,num2str(areas_with_no_table(i))," "); 
        end
        fprintf('[%s] Number of requested areas with no risk schedule table: %d [ area: %s]\n', datestr(datetime('now')),areas_with_no_table_count,areas_with_no_table_string)
    else
        fprintf('[%s] Number of requested areas with no risk schedule table: %d\n', datestr(datetime('now')),areas_with_no_table_count)
    end
else
    fprintf('[%s] The risk schedule table is empty for the requested areas\n', datestr(datetime('now')))
end

