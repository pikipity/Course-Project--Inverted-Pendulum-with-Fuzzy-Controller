function test_membershipfunction(varargin)
% Plot membership functions of e, de and F
% test_membershipfunction(functiontype,e,de,F,centerpoint,width)
% Inputs:
%   functiontype: membership function type, default is 'triangle'
%   e: range of e, default is -pi:0.001:pi
%   de: range of de, default is -pi/2:0.001:pi/2
%   F: range of F, default is -40:0.1:40
%   centerpoint: center point of membership functions, default is [-pi/2 -pi/4 0 pi/4 pi/2;-pi/4 -pi/8 0 pi/8 pi/4;-20 -10 0 10 20]
%   width: bottom width of membership function, default is [pi/2 pi/2 pi/2 pi/2 pi/2;pi/4 pi/4 pi/4 pi/4 pi/4;20 20 20 20 20]
% Outputs:
%   figure 1: membership function of e
%   figure 2: membership function of de
%   figure 3 membership function of F

if mod(length(varargin),2)==1
    error('Error input. input should be (''t_0'',10)')
end
% Generate default values
functiontype='triangle';
e=-pi:0.001:pi;
de=-pi/2:0.001:pi/2;
F=-40:0.1:40;
centerpoint=[-pi/2 -pi/4 0 pi/4 pi/2;-pi/4 -pi/8 0 pi/8 pi/4;-20 -10 0 10 20];
width=[pi/2 pi/2 pi/2 pi/2 pi/2;pi/4 pi/4 pi/4 pi/4 pi/4;20 20 20 20 20];
% Get inputs
for i=1:2:length(varargin)
    if strcmpi(varargin{i},'centerpoint')
        centerpoint=varargin{i+1};
    elseif strcmpi(varargin{i},'width')
        width=varargin{i+1};
    elseif strcmpi(varargin{i},'functiontype')
        functiontype=varargin{i+1};
    elseif strcmpi(varargin{i},'e')
        e=varargin{i+1};
    elseif strcmpi(varargin{i},'de')
        de=varargin{i+1};
    elseif strcmpi(varargin{i},'F')
        F=varargin{i+1};
    end
end
% Begin to build membership functions
M=size(centerpoint,2);
N=M;
if strcmpi(functiontype,'triangle')
    function_1_define=@(e,c,w) 1.*(e<c)...
                                +(-2./w.*e+(1+2.*c./w)).*(e>=c & e<(c+w./2))...
                                +0.*(e>=(c+w./2));
    function_2_define=@(e,c,w) 0.*(e<(c-w./2))...
                                +(2./w.*e+(1-2.*c./w)).*(e>=(c-w./2)&e<c)...
                                +(-2./w.*e+(1+2.*c./w)).*(e>=c & e<(c+w./2))...
                                +0.*(e>=(c+w./2));
    function_3_define=@(e,c,w) 0.*(e<(c-w./2))...
                                +(2./w.*e+(1-2.*c./w)).*(e>=(c-w./2)&e<c)...
                                +1.*(e>c);
    % Create membership function for e
    function_e_store=cell(1,M);
    function_e_store{1}=@(e) function_1_define(e,centerpoint(1,1),width(1,1));
    for i=2:M-1
        center=centerpoint(1,i);
        widthvalue=width(1,i);
        function_e_store{i}=@(e) function_2_define(e,center,widthvalue);
    end
    function_e_store{M}=@(e) function_3_define(e,centerpoint(1,M),width(1,M));
    % Create membership function for de
    function_de_store=cell(1,M);
    function_de_store{1}=@(de) function_1_define(de,centerpoint(2,1),width(2,1));
    for i=2:M-1
        center=centerpoint(2,i);
        widthvalue=width(2,i);
        function_de_store{i}=@(de) function_2_define(de,center,widthvalue);
    end
    function_de_store{M}=@(de) function_3_define(de,centerpoint(2,M),width(2,M));
    % Create membership function for F
    function_F_store=cell(1,M);
    for i=1:M
        center=centerpoint(3,i);
        widthvalue=width(3,i);
        function_F_store{i}=@(F) function_2_define(F,center,widthvalue);
    end
elseif strcmpi(functiontype,'Gaussian')
    function_1_define=@(e,c,w) 1.*(e<c)...
                                +sqrt(2*pi).*(w./8).*normpdf(e,c,w./8).*(e>=c);
    function_2_define=@(e,c,w) sqrt(2*pi).*(w./8).*normpdf(e,c,w./8);
    function_3_define=@(e,c,w) sqrt(2*pi).*(w./8).*normpdf(e,c,w./8).*(e<c)...
                                +1.*(e>=c);
    % Create membership function for e
    function_e_store=cell(1,M);
    function_e_store{1}=@(e) function_1_define(e,centerpoint(1,1),width(1,1));
    for i=2:M-1
        center=centerpoint(1,i);
        widthvalue=width(1,i);
        function_e_store{i}=@(e) function_2_define(e,center,widthvalue);
    end
    function_e_store{M}=@(e) function_3_define(e,centerpoint(1,M),width(1,M));
    % Create membership function for de
    function_de_store=cell(1,M);
    function_de_store{1}=@(de) function_1_define(de,centerpoint(2,1),width(2,1));
    for i=2:M-1
        center=centerpoint(2,i);
        widthvalue=width(2,i);
        function_de_store{i}=@(de) function_2_define(de,center,widthvalue);
    end
    function_de_store{M}=@(de) function_3_define(de,centerpoint(2,M),width(2,M));
    % Create membership function for F
    function_F_store=cell(1,M);
    for i=1:M
        center=centerpoint(3,i);
        widthvalue=width(3,i);
        function_F_store{i}=@(F) function_2_define(F,center,widthvalue);
    end
else
    error('Membership function type is not supported')
end

% Plot result
fontsize=15;
linewidth=3;
marksize=10;
c=hsv(M);
figure;
hold on
for i=1:M
plot(e,function_e_store{i}(e),'LineWidth',linewidth,'MarkerSize',marksize,'Color',c(i,:))
end
grid on;
axis([min(e) max(e) -0.1 1.1])
xlabel('Angle Error','FontSize',fontsize)
set(gca,'FontSize',fontsize);

figure;
hold on
for i=1:M
plot(de,function_de_store{i}(de),'LineWidth',linewidth,'MarkerSize',marksize,'Color',c(i,:))
end
grid on;
axis([min(de) max(de) -0.1 1.1])
xlabel('Change of Error','FontSize',fontsize)
set(gca,'FontSize',fontsize);

figure;
hold on
for i=1:M
plot(F,function_F_store{i}(F),'LineWidth',linewidth,'MarkerSize',marksize,'Color',c(i,:))
end
grid on;
axis([min(F) max(F) -0.1 1.1])
xlabel('Force','FontSize',fontsize)
set(gca,'FontSize',fontsize);