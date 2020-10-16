function message = create_email_text(changed_areas, time_stamp, image1, image2)
% This function creates the message that will be sent to the email
% recipient. It provides info on the areas where changes have been detected
% and tries to identify the moved objects. Object recognition is for now hardcoded!
[m,n] = size(changed_areas);

text_title = sprintf('[%s] Report for comparison between "%s" and "%s"\n\n', time_stamp, image1, image2);

if (n==1) 
    message = sprintf('%s    Our tool has detected changes in the following area: \n', text_title);
else
    message = sprintf('%s    Our tool has detected changes in the following %s areas: \n', text_title, int2str(n));
end
for i = 1:n % Loop for all changed areas
    text = sprintf('       -  Changes have been detected in area: %s \n', int2str(changed_areas(i)));
    message = sprintf('%s %s', message, text); % Add(Append) the text to the final message
end

message = sprintf('%s \n %s', message, '--- Check the attachments for details ---'); % Add(Append) the text to the final message

