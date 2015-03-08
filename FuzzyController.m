function outputF=FuzzyController(e,de,g0,g1,h,rulebase,centerpoint,...
    width,functiontype,COGtype)
% Fuzzy Controller for the inverted pendulum
% outputF=FuzzyController(e,de,g0,g1,h,rulebase,centerpoint,...
%               width,functiontype,andtype)
% inputs:
%   e: angle error -> e=-theta
%   de: angle error change -> de=-dtheta
%   g0: input gain of e
%   g1: input gain of de
%   h: output gain
%   rulebase: rule base. The number is related to center point and width.
%             For example, for 5*5 rulebase, it can be
%               [5,5,5,4,3;
%                5,5,4,3,2;
%                5,4,3,2,1;
%                4,3,2,1,1;
%                3,2,1,1,1]
%             where 1 -> 5 => neglarge -> postlarge
%   centerpoint: center points of membership functions. Its column number 
%                should be equal to the row number or column number of 
%                rulebase. First column is for neglarge. Last column is for
%                postlarge. First row is for e. Second row is for de. Third
%                row is for F
%   width: width of membership functions. For example, it is the length of 
%          the bottom side for "triangle" type. Its column number should be 
%          equal to the row number or column number of rulebase. First
%          column is for neglarge. Last column is for postlarge. First row
%          is for e. Second row is for de. Last row is for F.
%   functiontype: membership function type. Support type: 'triangle',
%                 'Gaussian'
%   COGtype: COG implement type. Support type: 'min', 'product'
% outputs:
%   outputF: force

% Check inputs
[M,N]=size(rulebase);
if M~=N
    error('Please check rule base');
end
if M~=size(centerpoint,2)
    error('Please check center point');
end
if M~=size(width,2)
    error('Please check width');
end
% Create membership function
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
else
    error('Membership function type is not supported')
end
% Get input (after amplifier)
e=g0*e;
de=g1*de;
% Get center point for every rule
center=centerpoint(3,:);
center=center(rulebase);
% Get height (after fuzzy "and" operation) matrix for every rule
height_e=zeros(M,N);
for i=1:M
    height_e(:,i)=function_e_store{i}(e);
end
height_de=zeros(M,N);
for i=1:N
    height_de(i,:)=function_de_store{i}(de);
end
if strcmpi(COGtype,'min')
    height=min(height_e,height_de);
elseif strcmpi(COGtype,'product')
    height=height_e.*height_de;
else
    error('COG type is not supported')
end
% From height, get surface
if strcmpi(COGtype,'min')
    if strcmpi(functiontype,'triangle')
        % Create surface formula for F
        surface_F=cell(1,M);
        surface=@(h,w) w.*(h-(h.^2)./2);
        for i=1:M
            widthvalue=width(3,i);
            surface_F{i}=@(h) surface(h,widthvalue);
        end
        % Caulcuate surface
        surface=zeros(M,N);
        for i=1:M
            for j=1:N
                surface(i,j)=surface_F{rulebase(i,j)}(height(i,j));
            end
        end
    elseif strcmpi(functiontype,'Gaussian')
        surface_F=cell(1,M);
        surface=@(h,w) 2*normcdf(-sqrt(-2*(w/8)^2*log(h)),0,w/8)*w/8*sqrt(2*pi)+...
            h*2*(sqrt(-2*(w/8)^2*log(h)));
        for i=1:M
            widthvalue=width(3,i);
            surface_F{i}=@(h) surface(h,widthvalue);
        end
        % Caulcuate surface
        surface=zeros(M,N);
        for i=1:M
            for j=1:N
                surface(i,j)=surface_F{rulebase(i,j)}(height(i,j));
            end
        end
    else
        error('Membership function type is not supported')
    end
elseif strcmpi(COGtype,'product')
    if strcmpi(functiontype,'triangle')
        % Create surface formula for F
        surface_F=cell(1,M);
        surface=@(h,w) 0.5.*h.*w;
        for i=1:M
            widthvalue=width(3,i);
            surface_F{i}=@(h) surface(h,widthvalue);
        end
        % Caulcuate surface
        surface=zeros(M,N);
        for i=1:M
            for j=1:N
                surface(i,j)=surface_F{rulebase(i,j)}(height(i,j));
            end
        end
    elseif strcmpi(functiontype,'Gaussian')
        % Create surface formula for F
        surface_F=cell(1,M);
        surface=@(h,w) sqrt(2*pi).*(w./8).*h;
        for i=1:M
            widthvalue=width(3,i);
            surface_F{i}=@(h) surface(h,widthvalue);
        end
        % Caulcuate surface
        surface=zeros(M,N);
        for i=1:M
            for j=1:N
                surface(i,j)=surface_F{rulebase(i,j)}(height(i,j));
            end
        end
    else
        error('Membership function type is not supported')
    end
else
    error('COG type is not supported')
end
% Get output
outputF=(sum(sum(center.*surface)))./(sum(sum(surface)));
outputF=outputF.*h;
end