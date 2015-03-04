function test_InvertedPendulum_without_controller(varargin)
% Test the inverted pendulum model of "InvertedPendulum.m" file
% test_InvertedPendulum_without_controller(t_step,L)
% inputs:
%   t_step: time step, default is 0.001
%   L: step length, default is 5000
% outputs:
%   figure 1: force, angle acceleration, car position acceleration
%   figure 2: angle situation, car position situation

    if isempty(varargin)
        t_step=0.001;
        L=5000;
    else
        t_step=varargin{1};
        L=varargin{2};
    end
    % Initial situation
    t=zeros(1,L);
    theta=zeros(1,L);
    dtheta=zeros(1,L);
    ddtheta=zeros(1,L);
    x=zeros(1,L);
    dx=zeros(1,L);
    ddx=zeros(1,L);
    F=zeros(1,L);
    t(1)=0;
    theta(1)=0.1;
    dtheta(1)=0;
    ddtheta(1)=0;
    x(1)=0;
    dx(1)=0;
    ddx(1)=0;
    F(1)=0;
    % Control signal
    inputF=0;
    % begin to test
    for i=2:L
        [t(i),theta(i),dtheta(i),ddtheta(i),x(i),dx(i),ddx(i),F(i)]=InvertedPendulum(t(i-1),theta(i-1),dtheta(i-1),ddtheta(i-1),x(i-1),dx(i-1),ddx(i-1),F(i-1),inputF,t_step);
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