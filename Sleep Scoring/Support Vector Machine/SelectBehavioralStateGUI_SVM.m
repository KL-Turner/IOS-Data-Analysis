function varargout = SelectBehavioralStateGUI_SVM(varargin)
% SELECTBEHAVIORALSTATEGUI_SVM MATLAB code for SelectBehavioralStateGUI_SVM.fig
%      SELECTBEHAVIORALSTATEGUI_SVM, by itself, creates a new SELECTBEHAVIORALSTATEGUI_SVM or raises the existing
%      singleton*.
%
%      H = SELECTBEHAVIORALSTATEGUI_SVM returns the handle to a new SELECTBEHAVIORALSTATEGUI_SVM or the handle to
%      the existing singleton*.
%
%      SELECTBEHAVIORALSTATEGUI_SVM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SELECTBEHAVIORALSTATEGUI_SVM.M with the given input arguments.
%
%      SELECTBEHAVIORALSTATEGUI_SVM('Property','Value',...) creates a new SELECTBEHAVIORALSTATEGUI_SVM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SelectBehavioralStateGUI_SVM_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SelectBehavioralStateGUI_SVM_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SelectBehavioralStateGUI_SVM

% Last Modified by GUIDE v2.5 07-Aug-2019 11:48:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SelectBehavioralStateGUI_SVM_OpeningFcn, ...
                   'gui_OutputFcn',  @SelectBehavioralStateGUI_SVM_OutputFcn, ...
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


% --- Executes just before SelectBehavioralStateGUI_SVM is made visible.
function SelectBehavioralStateGUI_SVM_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SelectBehavioralStateGUI_SVM (see VARARGIN)

% Choose default command line output for SelectBehavioralStateGUI_SVM
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SelectBehavioralStateGUI_SVM wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SelectBehavioralStateGUI_SVM_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ButtonSelect_SVM
% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ButtonSelect_SVM
% Hint: get(hObject,'Value') returns toggle state of togglebutton2


% --- Executes on button press in togglebutton3.
function togglebutton3_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ButtonSelect_SVM
% Hint: get(hObject,'Value') returns toggle state of togglebutton3