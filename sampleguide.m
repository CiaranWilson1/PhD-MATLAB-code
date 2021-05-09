function varargout = sampleguide(varargin)
% SAMPLEGUIDE MATLAB code for sampleguide.fig
%      SAMPLEGUIDE, by itself, creates a new SAMPLEGUIDE or raises the existing
%      singleton*.
%
%      H = SAMPLEGUIDE returns the handle to a new SAMPLEGUIDE or the handle to
%      the existing singleton*.
%
%      SAMPLEGUIDE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAMPLEGUIDE.M with the given input arguments.
%
%      SAMPLEGUIDE('Property','Value',...) creates a new SAMPLEGUIDE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sampleguide_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sampleguide_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sampleguide

% Last Modified by GUIDE v2.5 08-Jul-2016 15:41:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sampleguide_OpeningFcn, ...
                   'gui_OutputFcn',  @sampleguide_OutputFcn, ...
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


% --- Executes just before sampleguide is made visible.
function sampleguide_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sampleguide (see VARARGIN)
% if ~isfield(handles,'hListener')
%     handles.hListener = addlistener(handles.slider1,'ContinuousValueChange',@respondToContSlideCallback);
%  end

% Choose default command line output for sampleguide
handles.output = hObject;
 set(handles.slider1, 'Min', 0.05*1e9);
 set(handles.slider1, 'Max', 9.9*1e9);
 set(handles.slider1, 'Value', 0.06*1e9);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sampleguide wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sampleguide_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%get(hObject,'Value') %returns position of slider
% set(hObject,'Min',0.5) %and 
% set(hObject,'Max',9) %to determine range of slider
% set(hObject, 'Value', 1);
var1 = get(hObject,'Value')
hObject.UserData = var1;
% newVal = floor(get(hObject,'Value'));
% set(hObject,'Value',newVal);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% filenames = dir('C:\Users\Ciaran Wilson\Documents\ColdFET');
% filename = zeros(1,118);
% for ii = 3:1:118
%      filename = filenames(ii).name;
% 
% %filename = filenames(3).name;
% % end
% wowfile = ['C:\Users\Ciaran Wilson\Documents\ColdFET\' filename];
% h = read(rfdata.data, wowfile);
% sm = smith(h,'S11');
% legend off
% hold on
% end
% sm.Parent.Position = [0.1300 0.0500 0.370 0.40];
testfunction

% function testfunction
% filenames = dir('C:\Users\Ciaran Wilson\Documents\ColdFET');
% filename = zeros(1,118);
% filename = filenames(3).name;
% %end
% wowfile = ['C:\Users\Ciaran Wilson\Documents\ColdFET\' filename];
% h = read(rfdata.data, wowfile);
% sm = smith(h,'S11');
% legend off
% hold on
function testfunction
clear all
filenames = dir('C:\Users\Ciaran Wilson\Documents\ColdFET');
filename = zeros(1,118);
h2 = findobj('Tag','slider1');
data = h2.UserData;
display(data);
% fH = figure;
% get(fH)
% set(fH, 'Menubar', 'None')
% ax = axes;
% ax.Position = [0.1500 0.0500 0.37 0.40];
% get(fH, 'Children')
% ax2 = axes;
% get(ax2)
% ax2.Position = [0.60 0.55 0.37 0.40];
% ax3 = axes;
% get(ax3)
% ax3.Position = [0.60 0.05 0.37 0.40];
% ax4 = axes;
% get(ax4)
% ax4.Position = [0.15 0.55 0.37 0.40];
% fH = figure;
for ii = 3:1:118
    filename = filenames(ii).name;
%end
wowfile = ['C:\Users\Ciaran Wilson\Documents\ColdFET\' filename];
h = read(rfdata.data, wowfile);
c = (h.Freq > data);
d = find(c);
% S = h.S_Parameters;
% s11 = rfparam(1,1,S);
% wowfile = ['C:\Users\Ciaran Wilson\Documents\ColdFET\' filename];
% S = sparameters(wowfile);
% s11 = rfparam(S,1,1);
%fH = figure;
%get(fH)
%set(fH, 'Menubar', 'None')
sm = smith(h,'S11');
sm.XData = sm.XData(d(1):d(end));
sm.YData = sm.YData(d(1):d(end));
legend off
hold on
sm.Parent.Position = [0.1300 0.0500 0.370 0.40];
end
filename = 0;
axes
for jj = 3:1:118
    filename = filenames(jj).name;
    wowfile = ['C:\Users\Ciaran Wilson\Documents\ColdFET\' filename];
h = read(rfdata.data, wowfile);
% c = (h.Freq > data);
% d = find(c);
% get(fH, 'Children')
% s12 = rfparam(S,1,2);
sm2 = smith(h,'s12');
% sm.XData = sm.XData(d(1):d(end));
% sm.YData = sm.YData(d(1):d(end));
legend off
%get(sm2)
hold on
sm2.Parent.Position = [0.600 0.5500 0.370 0.40];
end
filename = 0;
axes
for kk = 3:1:118
    filename = filenames(kk).name;
    wowfile = ['C:\Users\Ciaran Wilson\Documents\ColdFET\' filename];
h = read(rfdata.data, wowfile);
% get(fH, 'Children')
% s21 = rfparam(S,2,1);
sm3 = smith(h,'S21');
legend off
%get(sm2)
hold on
sm3.Parent.Position = [0.600 0.0500 0.370 0.40];
end
% s21 = rfparam(S,2,1);
% sm3 = smithchart(s21);
% sm3.Parent.Position = [0.600 0.0500 0.370 0.40];
filename = 0;
axes
for ll = 3:1:118
    filename = filenames(ll).name;
    wowfile = ['C:\Users\Ciaran Wilson\Documents\ColdFET\' filename];
h = read(rfdata.data, wowfile);
% get(fH, 'Children')
% s22 = rfparam(S,2,2);
sm4 = smith(h, 's22');
legend off
%get(sm2)
hold on
sm4.Parent.Position = [0.1300 0.5500 0.370 0.40];
% end
% s22 = rfparam(S,2,2);
end
