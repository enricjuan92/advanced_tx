function varargout = gui_afoc(varargin)
% GUI_AFOC MATLAB code for gui_afoc.fig
%      GUI_AFOC, by itself, creates a new GUI_AFOC or raises the existing
%      singleton*.
%
%      H = GUI_AFOC returns the handle to a new GUI_AFOC or the handle to
%      the existing singleton*.
%
%      GUI_AFOC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_AFOC.M with the given input arguments.
%
%      GUI_AFOC('Property','Value',...) creates a new GUI_AFOC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_afoc_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_afoc_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_afoc

% Last Modified by GUIDE v2.5 27-May-2017 12:36:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_afoc_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_afoc_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui_afoc is made visible.
function gui_afoc_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_afoc (see VARARGIN)

% Choose default command line output for gui_afoc
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_afoc wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_afoc_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global GSTATE;
GSTATE.NSYMB = str2num(get(handles.edit2, 'String'));
GSTATE.NT = str2num(get(handles.edit3, 'String'));
roll = str2num(get(handles.edit4, 'String'));
selectedIndex = get(handles.popupmenu3, 'Value');
    if selectedIndex == 2
        modulation = 'QPSK';
    elseif selectedIndex == 3
        modulation = '16-QAM';
    elseif selectedIndex == 4
        modulation = '64-QAM';
    elseif selectedIndex == 5
        modulation = '256-QAM';  
    end
GSTATE   
afoc_transmitter(modulation,roll);

% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3

    

% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
%
%handles.edit2 = get (hObject, 'String')

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global GSTATE;
afoc_receiver(GSTATE.modulation_order, GSTATE.Eout)
set(handles.edit1,'String', GSTATE.BER);
plot(handles.axes2, real(GSTATE.EDET), imag(GSTATE.EDET), '*g');
axes(handles.axes2);
xlabel('I Component');
ylabel('Q Component');
title('Noiseless Received Constellation');



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double



% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
global GSTATE;

 if get(handles.checkbox1,'Value')
    plot(handles.axes2, real(GSTATE.ENOISY),imag(GSTATE.ENOISY), '*g');
    axes(handles.axes2);
    xlabel('I Component');
    ylabel('Q Component');
    title('Noisy Received Constellation');
 else
     if ~isempty(handles.checkbox1)
        plot(handles.axes2, real(GSTATE.EDET), imag(GSTATE.EDET), '*g');  
        axes(handles.axes2);
        xlabel('I Component');
        ylabel('Q Component');
        title('Noiseless Received Constellation');
     end
 end
% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global GSTATE;

selectedGraph = get(handles.popupmenu4, 'Value');
points = linspace(1, GSTATE.NSYMB, GSTATE.NSYMB);

    if selectedGraph == 2
    
    plot(handles.axes1, [1:length(GSTATE.Eoutiq)], real(GSTATE.Eoutiq));
%     set(handles.axes1, 'xlim', [-], 'ylim', [-6 6]);
    axes(handles.axes1);
    xlabel('');
    ylabel('');
    title('I Modulator output');
    
    elseif selectedGraph == 3
        
   plot(handles.axes1, [1:length(GSTATE.Eoutiq)], imag(GSTATE.Eoutiq));
%     set(handles.axes1, 'xlim', [-], 'ylim', [-6 6]);
    axes(handles.axes1);
    xlabel('');
    ylabel('');
    title('Q Modulator output');
    
elseif selectedGraph == 4
    points=linspace(1, length(GSTATE.EMZM_i), length(GSTATE.EMZM_i));
    plot(handles.axes1, points, GSTATE.EMZM_i, points, GSTATE.EMZM_q);
    axes(handles.axes1);
    title('MZM Output (IQ)');
    legend('MZM Output (I-Branch)', 'MZM Output (Q-Branch)');

elseif selectedGraph == 5
   plot(handles.axes1,GSTATE.elec_i_sampled, GSTATE.elec_q_sampled, '*r');
   max(GSTATE.elec_i_sampled)
   lims_x = [-max(GSTATE.elec_i_sampled)-0.5 max(GSTATE.elec_i_sampled)+0.5];
   lims_y = [-max(GSTATE.elec_q_sampled)-0.5 max(GSTATE.elec_q_sampled)+0.5];
   set(handles.axes1, 'xlim', lims_x, 'ylim', lims_y);
   axes(handles.axes1);
   xlabel('I Component');
   ylabel('Q Component');
   title('Electrical constellation');
   
elseif selectedGraph == 6
    plot(handles.axes1, GSTATE.Eout_i_sampled, GSTATE.Eout_q_sampled, '*g');
    axes(handles.axes1);
    title('Optical constellation');
    xlabel('I Component');
    ylabel('Q Component');

elseif selectedGraph == 7
    plot(handles.axes1, [1:length(GSTATE.elec_i)], GSTATE.elec_i, ...
                        [1:length(GSTATE.elec_i)], GSTATE.elec_q);
    set(handles.axes1, 'xlim', [0 length(GSTATE.elec_i)]);
    axes(handles.axes1);
    xlabel('');
    ylabel('');
    title('Electrical signals');
    legend('Electrical Signal (I-Branch)', 'Electrical Signal (Q-Branch)');    
end


% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global GSTATE;
step_size = (GSTATE.LEVELS_I(2)-GSTATE.LEVELS_I(1));
if get(handles.checkbox2,'Value')
    for i=1:length(GSTATE.LEVELS_I)
        hold(handles.axes2,'all');
        plot(handles.axes2, ones(length(GSTATE.LEVELS_I)*2+1)*GSTATE.LEVELS_I(i), -length(GSTATE.LEVELS_I):length(GSTATE.LEVELS_I), 'r--')
    end
    set(handles.axes2, 'xlim', [GSTATE.LEVELS_I(1)-step_size, GSTATE.LEVELS_I(length(GSTATE.LEVELS_I))+step_size]);
    for i=1:length(GSTATE.LEVELS_Q)
        hold(handles.axes2,'all');
        plot(handles.axes2, -length(GSTATE.LEVELS_Q):length(GSTATE.LEVELS_Q), ones(length(GSTATE.LEVELS_Q)*2+1)*GSTATE.LEVELS_Q(i), 'r--')
    end
    set(handles.axes2, 'ylim', [GSTATE.LEVELS_I(1)-step_size, GSTATE.LEVELS_I(length(GSTATE.LEVELS_I))+step_size]);
    hold(handles.axes2, 'off');
else 
    if ~isempty(handles.checkbox2)
         for i=1:length(GSTATE.LEVELS_I)
        hold(handles.axes2,'all');
        plot(handles.axes2, ones(length(GSTATE.LEVELS_I)*2+1)*GSTATE.LEVELS_I(i), -length(GSTATE.LEVELS_I):length(GSTATE.LEVELS_I), 'w--')
    end
    set(handles.axes2, 'xlim', [GSTATE.LEVELS_I(1)-step_size, GSTATE.LEVELS_I(length(GSTATE.LEVELS_I))+step_size]);
    for i=1:length(GSTATE.LEVELS_Q)
        hold(handles.axes2,'all');
        plot(handles.axes2, -length(GSTATE.LEVELS_Q):length(GSTATE.LEVELS_Q), ones(length(GSTATE.LEVELS_Q)*2+1)*GSTATE.LEVELS_Q(i), 'w--')
    end
    set(handles.axes2, 'ylim', [GSTATE.LEVELS_I(1)-step_size, GSTATE.LEVELS_I(length(GSTATE.LEVELS_I))+step_size]);
    hold(handles.axes2, 'off');   
    end  
end    
% Hint: get(hObject,'Value') returns toggle state of checkbox2



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
