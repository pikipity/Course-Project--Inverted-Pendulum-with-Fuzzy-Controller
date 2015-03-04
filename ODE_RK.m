function [x,y]=ODE_RK(x0,y0,h,fx,N)
% Use the RK method to calculate the ODE of y'=f(x,y)
% [x,y]=PDE_RK(x0,y0,h,fx,N)
% Inputs:
%   x0: first x
%   y0: first y
%   h: step
%   fx: function of f(x,y). it should be like
%       fx=@(x,y) y;
%   N: steps
% Outputs: 
%   x: store x array
%   y: store y array
x=zeros(1,N+1);
y=zeros(1,N+1);
x(1)=x0;
y(1)=y0;
n=0;
while n<N
    n=n+1;
    k1=h*fx(x(n),y(n));
    k2=h*fx(x(n)+0.5*h,y(n)+0.5*k1);
    k3=h*fx(x(n)+0.5*h,y(n)+0.5*k2);
    k4=h*fx(x(n)+h,y(n)+k3);
    x(n+1)=x(n)+h;
    y(n+1)=y(n)+1/6*(k1+2*k2+2*k3+k4);
    %disp(k1)
    %disp(k2)
    %disp(k3)
    %disp(k4)
    %disp(y(n+1))
    %disp('------')
end
end