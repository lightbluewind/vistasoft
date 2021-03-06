function vw=make3ViewSliceUI(vw)
%
% vw=make3ViewSliceUI(vw)
%
% Installs:
%   slice orientation buttons (axi=button 1, cor=button 2, sag=button 3)
%   editable text fields for slice numbers
%   prev and next push buttons
%
% djh, 7/98
% ras, 06/03, adapted from makeVolSliceUI

% Slice orientation buttons
width = .1;
height = .05;
left = .225;
buttonLabels=['Axi'; 'Cor'; 'Sag'];
for b = 1:3
    bot= 0.25 + (b-1)*0.05;
    % Callback:
    %   setCurSliceOri(vw, b);
    cb = sprintf('setCurSliceOri(%s, %i); ', vw.name, b); 
    vw.ui.sliceOriButtons(b) = ...
        uicontrol('Style', 'radiobutton',...
        'String', buttonLabels(b,:),...
        'BackgroundColor', get(gcf,'Color'),...
        'Units', 'normalized',...
        'Position', [left,bot,width,height],...
        'Callback',  cb);
end

% Slice num fields
width = .1;
height = .05;
left = .325;
for b = 1:3
    bot= 0.25 + (b-1)*0.05;
    
    % Callback:
    %   sliceNum=str2num(get(vw.ui.sliceNumFields(b),'String'));
    %   volSize=viewSize(vw);
    %   sliceNum=clip(sliceNum,1,volSize(b));
    %   set(vw.ui.sliceNumFields(b),'String',num2str(sliceNum));
    %   clear sliceNum volSize;
    %   vw=update3ViewLoc(vw);
    bstr=num2str(b);
    cb = ...
        ['sliceNum=str2num(get(',vw.name,'.ui.sliceNumFields(',bstr,'),''String'')); '...
            'volSize=viewSize(',vw.name,'); ',...
            'sliceNum=clip(sliceNum,1,volSize(',bstr,')); '...
            'set(',vw.name,'.ui.sliceNumFields(',bstr,'),''String'',num2str(sliceNum)); '...
            'clear sliceNum volSize; ',...
            vw.name,'=update3ViewLoc(',vw.name,');'];
    vw.ui.sliceNumFields(b) = ...
        uicontrol('Style','edit',...
        'BackgroundColor',get(gcf,'Color'),...
        'String',num2str(1),...
        'Units','normalized',...
        'Position',[left,bot,width,height],...
        'Callback', cb);
end


% Prev button
% Callback:
%   sliceNum=viewGet(vw, 'Current Slice')-1;
%   setCurSlice(vw,sliceNum);
%   clear sliceNum;
%   vw=update3ViewLoc(vw);
cb = ...
    ['sliceNum=viewGet(',vw.name,', ''Current Slice'')-1; '...
        'vw = viewSet(',vw.name,',''Current Slice'', sliceNum); '...
        'clear sliceNum; ',...
        vw.name,'=update3ViewLoc(',vw.name,');'];
previousBtn= ...
    uicontrol('Style','pushbutton',...
    'String','<< Prev',...
    'Units','normalized',... 
    'BackgroundColor',get(gcf,'Color'),...
    'Position',[.225 .2 .1 .05], ...
    'Callback', cb);

% Next button
% Callback:
%   sliceNum=viewGet(vw, 'Current Slice')+1;
%   vw = viewSet(vw,'Current Slice, sliceNum);
%   clear sliceNum;
%   vw=update3ViewLoc(vw);
cb = ...
    ['sliceNum=viewGet(',vw.name,', ''Current Slice'')+1; '...
        'vw = viewSet(',vw.name,',''Current Slice'', sliceNum); '...
        'clear sliceNum; ',...
        vw.name,'=update3ViewLoc(',vw.name,');'];
nextBtn= ...
    uicontrol('Style','pushbutton',...
    'String','Next >>',...
    'BackgroundColor',get(gcf,'Color'),...
    'Units','normalized',... 
    'Position',[.325 .2 .1 .05], ...
    'Callback', cb);

return;
