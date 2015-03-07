function [t,theta,dtheta,ddtheta,x,dx,ddx,F]=InvertedPendulum(t0,theta0,...
    dtheta0,ddtheta0,x0,dx0,ddx0,F0,inputF,t_step)
% Build a inverted pendulum model. Calculate the current values based on
% the previous values. This model is from "Fuzzy Control" p.78 eq. (2.24).
% According to equations in the book, we can get more parameters:
%   l=0.5, m=0.5, M=1
% [t,theta,dtheta,ddtheta,x,dx,ddx,F]=InvertedPendulum(t0,theta0,...
%    dtheta0,ddtheta0,x0,dx0,ddx0,F0,inputF,t_step)
% inputs:
%   t0: time value of previous step
%   theta0: angle value of previous step
%   dtheta0: angle speed of previous step
%   ddtheta0: angle acceleration of previous step
%   x0: car position of previous step
%   dx0: car speed of previous step
%   ddx0: car acceleration of previous step
%   F0: force value of previous step (after filter)
%   inputF: input force value of current step
%   t_step: step size of time
% outputs:
%   t: time value of current step
%   theta: angle value of current step
%   dtheta: angle speed of current step
%   ddtheta: angle acceleration of current step
%   x: car position of current position
%   dx: car speed of current position
%   ddx: car acceleration of current position
%   F: force value of current step (after filter)

% Get force
fx_F=@(t,F,inputF) -100.*F+100.*inputF;
fx=@(t,F) fx_F(t,F,inputF);
[t,F]=ODE_RK(t0,F0,t_step,fx,1);
t=t(end);
F=F(end);
% Get theta
theta=theta0+t_step.*dtheta0+0.5.*ddtheta0.*t_step.^2;
% Get dtheta
fx_dtheta=@(t,theta,dtheta,F) (9.8.*sin(theta)+cos(theta).*...
    ((-F-0.25.*dtheta.^2.*sin(theta))./(1.5)))./...
    (0.5.*(4/3-1/3.*cos(theta).^2));
fx=@(t,dtheta) fx_dtheta(t,theta,dtheta,F);
[~,dtheta]=ODE_RK(t0,dtheta0,t_step,fx,1);
dtheta=dtheta(end);
% Get ddtheta
ddtheta=(9.8.*sin(theta)+cos(theta).*((-F-0.25.*dtheta.^2.*sin(theta))./...
    (1.5)))./(0.5.*(4/3-1/3.*cos(theta).^2));
% Get car position
x=x0+t_step.*dx0+0.5.*ddx0.*t_step.^2;
% Get car speed
dx=dx0+t_step.*ddx0;
% Get car acceleration
l=0.5; m=0.5; M=1;
ddx=(F-m*l*ddtheta*cos(theta)+m*l*dtheta^2*sin(theta))./(m+M);

end