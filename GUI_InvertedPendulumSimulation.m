function GUI_InvertedPendulumSimulation
%% Initial Data
% Initial Data
% theta0, dtheta0, ddtheta0, x0, dx0, ddx0, F0, inputF, t
InitialValues=[0 0 0 0 0 0 0 0 0];
PreviousValue=InitialValues; % When start, recharge
CurrentValues=InitialValues; % When start, recharge
Gain=[2 0.1 5]; %g0, g1, h
Rule=25; % 25 rules or 49 rules
centerpoint=[-pi/2 -pi/4 0 pi/4 pi/2;-pi/4 -pi/8 0 pi/8 pi/4;-20 -10 0 10 20];
width=[pi/2 pi/2 pi/2 pi/2 pi/2;pi/4 pi/4 pi/4 pi/4 pi/4;20 20 20 20 20];
UniformOrNot=1;
functiontype='triangle';
COGtype='min';
reference_theta=0;
reference_dtheta=0;
%% Initial App Window
[fig_1, GapValue, PanelPosition, PanelPosition1, PanelPosition2] = inithome;
%% Build Initial Value Panel
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
    'String','$\frac{d^2x}{dt^2}$:',...
    'Position',[LH,3*BD+2*HD,WD,HD],...
    'FontSize',11,...
    'Interpreter','latex');
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
    'String','$\frac{dx}{dt}$:',...
    'Position',[LH,4*BD+3*HD,WD,HD],...
    'FontSize',11,...
    'Interpreter','latex');
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
    'String','$\frac{d^2\theta}{dt^2}$:',...
    'Position',[LH,6*BD+5*HD,WD,HD],...
    'FontSize',11,...
    'Interpreter','latex');
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
    'String','$\frac{d\theta}{dt}$:',...
    'Position',[LH,7*BD+6*HD,WD,HD],...
    'FontSize',11,...
    'Interpreter','latex');
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
    end
%% Parameter Panel
% Parameters of fuzzy controller
% This panel needs to contain
%   (1) g0
%   (2) g1
%   (3) h
%   (4) reference theta
%   (5) reference dtheta
%   (6) membership function
ParameterValuePanel=uipanel(fig_1,...
    'units','pixels',...
    'Position',PanelPosition2,...
    'Title','Parameters','FontSize',11);
g0_text=uibutton(ParameterValuePanel,'style','text',...
    'String','g0=',...
    'Position',[LH,PanelPosition2(4)/10,WD,HD],...
    'FontSize',11);
g0_value=uicontrol(ParameterValuePanel,'style','edit',...
    'String',Gain(1),...
    'callback',@g0_value_input,...
    'Position',[2*LH+WD,PanelPosition2(4)/10,WD,HD],...
    'FontSize',11);
g1_text=uibutton(ParameterValuePanel,'style','text',...
    'String','g1=',...
    'Position',[3*LH+2*WD,PanelPosition2(4)/10,WD,HD],...
    'FontSize',11);
g1_value=uicontrol(ParameterValuePanel,'style','edit',...
    'String',Gain(2),...
    'callback',@g1_value_input,...
    'Position',[4*LH+3*WD,PanelPosition2(4)/10,WD,HD],...
    'FontSize',11);
h_text=uibutton(ParameterValuePanel,'style','text',...
    'String','h=',...
    'Position',[5*LH+4*WD,PanelPosition2(4)/10,WD,HD],...
    'FontSize',11);
h_value=uicontrol(ParameterValuePanel,'style','edit',...
    'String',Gain(3),...
    'callback',@h_value_input,...
    'Position',[6*LH+5*WD,PanelPosition2(4)/10,WD,HD],...
    'FontSize',11);
reference_angle_text=uibutton(ParameterValuePanel,'style','text',...
    'String','$\theta_{\mbox{ref}}$=',...
    'Position',[7*LH+6*WD,PanelPosition2(4)/10,WD,HD],...
    'FontSize',11,...
    'Interpreter','latex');
reference_angle_value=uicontrol(ParameterValuePanel,'style','edit',...
    'String',reference_theta,...
    'callback',@reference_angle_value_input,...
    'Position',[8*LH+7*WD,PanelPosition2(4)/10,WD,HD],...
    'FontSize',11);
reference_angle_unit=uibutton(ParameterValuePanel,'style','text',...
    'String','(rad)',...
    'Position',[9*LH+8*WD,PanelPosition2(4)/10,WD,HD],...
    'FontSize',11,...
    'Interpreter','latex');
reference_angle_speed_text=uibutton(ParameterValuePanel,'style','text',...
    'String','$\frac{d\theta}{dt}_{\mbox{ref}}$=',...
    'Position',[10*LH+9*WD,PanelPosition2(4)/10,WD,HD],...
    'FontSize',11,...
    'Interpreter','latex');
reference_angle_speed_value=uicontrol(ParameterValuePanel,'style','edit',...
    'String',reference_dtheta,...
    'callback',@reference_angle_speed_value_input,...
    'Position',[11*LH+10*WD,PanelPosition2(4)/10,WD,HD],...
    'FontSize',11);
reference_angle_speed_unit=uibutton(ParameterValuePanel,'style','text',...
    'String','(rad/s)',...
    'Position',[12*LH+11*WD,PanelPosition2(4)/10,WD,HD],...
    'FontSize',11,...
    'Interpreter','latex');
% MembershipFunction_text=uibutton(ParameterValuePanel,'style','text',...
%     'String','Membership functions: ',...
%     'Position',[13*LH+12*WD,PanelPosition2(4)/10,WD,HD],...
%     'FontSize',11);
MembershipFunction_value=uicontrol(ParameterValuePanel,'style','popup',...
    'String',{'triangle';'Gaussian'},...
    'Position',[16*LH+12*WD,PanelPosition2(4)/10,1.8*WD,HD],...
    'FontSize',11,...
    'Callback',@SelectMembershipFunction);
Rules_value=uicontrol(ParameterValuePanel,'style','popup',...
    'String',{'25 rules';'49 rules'},...
    'Position',[16*LH+14*WD,PanelPosition2(4)/10,1.8*WD,HD],...
    'FontSize',11,...
    'Callback',@SelectRulesNumber);
Uniform_value=uicontrol(ParameterValuePanel,'style','popup',...
    'String',{'Uniform';'Nonuniform'},...
    'Position',[16*LH+16*WD,PanelPosition2(4)/10,1.8*WD,HD],...
    'FontSize',11,...
    'Callback',@SelectUniform);
    
    function SelectUniform(hObj,event)
        val=get(hObj,'Value');
        if val==1
            UniformOrNot=1;
        elseif val==2
            UniformOrNot=0;
        end
    end
    function SelectMembershipFunction(hObj,event)
        val=get(hObj,'Value');
        if val==1
            functiontype='triangle';
            COGtype='min';
        elseif val==2
            functiontype='Gaussian';
            COGtype='product';
        end
    end
    function SelectRulesNumber(hObj,event)
        val=get(hObj,'Value');
        if val==1
            Rule=25;
        elseif val==2
            Rule=49;
        end
    end
    function g0_value_input(h,dummy)
        try
            Gain(1)=eval(get(h,'String'));
            set(g0_value,'String',Gain(1))
        catch
            set(g0_value,'String',Gain(1))
            errordlg('Please input a number.','Warning')
        end
    end
    function g1_value_input(h,dummy)
        try
            Gain(2)=eval(get(h,'String'));
            set(g1_value,'String',Gain(2))
        catch
            set(g1_value,'String',Gain(2))
            errordlg('Please input a number.','Warning')
        end
    end
    function h_value_input(h,dummy)
        try
            Gain(3)=eval(get(h,'String'));
            set(h_value,'String',Gain(3))
        catch
            set(h_value,'String',Gain(3))
            errordlg('Please input a number.','Warning')
        end
    end
    function reference_angle_value_input(h,dummy)
        try
            if eval(get(h,'String'))>pi/2
                reference_theta=pi/2;
                set(reference_angle_value,'String',reference_theta)
                errordlg('Maximum angle is pi/2.','Warning')
            elseif eval(get(h,'String'))<-pi/2
                reference_theta=-pi/2;
                set(reference_angle_value,'String',reference_theta)
                errordlg('Minimum angle is pi/2.','Warning')
            else
                reference_theta=eval(get(h,'String'));
                set(reference_angle_value,'String',reference_theta)
            end
        catch
            set(reference_angle_value,'String',reference_theta)
            errordlg('Please input a number.','Warning')
        end
    end
    function reference_angle_speed_value_input(h,dummy)
        try
            reference_dtheta=eval(get(h,'String'));
            set(reference_angle_speed_value,'String',reference_dtheta)
        catch
            set(reference_angle_speed_value,'String',reference_dtheta)
            errordlg('Please input a number.','Warning')
        end
    end
%% Build Current Values Panel
% Current Value Panel
% This Panel needs to contain
%   (1) theta
%   (2) dtheta
%   (3) ddtheta
%   (4) x
%   (5) dx
%   (6) ddx
%   (7) F_{out}
%   (8) F_{in}
%   (9) time
LH=PanelPosition1(3)/60;
BD=PanelPosition1(4)/15;
HD=(PanelPosition1(4)-10*BD)/9;
WD=(PanelPosition1(3)-4*LH)/3;
CurrentValuePanel=uipanel(fig_1,...
    'units','pixels',...
    'Position',PanelPosition1,...
    'Title','Current Values','FontSize',11);
Time_text=uibutton(CurrentValuePanel,'style','text',...
    'String','t=',...
    'Position',[LH,BD,WD,HD],...
    'FontSize',11);
Time_value=uibutton(CurrentValuePanel,'style','text',...
    'String',CurrentValues(9),...
    'Position',[2*LH+WD,BD,WD,HD],...
    'FontSize',11);
Time_unit=uibutton(CurrentValuePanel,'style','text',...
    'String','( s )',...
    'Position',[3*LH+2*WD,BD,WD,HD],...
    'FontSize',11);
Fin_text=uibutton(CurrentValuePanel,'style','text',...
    'String','F_{in}=',...
    'Position',[LH,2*BD+HD,WD,HD],...
    'FontSize',11);
Fin_value=uibutton(CurrentValuePanel,'style','text',...
    'String',CurrentValues(8),...
    'Position',[2*LH+WD,2*BD+HD,WD,HD],...
    'FontSize',11);
Fin_unit=uibutton(CurrentValuePanel,'style','text',...
    'String','( N )',...
    'Position',[3*LH+2*WD,2*BD+HD,WD,HD],...
    'FontSize',11);
Fout_text=uibutton(CurrentValuePanel,'style','text',...
    'String','F_{out}=',...
    'Position',[LH,3*BD+2*HD,WD,HD],...
    'FontSize',11);
Fout_value=uibutton(CurrentValuePanel,'style','text',...
    'String',CurrentValues(7),...
    'Position',[2*LH+WD,3*BD+2*HD,WD,HD],...
    'FontSize',11);
Fin_out=uibutton(CurrentValuePanel,'style','text',...
    'String','( N )',...
    'Position',[3*LH+2*WD,3*BD+2*HD,WD,HD],...
    'FontSize',11);
ddx_text=uibutton(CurrentValuePanel,'style','text',...
    'String','$\frac{d^2x}{dt^2}$=',...
    'Position',[LH,4*BD+3*HD,WD,HD],...
    'FontSize',11,...
    'Interpreter','latex');
ddx_value=uibutton(CurrentValuePanel,'style','text',...
    'String',CurrentValues(6),...
    'Position',[2*LH+WD,4*BD+3*HD,WD,HD],...
    'FontSize',11);
ddx_unit=uibutton(CurrentValuePanel,'style','text',...
    'String','(m/s^2)',...
    'Position',[3*LH+2*WD,4*BD+3*HD,WD,HD],...
    'FontSize',11);
dx_text=uibutton(CurrentValuePanel,'style','text',...
    'String','$\frac{dx}{dt}$=',...
    'Position',[LH,5*BD+4*HD,WD,HD],...
    'FontSize',11,...
    'Interpreter','latex');
dx_value=uibutton(CurrentValuePanel,'style','text',...
    'String',CurrentValues(5),...
    'Position',[2*LH+WD,5*BD+4*HD,WD,HD],...
    'FontSize',11);
dx_unit=uibutton(CurrentValuePanel,'style','text',...
    'String','(m/s)',...
    'Position',[3*LH+2*WD,5*BD+4*HD,WD,HD],...
    'FontSize',11);
x_text=uibutton(CurrentValuePanel,'style','text',...
    'String','x=',...
    'Position',[LH,6*BD+5*HD,WD,HD],...
    'FontSize',11);
x_value=uibutton(CurrentValuePanel,'style','text',...
    'String',CurrentValues(4),...
    'Position',[2*LH+WD,6*BD+5*HD,WD,HD],...
    'FontSize',11);
x_unit=uibutton(CurrentValuePanel,'style','text',...
    'String','( m )',...
    'Position',[3*LH+2*WD,6*BD+5*HD,WD,HD],...
    'FontSize',11);
ddtheta_text=uibutton(CurrentValuePanel,'style','text',...
    'String','$\frac{d^2\theta}{dt^2}$=',...
    'Position',[LH,7*BD+6*HD,WD,HD],...
    'FontSize',11,...
    'Interpreter','latex');
ddtheta_value=uibutton(CurrentValuePanel,'style','text',...
    'String',CurrentValues(3),...
    'Position',[2*LH+WD,7*BD+6*HD,WD,HD],...
    'FontSize',11);
ddtheta_unit=uibutton(CurrentValuePanel,'style','text',...
    'String','( rad/s^2 )',...
    'Position',[3*LH+2*WD,7*BD+6*HD,WD,HD],...
    'FontSize',11);
dtheta_text=uibutton(CurrentValuePanel,'style','text',...
    'String','$\frac{d\theta}{dt}$=',...
    'Position',[LH,8*BD+7*HD,WD,HD],...
    'FontSize',11,...
    'Interpreter','latex');
dtheta_value=uibutton(CurrentValuePanel,'style','text',...
    'String',CurrentValues(2),...
    'Position',[2*LH+WD,8*BD+7*HD,WD,HD],...
    'FontSize',11);
dtheta_unit=uibutton(CurrentValuePanel,'style','text',...
    'String','( rad/s )',...
    'Position',[3*LH+2*WD,8*BD+7*HD,WD,HD],...
    'FontSize',11);
theta_text=uibutton(CurrentValuePanel,'style','text',...
    'String','\theta=',...
    'Position',[LH,9*BD+8*HD,WD,HD],...
    'FontSize',11);
theta_value=uibutton(CurrentValuePanel,'style','text',...
    'String',CurrentValues(1),...
    'Position',[2*LH+WD,9*BD+8*HD,WD,HD],...
    'FontSize',11);
theta_unit=uibutton(CurrentValuePanel,'style','text',...
    'String','( rad )',...
    'Position',[3*LH+2*WD,9*BD+8*HD,WD,HD],...
    'FontSize',11);

%% Main simulation function
    function StartSimulation(hObject,eventdata,handles)
        if get(hObject,'Value')
            set(Start,'String','Stop');
            InitialValues(9)=0;
            PreviousValue=InitialValues; % When start, recharge
            CurrentValues=InitialValues;
            if Rule==25
                rulebase=[5,5,5,4,3;
                          5,5,4,3,2;
                          5,4,3,2,1;
                          4,3,2,1,1;
                          3,2,1,1,1];
                 if UniformOrNot
                    centerpointvalues=[-pi/2 -pi/4 0 pi/4 pi/2;-pi/4 -pi/8 0 pi/8 pi/4;-20 -10 0 10 20];
                    widthvalue=[pi/2 pi/2 pi/2 pi/2 pi/2;pi/4 pi/4 pi/4 pi/4 pi/4;20 20 20 20 20];
                 else
                    centerpointvalues=[-pi/2 -pi/4 0 pi/4 pi/2;-pi/4 -pi/8 0 pi/8 pi/4;-20 -5 0 5 20];
                    widthvalue=[pi/2 pi/2 pi/2 pi/2 pi/2;pi/4 pi/4 pi/4 pi/4 pi/4;10 10 10 10 10];
                 end
            else
                rulebase=[7,7,7,7,6,5,4;7,7,7,6,5,4,3;...
                          7,7,6,5,4,3,2;7,6,5,4,3,2,1;...
                          6,5,4,3,2,1,1;5,4,3,2,1,1,1;...
                          4,3,2,1,1,1,1];
                 if UniformOrNot
                    centerpointvalues=[-pi/2 -pi/3 -pi/6 0 pi/6 pi/3 pi/2;...
                         -pi/4 -pi/6 -pi/12 0 pi/12 pi/6 pi/4;...
                        -20 -40/3 -20/3 0 20/3 40/3 20];
                    widthvalue=[pi/3 pi/3 pi/3 pi/3 pi/3 pi/3 pi/3;...
                         pi/6 pi/6 pi/6 pi/6 pi/6 pi/6 pi/6;...
                        40/3 40/3 40/3 40/3 40/3 40/3 40/3];
                 else
                     centerpointvalues=[-pi/2 -pi/3 -pi/6 0 pi/6 pi/3 pi/2;...
                                -pi/4 -pi/6 -pi/12 0 pi/12 pi/6 pi/4;...
                                -60 -80/3 -20/3 0 20/3 80/3 60];
                     widthvalue=[pi/3 pi/3 pi/3 pi/3 pi/3 pi/3 pi/3;...
                                pi/6 pi/6 pi/6 pi/6 pi/6 pi/6 pi/6;...
                                40/3 40/3 40/3 40/3 40/3 40/3 40/3];
                 end
            end
            g0=Gain(1);
            g1=Gain(2);
            h=Gain(3);
            %centerpointvalues=centerpoint;
            referencevalue=[reference_theta reference_dtheta];
            %widthvalue=width;
            functiontypevalue=functiontype;
            COGtypevalue=COGtype;
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
            elseif referencevalue(1)-CurrentValues(1)<1e-3 &&...
                    referencevalue(1)-CurrentValues(1)>-1e-3 &&...
                    referencevalue(2)-CurrentValues(2)<1e-3 &&...
                    referencevalue(2)-CurrentValues(2)>-1e-3 &&...
                    strcmpi(Choice,'Stop')
                Choice=questdlg('Now, angle and angle speed are almost perfect!! (abs(error)<1e-3)','Success',...
                    'Continue','Stop','Stop');
                if strcmpi(Choice,'Stop')
                    set(Start,'String','Start','Value',0);
                    msgbox('Simulation has been stopped.', 'Simulation Finish');
                    break;
                end
            end
            % Otherwise, continue
            % Calculate current input force according to previous situation
            CurrentValues(8)=FuzzyController(referencevalue(1)-PreviousValue(1),...
                        referencevalue(2)-PreviousValue(2),g0,g1,h,rulebase,...
                        centerpointvalues,widthvalue,functiontypevalue,COGtypevalue);
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

%% Initial Home Function
    function [fig_1, GapValue, PanelPosition, PanelPosition1, PanelPosition2] = inithome
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
        PanelPosition1=[dim(3)/2.45 VerticalGap+10 ...
            PanelWidth+25 dim(4)/2-2*VerticalGap-2];
        PanelPosition2=[HorizontalGap 0 ...
            PanelWidth*7.28 dim(4)/20];
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
        setappdata(fig_1,'PlotData',{CartPlot,PendulumPlot,PendulumReference});
        setappdata(fig_1,'InitialPlotData',{CartPosition,PendulumPosition});
    end

%% Update Plot function
    function UpdatePlot(CurrentSituation)
        % Update pendulum
        % get plot
        PlotData=getappdata(fig_1,'PlotData');
        CartPlot=PlotData{1};
        PendulumPlot=PlotData{2};
        PendulumReference=PlotData{3};
        % get angle
        RotationAngle=CurrentSituation(1);
        % get initial position
        InitialPlotData=getappdata(fig_1,'InitialPlotData');
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
        setappdata(fig_1,'PlotData',{CartPlot,PendulumPlot,PendulumReference});
        % Update Current Values
        set(Time_value,'String',round(CurrentSituation(9)*1e4)/1e4);
        set(Fin_value,'String',round(CurrentSituation(8)*1e4)/1e4);
        set(Fout_value,'String',round(CurrentSituation(7)*1e4)/1e4);
        set(ddx_value,'String',round(CurrentSituation(6)*1e4)/1e4);
        set(dx_value,'String',round(CurrentSituation(5)*1e4)/1e4);
        set(x_value,'String',round(CurrentSituation(4)*1e4)/1e4);
        set(ddtheta_value,'String',round(CurrentSituation(3)*1e4)/1e4);
        set(dtheta_value,'String',round(CurrentSituation(2)*1e4)/1e4);
        set(theta_value,'String',round(CurrentSituation(1)*1e4)/1e4);
    end
    
    % Close Function
    function del_app(varargin)
        try
            rmappdata(fig_1,'PlotData')
            rmappdata(fig_1,'InitialPlotData')
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

