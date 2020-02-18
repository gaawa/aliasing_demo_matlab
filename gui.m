close all
f=figure(1);
p_contrl=uipanel(f,'Position',[0.1,0.2,0.8,0.22]);
text_dec = uicontrol(p_contrl,'Style', 'text',...
    'String', 'n_decimation',...
    'position', [0,21,65,16],...
    'HorizontalAlignment', 'left');
edit_dec = uicontrol(p_contrl,'Style', 'edit',...
    'string', '0',...
    'position', [100,21,20,16]);
text_fy = uicontrol(p_contrl,'Style', 'text',...
    'String', 'f_sig',...
    'position', [0,3,30,16],...
    'HorizontalAlignment', 'left');
slider_fy = uicontrol(p_contrl,'Style', 'slider',...
    'value', 0.01,...
    'position', [100,3,320,16]);
text_decmode = uicontrol(p_contrl, 'Style', 'text',...
    'String', 'decimation mode',...
    'position', [0, 45, 100, 16],...
    'HorizontalAlignment', 'left');
pop_decmode = uicontrol(p_contrl, 'Style', 'popupmenu',...
    'string', {'repeat', 'zero padding'},...
    'position', [100, 45, 100, 16]);
text_scale = uicontrol(p_contrl, 'Style', 'text',...
    'String', 'PSD scaling',...
    'position', [0, 68, 65, 16],...
    'HorizontalAlignment', 'left');
pop_scale = uicontrol(p_contrl, 'Style', 'popupmenu',...
    'String', {'linear', 'log'},...
    'position', [100, 68, 100, 16]);
%pop_decode.String = {'repeat', 'zero padding'};
    
% set defalut figure size and positions
figure(1)
fig1_pos = get(gcf, 'Position');
fig1_pos(1) = 100;
fig1_pos(2) = 0;
set(gcf, 'Position', fig1_pos);
figure(2)
fig2_pos = get(gcf, 'Position');
fig2_pos(1) = 0;
fig2_pos(3) = 1800;
set(gcf, 'Position', fig2_pos);
sin_spec(str2num(get(edit_dec,'string')), get(slider_fy, 'value'), 'linear', 'repeat')

addlistener(slider_fy,'ContinuousValueChange',...
    @(hObject, event)handler(edit_dec, slider_fy, pop_scale, pop_decmode));
addlistener(edit_dec,'String', 'PostSet',...
    @(hObject, event)handler(edit_dec, slider_fy, pop_scale, pop_decmode));
addlistener(pop_scale,'Value', 'PostSet',...
    @(hObject, event)handler(edit_dec, slider_fy, pop_scale, pop_decmode));
addlistener(pop_decmode,'Value', 'PostSet',...
    @(hObject, event)handler(edit_dec, slider_fy, pop_scale, pop_decmode));

function handler(edit_dec, slider_fy, pop_scale, pop_decmode)
    scale_arr=get(pop_scale, 'string');
    scale_val=get(pop_scale, 'value');
    scale=string(scale_arr(scale_val));
    
    decmode_arr=get(pop_decmode, 'string');
    decmode_val=get(pop_decmode, 'value');
    decmode=string(decmode_arr(decmode_val));
    
    sin_spec(str2num(get(edit_dec,'string')),...
        get(slider_fy, 'value'),...
        scale, decmode);
end