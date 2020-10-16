clc; close all;
% Read global parameters
properties = get_global_properties;

% Print message to console
fprintf('------------------------------------------------------------------------\n[%s] User initiated the program\n', datestr(datetime('now')))

% Read initial image
I = imread([properties.images_path properties.initial_image]);

% Dialog box with user selection
list = {'Enter e-mail address','Enable e-mail','Select original image',...
    'Define new area','Delete an area','Display defined areas',...
    'Risk assessment menu','Compare images (with areas masks)',...
    'Compare images (with image scan)','Display Results'};
[indx,tf] = listdlg('PromptString','MAIN MENU - Select one of the following options:',...
                           'SelectionMode','single','ListSize',[400,150],...
                           'ListString',list);

% Handle user selection
if indx == 1
    tic;
    fprintf('[%s] User selected to enter an e-mail address\n', datestr(datetime('now')))
    prompt = {'Enter the e-mail address that you wish'};
    title = 'Define e-mail address';
    if exist('archive/email_account.txt', 'file') == 2
        email_account_file=fopen('archive/email_account.txt');
        email_account_old=fgetl(email_account_file);
        fclose(email_account_file);
        definput = {email_account_old};
    else
        definput = {''};
    end
    answer = inputdlg(prompt,title,[1 40],definput);
    if (isempty(answer) || answer == "")
        fprintf('[%s] E-mail address did not change (cancelled or empty value)\n', datestr(datetime('now')))
    else
        if exist('archive/email_account.txt', 'file') == 2
            delete archive/email_account.txt;
        end
        email_account_file_new=fopen('archive/email_account.txt','w');
        fprintf(email_account_file_new,'%s',char(answer));
        fclose(email_account_file_new);
        fprintf('[%s] e-mail address changed to: %s \n', datestr(datetime('now')),char(answer))
    end
    fprintf('[%s] The tool will now terminate\n------------------------------------------------------------------------\n', datestr(datetime('now')))
    toc;    
elseif indx == 2
    tic;
    fprintf('[%s] User selected to enable/disable e-mail functionality\n', datestr(datetime('now')))
    prompt = {'Enable e-mail (Yes / No)'};
    title = 'Enable e-mail (Yes / No)';
    if exist('archive/email_enabled.txt', 'file') == 2
        email_enabled_file=fopen('archive/email_enabled.txt');
        email_enabled_old=fgetl(email_enabled_file);
        fclose(email_enabled_file);
        definput = {email_enabled_old};
    else
        definput = {''};
    end
    answer = inputdlg(prompt,title,[1 40],definput);
    if (isequal(answer,{'Yes'}) || isequal(answer,{'No'}))
        if exist('archive/email_enabled.txt', 'file') == 2
            delete archive/email_enabled.txt;
        end
        email_enabled_file_new=fopen('archive/email_enabled.txt','w');
        fprintf(email_enabled_file_new,'%s',char(answer));
        fclose(email_enabled_file_new);
        fprintf('[%s] E-mail functionality changed to: %s \n', datestr(datetime('now')),char(answer))
    else
        fprintf('[%s] E-mail functionality did not change (cancelled or non valid value)\n', datestr(datetime('now')))
        fprintf('[%s] Hint: Valid values are "Yes" or "No"\n', datestr(datetime('now')))
    end
    fprintf('[%s] The tool will now terminate\n------------------------------------------------------------------------\n', datestr(datetime('now')))
    toc; 
elseif indx == 3
    tic;
    fprintf('[%s] User selected to define the original image\n', datestr(datetime('now')))
    if exist('archive/initial_image.txt', 'file') == 2
        initial_image_file=fopen('archive/initial_image.txt');
        initial_image_file_old=fgetl(initial_image_file);
        fclose(initial_image_file);
        fprintf('[%s] Current original image is: "%s"\n', datestr(datetime('now')),initial_image_file_old)
    else
        fprintf('[%s] There original image is currently set to default\n', datestr(datetime('now')))
    end
    [original_image,original_image_path] = uigetfile(fullfile(pwd,properties.images_path,'*.*'),'Select the original image file');
    if (original_image == 0)
        fprintf('[%s] Original image did not change (cancelled)\n', datestr(datetime('now')))
    else
        if exist('archive/initial_image.txt', 'file') == 2
            delete archive/initial_image.txt;
        end
        initial_image_file_new=fopen('archive/initial_image.txt','w');
        fprintf(initial_image_file_new,'%s',original_image);
        fclose(initial_image_file_new);
        fprintf('[%s] Original image set to: "%s" \n', datestr(datetime('now')),original_image)
    end
    fprintf('[%s] The tool will now terminate\n------------------------------------------------------------------------\n', datestr(datetime('now')))
    toc; 
elseif indx == 4
    tic;
    fprintf('[%s] User selected to define new areas\n', datestr(datetime('now')))
    areas_selection;      % Dispay already defined areas and select a new area
    close all;
    fprintf('[%s] The tool will now terminate\n------------------------------------------------------------------------\n', datestr(datetime('now')))
    toc;
elseif indx == 5
    tic;
    fprintf('[%s] User selected to delete an area\n', datestr(datetime('now')))
    prompt = {'Enter the area you wish to delete (number only)'};
    title = 'Delete Area';
    definput = {'1'};
    answer = inputdlg(prompt,title,[1 40],definput);
    selectedArea = round(str2double(cell2mat(answer))); % Round to nearest integer in case they entered a floating point number.
    if isnan(selectedArea)  % Check if input was valid or not
        message = sprintf("!!!Wrong Input!!! No valid area number was given");
        uiwait(warndlg(message));
        return;
    else
        if exist(strcat(properties.areas_path,'polygon_x_coordinates_',sprintf( '%05d', selectedArea),'.dat'), 'file')==2
            delete(strcat(properties.areas_path,'polygon_x_coordinates_',sprintf( '%05d', selectedArea),'.dat'));
            delete(strcat(properties.areas_path,'polygon_y_coordinates_',sprintf( '%05d', selectedArea),'.dat'));
            f = msgbox(sprintf('Area %d was successfully deleted!',selectedArea),'Success');
        else
            f = errordlg('File not found','File Error');
        end
    end
    toc;
elseif indx == 6
    tic;
    fprintf('[%s] User selected to display the defined areas\n', datestr(datetime('now')))
    display_areas_impl;   % Display already defined areas
    fprintf('[%s] The tool will now terminate\n------------------------------------------------------------------------\n', datestr(datetime('now')))
    toc;
elseif indx == 7
    tic;
    fprintf('[%s] User selected to complete data for risk assessment\n', datestr(datetime('now')))
    assess_risk_menu;          % Complete data for risk assessment
    fprintf('[%s] The tool will now terminate\n------------------------------------------------------------------------\n', datestr(datetime('now')))
    toc;
elseif indx == 8
    tic;
    fprintf('[%s] User selected to compare images (with areas masks)\n', datestr(datetime('now')))
    % Open window to select the image for comparison
    [second_image,second_image_path] = uigetfile(fullfile(pwd,properties.images_path,'*.*'),'Select the second image file');
    fprintf('[%s] Image "%s" was selected for comparison\n', datestr(datetime('now')), second_image)
    % Read the second image
    J = imread([second_image_path second_image]);
    % Compare the initial and second images
    fprintf('[%s] Comparing images "%s" and "%s". Please wait, this may take a while..\n', datestr(datetime('now')), properties.initial_image, second_image)
    result = compare_images(I, J);
    % Find areas with changes (using areas masks)
    changed_areas = find_areas_with_changes(result);
    if changed_areas ~= 0
        % Display changes
        [filename1,filename2] = display_changed_areas_impl(I, J, changed_areas);
        display_area_risk_table(changed_areas);
        % Send the email with changes report
        if strcmp(properties.email_enabled,'Yes')
            fprintf('[%s] Sending email with changes report to "%s"\n', datestr(datetime('now')), properties.email_account)
            send_email(properties.email_account,changed_areas,filename1,filename2,properties.initial_image,second_image);
            fprintf('[%s] Email sent to "%s"\n', datestr(datetime('now')), properties.email_account)
        else
            fprintf('[%s] Sending report with email is not enabled\n', datestr(datetime('now')))
        end
    else
        fprintf('[%s] No changes between initial and second image or no areas have been defined\n', datestr(datetime('now')))
    end
    fprintf('[%s] The tool will now terminate\n------------------------------------------------------------------------\n', datestr(datetime('now')))
    toc;
elseif indx == 9
    tic;
    fprintf('[%s] User selected to compare images (with image scan)\n', datestr(datetime('now')))
    % Open window to select the image for comparison
    [second_image,second_image_path] = uigetfile(fullfile(pwd,properties.images_path,'*.*'),'Select the second image file');
    fprintf('[%s] Image "%s" was selected for comparison\n', datestr(datetime('now')), second_image)
    % Read the second image
    J = imread([second_image_path second_image]);
    % Compare the initial and second images
    fprintf('[%s] Comparing images "%s" and "%s". Please wait, this may take a while..\n', datestr(datetime('now')), properties.initial_image, second_image)
    result = compare_images(I, J);
    % Find areas with changes (by scaning the comparison result)
    changed_areas = scan_images_for_changes(result);
    if changed_areas ~= 0
        % Display changes
        [filename1,filename2] = display_changed_areas_impl(I, J, changed_areas);
        display_area_risk_table(changed_areas);
        % Send the email with changes report
        if strcmp(properties.email_enabled,'Yes')
            fprintf('[%s] Sending email with changes report to "%s"\n', datestr(datetime('now')), properties.email_account)
            send_email(properties.email_account,changed_areas,filename1,filename2,properties.initial_image,second_image);
            fprintf('[%s] Email sent to "%s"\n', datestr(datetime('now')), properties.email_account)
        else
            fprintf('[%s] Sending report with email is not enabled\n', datestr(datetime('now')))
        end
    else
        fprintf('[%s] No changes between initial and second image or no areas have been defined\n', datestr(datetime('now')))
    end
    fprintf('[%s] The tool will now terminate\n------------------------------------------------------------------------\n', datestr(datetime('now')))
    toc;
elseif indx == 10
    tic;
    fprintf('[%s] User selected to display the results\n', datestr(datetime('now')))
    % Select the initial image (only display files that start with 'Initial')
    [first_image,first_image_path] = uigetfile(fullfile(pwd,properties.output_path,'Initial*.*'),'Select the initial image file');
    J1 = imread([first_image_path first_image]);
    fprintf('[%s] Image "%s" was selected for display\n', datestr(datetime('now')), first_image)
    % Automatically select the second image
    second_image = strrep(first_image,'Initial','Selection');
    J2 = imread([first_image_path second_image]);
    fprintf('[%s] Image "%s" was automatically selected for display\n', datestr(datetime('now')), second_image)
    %[second_image,second_image_path] = uigetfile(fullfile(pwd,properties.output_path,'*.*'),'Select the final image file');
    % J2 = imread([second_image_path second_image]);
    % Open the image comparison tool
    image_compare_tool(J1,J2);
    fprintf('[%s] The tool will now terminate\n------------------------------------------------------------------------\n', datestr(datetime('now')))
    toc;
end