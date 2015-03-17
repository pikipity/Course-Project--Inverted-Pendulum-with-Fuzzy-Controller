function GUI_InvertedPendulumSimulation

% Initial Data
% theta0, dtheta0, ddtheta0, x0, dx0, ddx0, F0, inputF, t
InitialValues=[0 0 0 0 0 0 0 0 0];
PreviousValue=InitialValues; % When start, recharge
CurrentValues=InitialValues; % When start, recharge
% Initial App Window
inithome
% Initial Value Input Panel
% This Panel needs to contain
%   (1) theta0
%   (2) dtheta0
%   (3) ddtheta0
%   (4) x0
%   (5) dx0
%   (6) ddx0
%   (7) F0
%   (8) Start and Stop Button
% Note: t0 is always 0
LH=PanelPosition(3)/60;
BD=PanelPosition(4)/15;
HD=(PanelPosition(4)-9*BD)/8;
WD=(PanelPosition(3)-4*LH)/3;
ValuePanel=uipanel(fig_1,...
    'units','pixels',...
    'Position',PanelPosition,...
    'Title','Initial Values','FontSize',11);
% Start Button
Start=uicontrol(ValuePanel,'style','togglebutton',...
    'String','Start',...
    'callback',@StartSimulation,...
    'Position',[LH+WD,BD,WD,HD],...
    'FontSize',11);
% F0 value
F0_text=uibutton(ValuePanel,'style','text',...
    'String','F: ',...
    'Position',[LH,2*BD+HD,WD,HD],...
    'FontSize',11);
F0_value=uicontrol(ValuePanel,'style','edit',...
    'String',InitialValues(7),...
    'callback',@F0_value_input,...
    'position',[2*LH+WD,2*BD+HD,WD,HD],...
    'FontSize',11);
F0_unit=uibutton(ValuePanel,'style','text',...
    'String','( N )',...
    'Position',[3*LH+2*WD,2*BD+HD,WD,HD],...
    'FontSize',11);
% ddx0 value
ddx0_text=uibutton(ValuePanel,'style','text',...
    'String','d^2x/dt^2:',...
    'Position',[LH,3*BD+2*HD,WD,HD],...
    'FontSize',11);
ddx0_value=uicontrol(ValuePanel,'style','edit',...
    'String',InitialValues(6),...
    'callback',@ddx0_value_input,...
    'position',[2*LH+WD,3*BD+2*HD,WD,HD],...
    'FontSize',11);
ddx0_unit=uibutton(ValuePanel,'style','text',...
    'String','(m/s^2)',...
    'Position',[3*LH+2*WD,3*BD+2*HD,WD,HD],...
    'FontSize',11);
% dx0 value
dx0_text=uibutton(ValuePanel,'style','text',...
    'String','dx/dt:',...
    'Position',[LH,4*BD+3*HD,WD,HD],...
    'FontSize',11);
dx0_value=uicontrol(ValuePanel,'style','edit',...
    'String',InitialValues(5),...
    'callback',@dx0_value_input,...
    'position',[2*LH+WD,4*BD+3*HD,WD,HD],...
    'FontSize',11);
dx0_unit=uibutton(ValuePanel,'style','text',...
    'String','(m/s)',...
    'Position',[3*LH+2*WD,4*BD+3*HD,WD,HD],...
    'FontSize',11);
% x0 value
x0_text=uibutton(ValuePanel,'style','text',...
    'String','x:',...
    'Position',[LH,5*BD+4*HD,WD,HD],...
    'FontSize',11);
x0_value=uicontrol(ValuePanel,'style','edit',...
    'String',InitialValues(4),...
    'callback',@x0_value_input,...
    'position',[2*LH+WD,5*BD+4*HD,WD,HD],...
    'FontSize',11);
x0_unit=uibutton(ValuePanel,'style','text',...
    'String','( m )',...
    'Position',[3*LH+2*WD,5*BD+4*HD,WD,HD],...
    'FontSize',11);
% ddtheta0 value
ddtheta0_text=uibutton(ValuePanel,'style','text',...
    'String','d^2\theta/dt^2:',...
    'Position',[LH,6*BD+5*HD,WD,HD],...
    'FontSize',11);
ddtheta0_value=uicontrol(ValuePanel,'style','edit',...
    'String',InitialValues(3),...
    'callback',@ddtheta0_value_input,...
    'position',[2*LH+WD,6*BD+5*HD,WD,HD],...
    'FontSize',11);
ddtheta0_unit=uibutton(ValuePanel,'style','text',...
    'String','(rad/s^2)',...
    'Position',[3*LH+2*WD,6*BD+5*HD,WD,HD],...
    'FontSize',11);
% dtheta0 value
dtheta0_text=uibutton(ValuePanel,'style','text',...
    'String','d\theta/dt:',...
    'Position',[LH,7*BD+6*HD,WD,HD],...
    'FontSize',11);
dtheta0_value=uicontrol(ValuePanel,'style','edit',...
    'String',InitialValues(2),...
    'callback',@dtheta0_value_input,...
    'position',[2*LH+WD,7*BD+6*HD,WD,HD],...
    'FontSize',11);
dtheta0_unit=uibutton(ValuePanel,'style','text',...
    'String','(rad/s)',...
    'Position',[3*LH+2*WD,7*BD+6*HD,WD,HD],...
    'FontSize',11);
% theta0 value
theta0_text=uibutton(ValuePanel,'style','text',...
    'String','\theta:',...
    'Position',[LH,8*BD+7*HD,WD,HD],...
    'FontSize',11);
theta0_value=uicontrol(ValuePanel,'style','edit',...
    'String',InitialValues(1),...
    'callback',@theta0_value_input,...
    'position',[2*LH+WD,8*BD+7*HD,WD,HD],...
    'FontSize',11);
theta0_unit=uibutton(ValuePanel,'style','text',...
    'String','(rad)',...
    'Position',[3*LH+2*WD,8*BD+7*HD,WD,HD],...
    'FontSize',11);
% functions for edit values
    function F0_value_input(h,dummy)
        try
            InitialValues(7)=eval(get(h,'String'));
            set(F0_value,'String',InitialValues(7))
        catch
            set(F0_value,'String',InitialValues(7))
            errordlg('Please input a number.','Warning')
        end
    end
    function ddx0_value_input(h,dummy)
        try
            InitialValues(6)=eval(get(h,'String'));
            set(ddx0_value,'String',InitialValues(6))
        catch
            set(ddx0_value,'String',InitialValues(6))
            errordlg('Please input a number.','Warning')
        end
    end
    function dx0_value_input(h,dummy)
        try
            InitialValues(5)=eval(get(h,'String'));
            set(dx0_value,'String',InitialValues(5))
        catch
            set(dx0_value,'String',InitialValues(5))
            errordlg('Please input a number.','Warning')
        end
    end
    function x0_value_input(h,dummy)
        try
            InitialValues(4)=eval(get(h,'String'));
            set(x0_value,'String',InitialValues(4))
        catch
            set(x0_value,'String',InitialValues(4))
            errordlg('Please input a number.','Warning')
        end
    end
    function ddtheta0_value_input(h,dummy)
        try
            InitialValues(3)=eval(get(h,'String'));
            set(ddtheta0_value,'String',InitialValues(3))
        catch
            set(ddtheta0_value,'String',InitialValues(3))
            errordlg('Please input a number.','Warning')
        end
    end
    function dtheta0_value_input(h,dummy)
        try
            InitialValues(2)=eval(get(h,'String'));
            set(dtheta0_value,'String',InitialValues(2))
        catch
            set(dtheta0_value,'String',InitialValues(2))
            errordlg('Please input a number.','Warning')
        end
    end
    function theta0_value_input(h,dummy)
        try
            if eval(get(h,'String'))>pi/2
                InitialValues(1)=pi/2;
                set(theta0_value,'String',InitialValues(1))
                errordlg('Maximum angle is pi/2.','Warning')
            elseif eval(get(h,'String'))<-pi/2
                InitialValues(1)=-pi/2;
                set(theta0_value,'String',InitialValues(1))
                errordlg('Minimum angle is pi/2.','Warning')
            else
                InitialValues(1)=eval(get(h,'String'));
                set(theta0_value,'String',InitialValues(1))
            end
        catch
            set(theta0_value,'String',InitialValues(1))
            errordlg('Please input a number.','Warning')
        end
        UpdatePlot(InitialValues)
    end

    % Main simulation function
    function StartSimulation(hObject,eventdata,handles)
        if get(hObject,'Value')
            set(Start,'String','Stop');
            InitialValues(9)=0;
            PreviousValue=InitialValues; % When start, recharge
            CurrentValues=InitialValues;
            g0=2;
            g1=0.1;
            h=5;
            rulebase=[5,5,5,4,3;
                     5,5,4,3,2;
                     5,4,3,2,1;
                     4,3,2,1,1;
                     3,2,1,1,1];
            centerpoint=[-pi/2 -pi/4 0 pi/4 pi/2;-pi/4 -pi/8 0 pi/8 pi/4;-20 -10 0 10 20];
            width=[pi/2 pi/2 pi/2 pi/2 pi/2;pi/4 pi/4 pi/4 pi/4 pi/4;20 20 20 20 20];
            functiontype='triangle';
            COGtype='min';
            reference_theta=0;
            reference_dtheta=0;
            t_step=0.01;
            Choice='Stop';
        else
            set(Start,'String','Start');
            msgbox('Simulation has been stopped.', 'Simulation Finish');
        end
        % Begin simulation loop
        while get(hObject,'Value')
            % If angle is larger then 90 degree, stop.
            if CurrentValues(1)>pi/2 || CurrentValues(1)<-pi/2
                if CurrentValues(1)>pi/2
                    UpdatePlot([pi/2 0 0 0 0 0 0 0 0])
                else
                    UpdatePlot([-pi/2 0 0 0 0 0 0 0 0])
                end
                set(Start,'String','Start','Value',0);
                errordlg('Failed....','Duang')
                break;
            % If angle is around 0, ask stop or not
            elseif CurrentValues(1)<1e-3 && CurrentValues(1)>-1e-3 && CurrentValues(2)<1e-3 && CurrentValues(2)>-1e-3 && strcmpi(Choice,'Stop')
                Choice=questdlg('Now, angle and angle speed are perfect!!','Success',...
                    'Continue','Stop','Stop');
                if strcmpi(Choice,'Stop')
                    set(Start,'String','Start','Value',0);
                    msgbox('Simulation has been stopped.', 'Simulation Finish');
                    break;
                end
            end
            % Otherwise, continue
            % Calculate current input force according to previous situation
            CurrentValues(8)=FuzzyController(reference_theta-PreviousValue(1),...
                        reference_dtheta-PreviousValue(2),g0,g1,h,rulebase,...
                        centerpoint,width,functiontype,COGtype);
            [CurrentValues(9),CurrentValues(1),CurrentValues(2),CurrentValues(3),CurrentValues(4),CurrentValues(5),CurrentValues(6),CurrentValues(7)]=...
                InvertedPendulum(PreviousValue(9),PreviousValue(1),PreviousValue(2),PreviousValue(3),...
                                PreviousValue(4),PreviousValue(5),PreviousValue(6),PreviousValue(7),CurrentValues(8),t_step);
            % Update Plot based on current states
            UpdatePlot(CurrentValues);
            % Current State becomes previous State
            PreviousValue=CurrentValues;
            pause(t_step)
        end
    end


    % Initial Home Function
    function inithome
        % init figure window
        set(0,'Units','pixels')
        dim = get(0,'ScreenSize');
        fig_1 = figure('doublebuffer','on','Position',[0,35,dim(3)/2,dim(4)/2],...
            'MenuBar','none','Name','Inverted Pendulum Demo',...
            'NumberTitle','off','CloseRequestFcn',@del_app);
        hold on;
        title('Inverted Pendulum Simulation');
        daspect([1 1 1])
        % plot the platform
        VerticalGap=dim(3)/2/20;
        HorizontalGap=dim(4)/2/30;
        PanelWidth=dim(3)/15;
        leftend=-6.2;
        rightend=6.2;
        upend=10;
        lowend=0;
        axis([leftend rightend lowend upend+0.1]);
        plot([leftend rightend],[upend upend],'k')
        plot([leftend rightend],[lowend lowend],'k')
        plot([leftend leftend+0.5],[upend lowend],'k')
        plot([rightend rightend],[upend lowend],'k')
        rectangle('Position',[leftend lowend ...
            rightend-(leftend) upend-lowend],...
          'FaceColor','w')
        axis off
        AxisValue=[leftend rightend upend lowend];
        GapValue=[VerticalGap HorizontalGap];
        PanelPosition=[HorizontalGap VerticalGap+13 ...
            PanelWidth+25 dim(4)/2-2*VerticalGap-2];
        % Initial Plot
        % Position:
        % [leftdownx,leftupx,rightupx,rightdownx;
        %  leftdowny,leftupy,rightupy,rightdowny]
        PlateLengthX=AxisValue(2)-AxisValue(1);
        PlateCenterPointX=(AxisValue(2)+AxisValue(1))/2;
        PlateLengthY=AxisValue(3)-AxisValue(4);
        CartPosition=[PlateCenterPointX-PlateLengthX/8,PlateCenterPointX-PlateLengthX/8,...
                      PlateCenterPointX+PlateLengthX/8,PlateCenterPointX+PlateLengthX/8;...
                      AxisValue(4),AxisValue(4)+PlateLengthY/8,...
                      AxisValue(4)+PlateLengthY/8,AxisValue(4)];
        PendulumPosition=[PlateCenterPointX-PlateLengthX/80,PlateCenterPointX-PlateLengthX/80,...
                      PlateCenterPointX+PlateLengthX/80,PlateCenterPointX+PlateLengthX/80;...
                      AxisValue(4)+PlateLengthY/8-PlateLengthX/80,AxisValue(4)+PlateLengthY/8+PlateLengthY/3,...
                      AxisValue(4)+PlateLengthY/8+PlateLengthY/3,AxisValue(4)+PlateLengthY/8-PlateLengthX/80];
        PendulumReference=[PlateCenterPointX AxisValue(4)+PlateLengthY/8-PlateLengthX/80];
        % plot pendulum
        PendulumPlot=patch(PendulumPosition(1,:),PendulumPosition(2,:),'r');
        % plot cart
        CartPlot=patch(CartPosition(1,:),CartPosition(2,:),'b');
        % save plot
        setappdata(0,'PlotData',{CartPlot,PendulumPlot,PendulumReference});
        setappdata(0,'InitialPlotData',{CartPosition,PendulumPosition});
    end

    % Update Plot
    function UpdatePlot(CurrentSituation)
        % Update pendulum
        % get plot
        PlotData=getappdata(0,'PlotData');
        CartPlot=PlotData{1};
        PendulumPlot=PlotData{2};
        PendulumReference=PlotData{3};
        % get angle
        RotationAngle=CurrentSituation(1);
        % get initial position
        InitialPlotData=getappdata(0,'InitialPlotData');
        % calculate new position
        PendulumPositionOld=InitialPlotData{2};
        PendulumPositionNew=zeros(size(PendulumPositionOld));
        for i=1:4
            [PendulumPositionNew(1,i),PendulumPositionNew(2,i)]=rotation(PendulumPositionOld(1,i),...
                PendulumPositionOld(2,i),...
                PendulumReference(1),PendulumReference(2),RotationAngle);
        end
        % replot pendulum
        set(PendulumPlot,'XData',PendulumPositionNew(1,:));
        set(PendulumPlot,'YData',PendulumPositionNew(2,:));
        % save plot
        setappdata(0,'PlotData',{CartPlot,PendulumPlot,PendulumReference});
    end
    
    % Close Function
    function del_app(varargin)
        try
            rmappdata(0,'PlotData')
            rmappdata(0,'InitialPlotData')
        end
        delete(fig_1);
    end
    
    % 2D Clockwise Rotation
    function [x_new,y_new]=rotation(x_old,y_old,reference_x,reference_y,angle)
        angle=-angle;
        P=[x_old;y_old]-[reference_x;reference_y];
        P=[P(1)*cos(angle)-P(2)*sin(angle);P(1)*sin(angle)+P(2)*cos(angle)];
        P=P+[reference_x;reference_y];
        x_new=P(1);
        y_new=P(2);
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% for button of ui. this is copied from internet
    function [hout,ax_out] = uibutton(varargin)
        %uibutton: Create pushbutton with more flexible labeling than uicontrol.
        % Usage:
        %   uibutton accepts all the same arguments as uicontrol except for the
        %   following property changes:
        %
        %     Property      Values
        %     -----------   ------------------------------------------------------
        %     Style         'pushbutton', 'togglebutton' or 'text', default =
        %                   'pushbutton'.
        %     String        Same as for text() including cell array of strings and
        %                   TeX or LaTeX interpretation.
        %     Interpreter   'tex', 'latex' or 'none', default = default for text()
        %
        % Syntax:
        %   handle = uibutton('PropertyName',PropertyValue,...)
        %   handle = uibutton(parent,'PropertyName',PropertyValue,...)
        %   [text_obj,axes_handle] = uibutton('Style','text',...
        %       'PropertyName',PropertyValue,...)
        %
        % uibutton creates a temporary axes and text object containing the text to
        % be displayed, captures the axes as an image, deletes the axes and then
        % displays the image on the uicontrol.  The handle to the uicontrol is
        % returned.  If you pass in a handle to an existing uicontol as the first
        % argument then uibutton will use that uicontrol and not create a new one.
        %
        % If the Style is set to 'text' then the axes object is not deleted and the
        % text object handle is returned (as well as the handle to the axes in a
        % second output argument).
        %
        % See also UICONTROL.

        % Version: 1.6, 20 April 2006
        % Author:  Douglas M. Schwarz
        % Email:   dmschwarz=ieee*org, dmschwarz=urgrad*rochester*edu
        % Real_email = regexprep(Email,{'=','*'},{'@','.'})


        % Detect if first argument is a uicontrol handle.
        keep_handle = false;
        if nargin > 0
            h = varargin{1};
            if isscalar(h) && ishandle(h) && strcmp(get(h,'Type'),'uicontrol')
                keep_handle = true;
                varargin(1) = [];
            end
        end

        % Parse arguments looking for 'Interpreter' property.  If found, note its
        % value and then remove it from where it was found.
        interp_value = get(0,'DefaultTextInterpreter');
        arg = 1;
        remove = [];
        while arg <= length(varargin)
            v = varargin{arg};
            if isstruct(v)
                fn = fieldnames(v);
                for i = 1:length(fn)
                    if strncmpi(fn{i},'interpreter',length(fn{i}))
                        interp_value = v.(fn{i});
                        v = rmfield(v,fn{i});
                    end
                end
                varargin{arg} = v;
                arg = arg + 1;
            elseif ischar(v)
                if strncmpi(v,'interpreter',length(v))
                    interp_value = varargin{arg+1};
                    remove = [remove,arg,arg+1];
                end
                arg = arg + 2;
            elseif arg == 1 && isscalar(v) && ishandle(v) && ...
                    any(strcmp(get(h,'Type'),{'figure','uipanel'}))
                arg = arg + 1;
            else
                error('Invalid property or uicontrol parent.')
            end
        end
        varargin(remove) = [];

        % Create uicontrol, get its properties then hide it.
        if keep_handle
            set(h,varargin{:})
        else
            h = uicontrol(varargin{:});
        end
        s = get(h);
        if ~any(strcmp(s.Style,{'pushbutton','togglebutton','text'}))
            delete(h)
            error('''Style'' must be pushbutton, togglebutton or text.')
        end
        set(h,'Visible','off')

        % Create axes.
        parent = get(h,'Parent');
        ax = axes('Parent',parent,...
            'Units',s.Units,...
            'Position',s.Position,...
            'XTick',[],'YTick',[],...
            'XColor',s.BackgroundColor,...
            'YColor',s.BackgroundColor,...
            'Box','on',...
            'Color',s.BackgroundColor);
        % Adjust size of axes for best appearance.
        set(ax,'Units','pixels')
        pos = round(get(ax,'Position'));
        if strcmp(s.Style,'text')
            set(ax,'Position',pos + [0 1 -1 -1])
        else
            set(ax,'Position',pos + [4 4 -8 -8])
        end
        switch s.HorizontalAlignment
            case 'left'
                x = 0.0;
            case 'center'
                x = 0.5;
            case 'right'
                x = 1;
        end
        % Create text object.
        text_obj = text('Parent',ax,...
            'Position',[x,0.5],...
            'String',s.String,...
            'Interpreter',interp_value,...
            'HorizontalAlignment',s.HorizontalAlignment,...
            'VerticalAlignment','middle',...
            'FontName',s.FontName,...
            'FontSize',s.FontSize,...
            'FontAngle',s.FontAngle,...
            'FontWeight',s.FontWeight,...
            'Color',s.ForegroundColor);

        % If we are creating something that looks like a text uicontrol then we're
        % all done and we return the text object and axes handles rather than a
        % uicontrol handle.
        if strcmp(s.Style,'text')
            delete(h)
            if nargout
                hout = text_obj;
                ax_out = ax;
            end
            return
        end

        % Capture image of axes and then delete the axes.
        frame = getframe(ax);
       % delete(ax)

        % Build RGB image, set background pixels to NaN and put it in 'CData' for
        % the uicontrol.
        if isempty(frame.colormap)
            rgb = frame.cdata;
        else
            rgb = reshape(frame.colormap(frame.cdata,:),[pos([4,3]),3]);
        end
        size_rgb = size(rgb);
        rgb = double(rgb)/255;
        back = repmat(permute(s.BackgroundColor,[1 3 2]),size_rgb(1:2));
        isback = all(rgb == back,3);
        rgb(repmat(isback,[1 1 3])) = NaN;
        set(h,'CData',rgb,'String','','Visible',s.Visible)

        % Assign output argument if necessary.
        if nargout
            hout = h;
        end
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end

