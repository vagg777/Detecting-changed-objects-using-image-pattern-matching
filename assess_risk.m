function user_input = assess_risk

d = dialog('Position',[200 200 400 400],'Name','Completing data for risk assessment');

txt1 = uicontrol('Parent',d,...
    'Style','text',...
    'Position',[0 340 150 25],...
    'String','Select areas');

selected_areas = uicontrol('Parent',d,...
    'Style','edit',...
    'Position',[160 340 150 25],...
    'CallBack',@popup_callback1);

txt2 = uicontrol('Parent',d,...
    'Style','text',...
    'Position',[0 280 150 25],...
    'String','Hazard severity');

hazard_severity = uicontrol('Parent',d,...
    'Style','popup',...
    'Position',[160 280 150 25],...
    'String',{'--';'1';'2';'3';'4';'5'},...
    'Callback',@popup_callback2);

txt3 = uicontrol('Parent',d,...
    'Style','text',...
    'Position',[0 220 150 25],...
    'String','Hazard probability');

hazard_probability = uicontrol('Parent',d,...
    'Style','popup',...
    'Position',[160 220 150 25],...
    'String',{'--';'1';'2';'3';'4';'5'},...
    'Callback',@popup_callback3);

txt4 = uicontrol('Parent',d,...
    'Style','text',...
    'Position',[0 160 150 25],...
    'String','Hazard type');

hazard_type = uicontrol('Parent',d,...
    'Style','edit',...
    'Position',[160 160 150 25],...
    'CallBack',@popup_callback4);

txt5 = uicontrol('Parent',d,...
    'Style','text',...
    'Position',[0 100 150 25],...
    'String','Comments');

comments = uicontrol('Parent',d,...
    'Style','edit',...
    'Position',[160 100 150 25],...
    'CallBack',@popup_callback5);

btn1 = uicontrol('Parent',d,...
    'Position',[20 20 70 25],...
    'String','OK',...
    'Callback',@save_risks);

btn2 = uicontrol('Parent',d,...
    'Position',[120 20 70 25],...
    'String','See Areas',...
    'Callback',@open_areas);

btn3 = uicontrol('Parent',d,...
    'Position',[220 20 70 25],...
    'String','OK - reopen',...
    'Callback',@save_risk_and_reopen);

btn4 = uicontrol('Parent',d,...
    'Position',[320 20 70 25],...
    'String','Close',...
    'Callback',@close_box);

user_input.selected_areas = 'empty';
user_input.hazard_severity = 'empty';
user_input.hazard_probability = 'empty';
user_input.hazard_type = '';
user_input.comments = '';
exit_function = "no";
reopen_page = "no";

% Wait for d to close before running to completion
uiwait(d);
    function [] = popup_callback1(H,E)
        user_input.selected_areas = get(H,'string');
    end

    function popup_callback2(popup,event)
        idx = popup.Value;
        popup_items = popup.String;
        choice1 = char(popup_items(idx,:));
        user_input.hazard_severity = choice1;
    end

    function popup_callback3(popup,event)
        idx = popup.Value;
        popup_items = popup.String;
        choice2 = char(popup_items(idx,:));
        user_input.hazard_probability = choice2;
    end

    function [] = popup_callback4(H,E)
        user_input.hazard_type = get(H,'string');
    end

    function [] = popup_callback5(H,E)
        user_input.comments = get(H,'string');
    end

    function [] = save_risks(H,E,user_input)
        close(d);
    end

    function [] = open_areas(H,E)
        fprintf('[%s] Displaying areas\n', datestr(datetime('now')));
        display_areas_impl;
    end

    function [] = save_risk_and_reopen(H,E)
        %close(d);
        reopen_page = "yes";
        close(d);
    end

    function [] = close_box(H,E)
        close(d);
        exit_function = "yes";
    end

    %     save_risks_impl(user_input)
    if (user_input.selected_areas~="empty" && user_input.hazard_severity~="empty" && user_input.hazard_severity~="--" && user_input.hazard_probability~="empty" && user_input.hazard_probability~="--" && exit_function ~= "yes")
        if user_input.hazard_type == ""
            user_input.hazard_type = '-';
        end
        if user_input.comments == ""
            user_input.comments = '-';
        end
        if reopen_page ~= "yes"
            fprintf('[%s] Saving risks for areas %s\n', datestr(datetime('now')), user_input.selected_areas);
            save_risks_impl(user_input);
        else
            fprintf('[%s] Saving risks for areas %s and re-opening risk assessment form\n', datestr(datetime('now')), user_input.selected_areas);
            save_risks_impl(user_input);
            assess_risk;
        end
    elseif ((user_input.selected_areas=="empty" || user_input.hazard_severity=="empty" || user_input.hazard_severity=="--" || user_input.hazard_probability=="empty" || user_input.hazard_probability=="--") && exit_function ~= "yes" && reopen_page == "yes")
        if user_input.hazard_type == ""
            user_input.hazard_type = '-';
        end
        if user_input.comments == ""
            user_input.comments = '-';
        end
        fprintf('[%s] Risks not saved - missing or wrong fields, re-opening risk assessment form\n', datestr(datetime('now')));
        assess_risk;
    elseif exit_function == "yes"
        fprintf('[%s] Exiting without saving risks\n', datestr(datetime('now')));
    else
        fprintf('[%s] Risks not saved - missing or wrong fields\n', datestr(datetime('now')));
    end


end