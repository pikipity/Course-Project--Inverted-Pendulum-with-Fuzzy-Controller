function test_InvertedPendulum_with_fuzzy_controller(varargin)
% Test the fuzzy controller.
% test_InvertedPendulum_with_fuzzy_controller(t_step, L, g0, g1, h, t_0,...
% theta,x, F_0, rulebase, centerpoint, width, functiontype, COGtype)
% Inputs:
%   t_step: time step, default is 0.001
%   L: step length, default is 3/t_step (3 seconds)
%   g0: input gain of e, default is 1
%   g1: input gain of de, default is 1
%   h: output gain, default is 1
%   t_0: initial time, default is 0
%   theta: an array which stores initial angle position, initial angle
%          speed, initial angle acceleration, reference angle position,
%          reference angle speed, default is [0.1 0 0 0 0]
%   x: an array which stores initial car position, initial car speed,
%      initial car acceleration, default is [0 0 0]
%   F_0: initial input force, default is 0
%   rulebase: rule base matrix, default is [5,5,5,4,3;
%                                           5,5,4,3,2;
%                                           5,4,3,2,1;
%                                           4,3,2,1,1;
%                                           3,2,1,1,1]
%   centerpoint: center point array of membership function, 
%                default is [-pi/2 -pi/4 0 pi/4 pi/2;-pi/4 -pi/8 0 pi/8 pi/4;-20 -10 0 10 20]
%   width: bottom width array of membership function,
%          default is [pi/2 pi/2 pi/2 pi/2 pi/2;pi/4 pi/4 pi/4 pi/4 pi/4;20 20 20 20 20]
%   functiontype: membership function type, default is 'triangle'
%   COGtype: fuzzy logic type, default is 'min'
% outputs:
%   figure 1: force, angle acceleration, car position acceleration
%   figure 2: angle situation, car position situation

if mod(length(varargin),2)==1
    error('Error input. input should be (''t_0'',10)')
end
%Generate default values
t_step=0.001;
L=floor(3./t_step);
g0=1;
g1=1;
h=1;
t_0=0;
theta_0=0.1;
dtheta_0=0;
ddtheta_0=0;
x_0=0;
dx_0=0;
ddx_0=0;
F_0=0;
reference_theta=0;
reference_dtheta=0;
rulebase=[5,5,5,4,3;
          5,5,4,3,2;
          5,4,3,2,1;
          4,3,2,1,1;
          3,2,1,1,1];
centerpoint=[-pi/2 -pi/4 0 pi/4 pi/2;-pi/4 -pi/8 0 pi/8 pi/4;-20 -10 0 10 20];
width=[pi/2 pi/2 pi/2 pi/2 pi/2;pi/4 pi/4 pi/4 pi/4 pi/4;20 20 20 20 20];
functiontype='triangle';
COGtype='min';
% Get input
for i=1:2:length(varargin)
    if strcmpi(varargin{i},'t_step')
        t_step=varargin{i+1};
    elseif strcmpi(varargin{i},'L')
        L=varargin{i+1};
    elseif strcmpi(varargin{i},'g0')
        g0=varargin{i+1};
    elseif strcmpi(varargin{i},'g1')
        g1=varargin{i+1};
    elseif strcmpi(varargin{i},'h')
        h=varargin{i+1};
    elseif strcmpi(varargin{i},'t_0')
        t_0=varargin{i+1};
    elseif strcmpi(varargin{i},'theta')
        theta_0=varargin{i+1}(1);
        dtheta_0=varargin{i+1}(2);
        ddtheta_0=varargin{i+1}(3);
        reference_theta=varargin{i+1}(4);
        reference_dtheta=varargin{i+1}(5);
    elseif strcmpi(varargin{i},'x')
        x_0=varargin{i+1}(1);
        dx_0=varargin{i+1}(2);
        ddx_0=varargin{i+1}(3);
    elseif strcmpi(varargin{i},'F_0')
        F_0=varargin{i+1};
    elseif strcmpi(varargin{i},'rulebase')
        rulebase=varargin{i+1};
    elseif strcmpi(varargin{i},'centerpoint')
        centerpoint=varargin{i+1};
    elseif strcmpi(varargin{i},'width')
        width=varargin{i+1};
    elseif strcmpi(varargin{i},'functiontype')
        functiontype=varargin{i+1};
    elseif strcmpi(varargin{i},'COGtype')
        COGtype=varargin{i+1};
    end
end
% Initial variables
t=zeros(1,L);
theta=zeros(1,L);
dtheta=zeros(1,L);
ddtheta=zeros(1,L);
x=zeros(1,L);
dx=zeros(1,L);
ddx=zeros(1,L);
F=zeros(1,L);
inputF=zeros(1,L);
t(1)=t_0;
theta(1)=theta_0;
dtheta(1)=dtheta_0;
ddtheta(1)=ddtheta_0;
x(1)=x_0;
dx(1)=dx_0;
ddx(1)=ddx_0;
F(1)=F_0;
inputF(1)=F_0;
% begin to test
for i=2:L
    % Calculate next input force according to previous situation
    inputF(i)=FuzzyController(reference_theta-theta(i-1),reference_dtheta-dtheta(i-1),g0,g1,h,rulebase,centerpoint,width,functiontype,COGtype);
    % Calculate next situation according to next input force
    [t(i),theta(i),dtheta(i),ddtheta(i),x(i),dx(i),ddx(i),F(i)]=InvertedPendulum(t(i-1),theta(i-1),dtheta(i-1),ddtheta(i-1),x(i-1),dx(i-1),ddx(i-1),F(i-1),inputF(i),t_step);
end
% plot results
fontsize=15;
linewidth=3;
marksize=10;
figure;
subplot(3,1,1)
plot(t,F,'LineWidth',linewidth,'MarkerSize',marksize);
axis([min(t) max(t) min(F) max(F)])
grid on;
xlabel('Time (s)','FontSize',fontsize);
ylabel('Input Force (N)','FontSize',fontsize);
set(gca,'FontSize',fontsize);
subplot(3,1,2)
plot(t,ddtheta,'LineWidth',linewidth,'MarkerSize',marksize);
axis([min(t) max(t) min(ddtheta) max(ddtheta)])
grid on;
xlabel('Time (s)','FontSize',fontsize);
ylabel('Angle Acceleration','FontSize',fontsize);
set(gca,'FontSize',fontsize);
subplot(3,1,3)
plot(t,ddx,'LineWidth',linewidth,'MarkerSize',marksize);
axis([min(t) max(t) min(ddx) max(ddx)])
grid on;
xlabel('Time (s)','FontSize',fontsize);
ylabel('Car Acceleration','FontSize',fontsize);
set(gca,'FontSize',fontsize);
figure
subplot(2,1,1)
plot(t,theta,t,dtheta,'LineWidth',linewidth,'MarkerSize',marksize);
axis([min(t) max(t) min([min(theta) min(dtheta)]) max([max(theta) max(dtheta)])])
grid on;
xlabel('Time (s)','FontSize',fontsize);
legend('\theta','d\theta/dt')
set(gca,'FontSize',fontsize);
subplot(2,1,2)
plot(t,x,t,dx,'LineWidth',linewidth,'MarkerSize',marksize);
axis([min(t) max(t) min([min(x) min(dx)]) max([max(x) max(dx)])])
grid on;
xlabel('Time (s)','FontSize',fontsize);
legend('x','dx/dt')
set(gca,'FontSize',fontsize);
end