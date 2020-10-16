function hFig = image_zoom_tool(image)

% Create the figure
hFig = figure('Name','My Image Zoom Tool',...
              'NumberTitle','off',...
              'IntegerHandle','off');
          
% Display left image   
hImL = imshow(image);

% Create a scroll panel for left image
hSpL = imscrollpanel(hFig,hImL);
set(hSpL,'Units','normalized',...
    'Position',[0 0.1 1 1])

% Add a Magnification box 
hMagBox = immagbox(hFig,hImL);
pos = get(hMagBox,'Position');
set(hMagBox,'Position',[0 0 pos(3) pos(4)])

%% Add an Overview tool
imoverview(hImL) 

%% Get APIs from the scroll panels 
apiL = iptgetapi(hSpL);

