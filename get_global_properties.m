function [properties] = get_global_properties

% Path where the images are located
properties.images_path='images\';
% Path where the areas are located
properties.areas_path='areas\';
% Path where the comparison images are located
properties.output_path='output\';
% Path where the comparison images are located
properties.risks_path='risks\'; 
% Initial image name
if exist('archive/initial_image.txt', 'file') == 2
    initial_image_file=fopen('archive/initial_image.txt');
    properties.initial_image=fgetl(initial_image_file);
    fclose(initial_image_file);
else
    properties.initial_image='GENERAL COMPLETE 3D VIEW.png';
end
% email for changes to be sent
if exist('archive/email_account.txt', 'file') == 2
    email_account_file=fopen('archive/email_account.txt');
    properties.email_account=fgetl(email_account_file);
    fclose(email_account_file);
else
    properties.email_account='ftsouka@otenet.gr';
end
% 'Yes' to enable email or 'No' to disable
if exist('archive/email_enabled.txt', 'file') == 2
    email_enabled_file=fopen('archive/email_enabled.txt');
    properties.email_enabled=fgetl(email_enabled_file);
    fclose(email_enabled_file);
else
    properties.email_enabled='No';
end