function Diff_Parameters_Diff_Results_Gaussian_product(ExpNumber,varargin)
% This file is to show effects of different parameters (Gaussian
% membership functions and minimum premise)
% Diff_Parameters_Diff_Results_triangle_min(ExpNumber,Save)
% Input: 
%   "ExpNumber" can be one single number or an array.
%   "Save" can be ignored. If it is 1, save all display figures. Otherwise,
%   figures will not be saved. default is 0.
% ExpNumber:
%   1 -> Experiment 1 (1)
%   2 -> Experiment 1 (2)
%   3 -> Experiment 1 (3)
%   4 -> Experiment 1 (4)
%   5 -> Experiment 1 (5)
%   6 -> Experiment 2 (1)
%   7 -> Experiment 2 (2)
%   8 -> Experiment 3
% 1. Experiment 1
% Different input gains (g0,g1) and output gain (h)
% Initial angle is 0.1 radians. Other initial values are 0. No extral force
% is inputted.
% (1) g0=1, g1=1, h=1: figure 1 and figure 2
% (2) g0=1, g1=0.1 h=1: figure 3 and figure 4
% (3) g0=2, g1=0.1 h=1: figure 5 and figure 6
% (4) g0=2, g1=0.1 h=5: figure 7 and figure 8
% (5) Turning input and output gains to make it stable
%     Make it not oscillation
%     figure 9~16
% 2. Experiment 2
% (1) Insert a 600N force from 0.99s to 1.01s (Uniform distribution)
%     figure 17 and figure 18
% (2) Not stable. So change to Not Uniform distribution
%     figure 19 and figure 20
% 3. Experiment 3
% Plot control surface of uniform and not uniform distribution
% figure 21 and figure 22


if ~isempty(varargin)
    Save=varargin{1};
else
    Save=0;
end

FigHandle=[];
FigName={};
FigPath='Simulation_Results_Gaussian_product/';

for i=ExpNumber
    if i==1
        % 1. Experiment 1
        % Different input gains (g0,g1) and output gain (h)
        % Initial angle is 0.1 radians. Other initial values are 0. No extral force
        % is inputted.
        % (1) g0=1, g1=1, h=1: figure 1 and figure 2
        figure(1)
        set(1,'Position',[156   100   693   560],...
            'name','g0-1_g1-1_h-1_ForceAndAcceleration',...
            'PaperPosition',[156   100   693   560],...
            'PaperUnits','points',...
            'PaperPositionMode','auto')
        figure(2)
        set(2,'Position',[156   100   693   560],...
            'name','g0-1_g1-1_h-1_AngleAndPosition',...
            'PaperPosition',[156   100   693   560],...
            'PaperUnits','points',...
            'PaperPositionMode','auto')
        test_InvertedPendulum_with_fuzzy_controller('FigureNumber',[1,2],...
            'functiontype','Gaussian','COGtype','product');
        FigHandle(end+1)=1;
        FigHandle(end+1)=2;
        FigName{end+1}='g0-1_g1-1_h-1_ForceAndAcceleration';
        FigName{end+1}='g0-1_g1-1_h-1_AngleAndPosition';
    elseif i==2
        % (2) g0=1, g1=0.1 h=1: figure 3 and figure 4
        figure(3)
        set(3,'Position',[156   100   693   560],...
            'name','g0-1_g1-0dot1_h-1_ForceAndAcceleration',...
            'PaperPosition',[156   100   693   560],...
            'PaperUnits','points',...
            'PaperPositionMode','auto')
        figure(4)
        set(4,'Position',[156   100   693   560],...
            'name','g0-1_g1-0dot1_h-1_AngleAndPosition',...
            'PaperPosition',[156   100   693   560],...
            'PaperUnits','points',...
            'PaperPositionMode','auto')
        test_InvertedPendulum_with_fuzzy_controller('g1',0.1,...
            'FigureNumber',[3,4],...
            'functiontype','Gaussian','COGtype','product');
        FigHandle(end+1)=3;
        FigHandle(end+1)=4;
        FigName{end+1}='g0-1_g1-0dot1_h-1_ForceAndAcceleration';
        FigName{end+1}='g0-1_g1-0dot1_h-1_AngleAndPosition';
    elseif i==3
        % (3) g0=2, g1=0.1 h=1: figure 5 and figure 6
        figure(5)
        set(5,'Position',[156   100   693   560],...
            'name','g0-2_g1-0dot1_h-1_ForceAndAcceleration',...
            'PaperPosition',[156   100   693   560],...
            'PaperUnits','points',...
            'PaperPositionMode','auto')
        figure(6)
        set(6,'Position',[156   100   693   560],...
            'name','g0-2_g1-0dot1_h-1_AngleAndPosition',...
            'PaperPosition',[156   100   693   560],...
            'PaperUnits','points',...
            'PaperPositionMode','auto')
        test_InvertedPendulum_with_fuzzy_controller('g0',2,'g1',0.1,...
            'FigureNumber',[5,6],...
            'functiontype','Gaussian','COGtype','product');
        FigHandle(end+1)=5;
        FigHandle(end+1)=6;
        FigName{end+1}='g0-2_g1-0dot1_h-1_ForceAndAcceleration';
        FigName{end+1}='g0-2_g1-0dot1_h-1_AngleAndPosition';
    elseif i==4
        % (4) g0=2, g1=0.1 h=5: figure 7 and figure 8
        figure(7)
        set(7,'Position',[156   100   693   560],...
            'name','g0-2_g1-0dot1_h-5_ForceAndAcceleration',...
            'PaperPosition',[156   100   693   560],...
            'PaperUnits','points',...
            'PaperPositionMode','auto')
        figure(8)
        set(8,'Position',[156   100   693   560],...
            'name','g0-2_g1-0dot1_h-5_AngleAndPosition',...
            'PaperPosition',[156   100   693   560],...
            'PaperUnits','points',...
            'PaperPositionMode','auto')
        test_InvertedPendulum_with_fuzzy_controller('g0',2,'g1',0.1,'h',5,...
            'FigureNumber',[7,8],...
            'functiontype','Gaussian','COGtype','product');
        FigHandle(end+1)=7;
        FigHandle(end+1)=8;
        FigName{end+1}='g0-2_g1-0dot1_h-5_ForceAndAcceleration';
        FigName{end+1}='g0-2_g1-0dot1_h-5_AngleAndPosition';
    elseif i==5
        % (5) Turning input and output gains to make it stable
        % Make it not oscillation (increase g1): g0=2, g1=1, h=5
        figure(9)
        set(9,'Position',[156   100   693   560],...
            'name','g0-2_g1-1_h-5_ForceAndAcceleration',...
            'PaperPosition',[156   100   693   560],...
            'PaperUnits','points',...
            'PaperPositionMode','auto')
        figure(10)
        set(10,'Position',[156   100   693   560],...
            'name','g0-2_g1-1_h-5_AngleAndPosition',...
            'PaperPosition',[156   100   693   560],...
            'PaperUnits','points',...
            'PaperPositionMode','auto')
        test_InvertedPendulum_with_fuzzy_controller('g0',2,'g1',1,'h',5,...
            'FigureNumber',[9,10],...
            'functiontype','Gaussian','COGtype','product');
        FigHandle(end+1)=9;
        FigHandle(end+1)=10;
        FigName{end+1}='g0-2_g1-1_h-5_ForceAndAcceleration';
        FigName{end+1}='g0-2_g1-1_h-5_AngleAndPosition';
        % Still oscillation. Increase g1.
        % g0=2, g1=2, h=5
        figure(11)
        set(11,'Position',[156   100   693   560],...
            'name','g0-2_g1-2_h-5_ForceAndAcceleration',...
            'PaperPosition',[156   100   693   560],...
            'PaperUnits','points',...
            'PaperPositionMode','auto')
        figure(12)
        set(12,'Position',[156   100   693   560],...
            'name','g0-2_g1-2_h-5_AngleAndPosition',...
            'PaperPosition',[156   100   693   560],...
            'PaperUnits','points',...
            'PaperPositionMode','auto')
        test_InvertedPendulum_with_fuzzy_controller('g0',2,'g1',2,'h',5,...
            'FigureNumber',[11,12],...
            'functiontype','Gaussian','COGtype','product');
        FigHandle(end+1)=11;
        FigHandle(end+1)=12;
        FigName{end+1}='g0-2_g1-2_h-5_ForceAndAcceleration';
        FigName{end+1}='g0-2_g1-2_h-5_AngleAndPosition';
        % Now, not oscillation. but not decrease. Increase g0
        % g0=10, g1=2, h=5
        figure(13)
        set(13,'Position',[156   100   693   560],...
            'name','g0-10_g1-2_h-5_ForceAndAcceleration',...
            'PaperPosition',[156   100   693   560],...
            'PaperUnits','points',...
            'PaperPositionMode','auto')
        figure(14)
        set(14,'Position',[156   100   693   560],...
            'name','g0-10_g1-2_h-5_AngleAndPosition',...
            'PaperPosition',[156   100   693   560],...
            'PaperUnits','points',...
            'PaperPositionMode','auto')
        test_InvertedPendulum_with_fuzzy_controller('g0',10,'g1',2,'h',5,...
            'FigureNumber',[13,14],...
            'functiontype','Gaussian','COGtype','product');
        FigHandle(end+1)=13;
        FigHandle(end+1)=14;
        FigName{end+1}='g0-10_g1-2_h-5_ForceAndAcceleration';
        FigName{end+1}='g0-10_g1-2_h-5_AngleAndPosition';
        % Decrease but not go to 0. Increase g0
        % g0=20, g1=2, h=5
        figure(15)
        set(15,'Position',[156   100   693   560],...
            'name','g0-20_g1-2_h-5_ForceAndAcceleration',...
            'PaperPosition',[156   100   693   560],...
            'PaperUnits','points',...
            'PaperPositionMode','auto')
        figure(16)
        set(16,'Position',[156   100   693   560],...
            'name','g0-20_g1-2_h-5_AngleAndPosition',...
            'PaperPosition',[156   100   693   560],...
            'PaperUnits','points',...
            'PaperPositionMode','auto')
        test_InvertedPendulum_with_fuzzy_controller('g0',20,'g1',2,'h',5,...
            'FigureNumber',[15,16],...
            'functiontype','Gaussian','COGtype','product');
        FigHandle(end+1)=15;
        FigHandle(end+1)=16;
        FigName{end+1}='g0-20_g1-2_h-5_ForceAndAcceleration';
        FigName{end+1}='g0-20_g1-2_h-5_AngleAndPosition';
    elseif i==6
        % 2. Experiment 2
        % (1) Insert a 600N force from 0.99s to 1.01s (Uniform distribution)
        figure(17)
        set(17,'Position',[156   100   693   560],...
            'name','g0-20_g1-2_h-5_Force_Uniform_ForceAndAcceleration',...
            'PaperPosition',[156   100   693   560],...
            'PaperUnits','points',...
            'PaperPositionMode','auto')
        figure(18)
        set(18,'Position',[156   100   693   560],...
            'name','g0-20_g1-2_h-5_Force_Uniform_AngleAndPosition',...
            'PaperPosition',[156   100   693   560],...
            'PaperUnits','points',...
            'PaperPositionMode','auto')
        test_InvertedPendulum_with_fuzzy_controller('g0',20,'g1',2,'h',5,...
            'FigureNumber',[17,18],...
            'functiontype','Gaussian','COGtype','product',...
            'ForceInput',600,'StartTime',0.99,'EndTime',1.01);
        FigHandle(end+1)=17;
        FigHandle(end+1)=18;
        FigName{end+1}='g0-20_g1-2_h-5_Force_Uniform_ForceAndAcceleration';
        FigName{end+1}='g0-20_g1-2_h-5_Force_Uniform_AngleAndPosition';
    elseif i==7
        % (2) Not stable. So change to Not Uniform distribution
        figure(19)
        set(19,'Position',[156   100   693   560],...
            'name','g0-20_g1-2_h-5_Force_NotUniform_ForceAndAcceleration',...
            'PaperPosition',[156   100   693   560],...
            'PaperUnits','points',...
            'PaperPositionMode','auto')
        figure(20)
        set(20,'Position',[156   100   693   560],...
            'name','g0-20_g1-2_h-5_Force_NotUniform_AngleAndPosition',...
            'PaperPosition',[156   100   693   560],...
            'PaperUnits','points',...
            'PaperPositionMode','auto')
        test_InvertedPendulum_with_fuzzy_controller('g0',20,'g1',2,'h',5,...
            'FigureNumber',[19,20],...
            'functiontype','Gaussian','COGtype','product',...
            'centerpoint',[-pi/2 -pi/4 0 pi/4 pi/2;...
            -pi/4 -pi/8 0 pi/8 pi/4;-40 -10 0 10 40],...
            'width',[pi/2 pi/2 pi/2 pi/2 pi/2;...
            pi/4 pi/4 pi/4 pi/4 pi/4;20 20 20 20 20],...
            'ForceInput',600,'StartTime',0.99,'EndTime',1.01);
        FigHandle(end+1)=19;
        FigHandle(end+1)=20;
        FigName{end+1}='g0-20_g1-2_h-5_Force_NotUniform_ForceAndAcceleration';
        FigName{end+1}='g0-20_g1-2_h-5_Force_NotUniform_AngleAndPosition';
    elseif i==8
        % 3. Experiment 3
        % Plot control surface of uniform and not uniform distribution
        fontsize=20;
        e=linspace(-0.9,0.9,100);
        de=linspace(-9,9,100);
        g0=20;g1=2;h=5;
        rulebase=[5,5,5,4,3;
                  5,5,4,3,2;
                  5,4,3,2,1;
                  4,3,2,1,1;
                  3,2,1,1,1];
        functiontype='Gaussian';
        COGtype='product';
        [X_e,Y_de]=meshgrid(e,de);
        % figure 21: unform center points
        figure(21)
        centerpoint=[-pi/2 -pi/4 0 pi/4 pi/2;...
            -pi/4 -pi/8 0 pi/8 pi/4;-20 -10 0 10 20];
        width=[pi/2 pi/2 pi/2 pi/2 pi/2;...
            pi/4 pi/4 pi/4 pi/4 pi/4;20 20 20 20 20];
        F=zeros(size(X_e));
        for j=1:length(e)
            for k=1:length(de)
                F(k,j)=FuzzyController(e(j),de(k),...
                    g0,g1,h,rulebase,centerpoint,...
                    width,functiontype,COGtype);
            end
        end
        set(21,'Position',[156   191   678   469],...
            'name','Control_Surface_Uniform_Center',...
            'PaperPosition',[156   191   678   469],...
            'PaperUnits','points',...
            'PaperPositionMode','auto')
        meshplot1=meshz(X_e,Y_de,F);
        set(meshplot1,'LineWidth',1,...
            'EdgeAlpha',1,...
            'Edgecolor','k',...
            'EdgeLighting','none');
        axis([-1 1 -10 10 -100 100])
        xlabel('e (rad)','FontSize',fontsize)
        ylabel('de/dt (rad/s)','FontSize',fontsize)
        zlabel('F (N)','FontSize',fontsize)
        grid on
        set(gca,'FontSize',fontsize);
        view(162,22);
        % figure 22: not uniform center points
        figure(22)
        centerpoint=[-pi/2 -pi/4 0 pi/4 pi/2;...
            -pi/4 -pi/8 0 pi/8 pi/4;-40 -10 0 10 40];
        width=[pi/2 pi/2 pi/2 pi/2 pi/2;...
            pi/4 pi/4 pi/4 pi/4 pi/4;20 20 20 20 20];
        F=zeros(size(X_e));
        for j=1:length(e)
            for k=1:length(de)
                F(k,j)=FuzzyController(e(j),de(k),...
                    g0,g1,h,rulebase,centerpoint,...
                    width,functiontype,COGtype);
            end
        end
        set(22,'Position',[156   191   678   469],...
            'name','Control_Surface_NotUniform_Center',...
            'PaperPosition',[156   191   678   469],...
            'PaperUnits','points',...
            'PaperPositionMode','auto')
        meshplot2=meshz(X_e,Y_de,F);
        set(meshplot2,'LineWidth',1,...
            'EdgeAlpha',1,...
            'Edgecolor','k',...
            'EdgeLighting','none');
        axis([-1 1 -10 10 -200 200])
        xlabel('e (rad)','FontSize',fontsize)
        ylabel('de/dt (rad/s)','FontSize',fontsize)
        zlabel('F (N)','FontSize',fontsize)
        grid on
        set(gca,'FontSize',fontsize);
        view(162,22);
        FigHandle(end+1)=21;
        FigHandle(end+1)=22;
        FigName{end+1}='Control_Surface_Uniform_Center';
        FigName{end+1}='Control_Surface_NotUniform_Center';
    else
        error(['Unknow experiment number: ' num2str(i)])
    end
end
if Save==1
    if length(unique(FigHandle))~=length(FigHandle)
        error('There are repeat elements in ''FigHandle''. Please check program.')
    end
    if length(unique(FigName))~=length(FigName)
        error('There are repeat elements in ''FigName''. Please check program.')
    end
    if exist(FigPath,'dir')~=7
        mkdir(FigPath);
    end
    for i=1:length(FigHandle)
        %saveas(FigHandle(i),[FigPath FigName{i}],'png');
        print(FigHandle(i),'-depsc2',[FigPath FigName{i} '.eps']);
    end
end
end