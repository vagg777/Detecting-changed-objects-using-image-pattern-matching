function send_email(email_account,changed_areas,filename1,filename2,image1,image2)

% Email properties
setpref('Internet','SMTP_Server','smtp.gmail.com');
setpref('Internet','E_mail','youremail@domain.com');
setpref('Internet','SMTP_Username','youremailusername');
setpref('Internet','SMTP_Password','youremailpassword');
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');

% Get current time
t = datetime('now');
% Create text for email
email_title = strcat('Detected changes (', datestr(t), ')');
% Attach images with changes
attachment1 = strcat('output/',filename1,'.png');
attachment2 = strcat('output/',filename2,'.png');
% Send email
sendmail(email_account,...
    email_title, create_email_text(changed_areas, datestr(t),image1,image2),...
    {attachment1,attachment2});