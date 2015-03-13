function Diff_Parameters_Diff_Results(ExpNumber)
% This file is to show effects of different parameters
% Diff_Parameters_Diff_Results(ExpNumber)
% Input: 
%   ExpNumber can be one single number or an array. It follows:
% ExpNumber:
%   1 -> Experiment 1 (1)
%   2 -> Experiment 1 (2)
%   3 -> Experiment 1 (3)
%   4 -> Experiment 1 (4)
%   5 -> Experiment 2 (1)
%   6 -> Experiment 2 (2)
%   7 -> Experiment 3 (1)
%   8 -> Experiment 3 (2)
%   9 -> Experiment 3 (3)
%   10 -> Experiment 3 (4)
%   11 -> Experiment 4
% 1. Experiment 1
% Different input gains (g0,g1) and output gain (h)
% Initial angle is 0.1 radians. Other initial values are 0. No extral force
% is inputted.
% (1) g0=1, g1=1, h=1: figure 1 and figure 2
% (2) g0=1, g1=0.1 h=1: figure 3 and figure 4
% (3) g0=2, g1=0.1 h=1: figure 5 and figure 6
% (4) g0=2, g1=0.1 h=5: figure 7 and figure 8
% 2. Experiment 2
% Changing membership functions instead of changing input gain (g0)
% and output gain (h)
% Initial angle is 0.1 radians. Other initial values are 0. No extral force
% is inputted.
% (1) g0=2, g1=1, h=1,
%     centerpoint=[-pi/2 -pi/4 0 pi/4 pi/2;-10*pi/4 -10*pi/8 0 10*pi/8 10*pi/4;-20 -10 0 10 20],
%     width=[pi/2 pi/2 pi/2 pi/2 pi/2;10*pi/4 10*pi/4 10*pi/4 10*pi/4 10*pi/4;20 20 20 20 20]
%     figure 9 and figure 10
% (2) g0=2, g1=0.1, h=1,
%     centerpoint=[-pi/2 -pi/4 0 pi/4 pi/2;-pi/4 -pi/8 0 pi/8 pi/4;-100 -50 0 50 100],
%     width=[pi/2 pi/2 pi/2 pi/2 pi/2;pi/4 pi/4 pi/4 pi/4 pi/4;100 100 100 100 100]
%     figure 11 and figure 12
% 3. Experiment 3
% Change the center points of output's membership functions to
% make them not uniform distribution.
% (1) g0=2, g1=0.1, h=10, uniform distribution, not extrnal force
%     centerpoint=[-pi/2 -pi/4 0 pi/4 pi/2;-pi/4 -pi/8 0 pi/8 pi/4;-10 -5 0 5 10]
%     width=[pi/2 pi/2 pi/2 pi/2 pi/2;pi/4 pi/4 pi/4 pi/4 pi/4;10 10 10 10 10]
%     figure 13 and figure 14
% (2) g0=2, g1=0.1, h=10, not uniform distribution, not extrnal force
%     centerpoint=[-pi/2 -pi/4 0 pi/4 pi/2;-pi/4 -pi/8 0 pi/8 pi/4;-20 -5 0 5 20]
%     width=[pi/2 pi/2 pi/2 pi/2 pi/2;pi/4 pi/4 pi/4 pi/4 pi/4;10 10 10 10 10]
%     figure 15 and figure 16
% (3) g0=2, g1=0.1, h=10, uniform distribution, Extrnal force 600N
% from 0.99s to 1.01s
%     centerpoint=[-pi/2 -pi/4 0 pi/4 pi/2;-pi/4 -pi/8 0 pi/8 pi/4;-10 -5 0 5 10]
%     width=[pi/2 pi/2 pi/2 pi/2 pi/2;pi/4 pi/4 pi/4 pi/4 pi/4;10 10 10 10 10]
%     figure 17 and figure 18
% (4) g0=2, g1=0.1, h=10, not uniform distribution, Extrnal force 600N
% from 0.99s to 1.01s
%     centerpoint=[-pi/2 -pi/4 0 pi/4 pi/2;-pi/4 -pi/8 0 pi/8 pi/4;-20 -5 0 5 20]
%     width=[pi/2 pi/2 pi/2 pi/2 pi/2;pi/4 pi/4 pi/4 pi/4 pi/4;10 10 10 10 10]
%     figure 19 and figure 20
% 4. Experiment 4: Plot control surface for g0=2, g1=0.1, h=10 with
% uniform distribution center points and not uniform distribution
% center points
% figure 21 and figure 22

for i=ExpNumber
    if i==1
        % 1. Experiment 1
        % Different input gains (g0,g1) and output gain (h)
        % Initial angle is 0.1 radians. Other initial values are 0. No extral force
        % is inputted.
        % (1) g0=1, g1=1, h=1: figure 1 and figure 2
        figure(1)
        set(1,'Position',[156   100   693   560],'name','g0-1_g1-1_h-1_ForceAndAcceleration')
        figure(2)
        set(2,'Position',[156   100   693   560],'name','g0-1_g1-1_h-1_AngleAndPosition')
        test_InvertedPendulum_with_fuzzy_controller('FigureNumber',[1,2]);
        figure(1)
        subplot(3,1,1)
        ylim([1 2.5])
        figure(2)
        subplot(3,1,1)
        ylim([0.07 0.11])
    elseif i==2
        % (2) g0=1, g1=0.1 h=1: figure 3 and figure 4
        figure(3)
        set(3,'Position',[156   100   693   560],'name','g0-1_g1-0dot1_h-1_ForceAndAcceleration')
        figure(4)
        set(4,'Position',[156   100   693   560],'name','g0-1_g1-0dot1_h-1_AngleAndPosition')
        test_InvertedPendulum_with_fuzzy_controller('g1',0.1,'FigureNumber',[3,4]);
        figure(3)
        subplot(3,1,1)
        ylim([-1 3])
        figure(4)
        subplot(3,1,1)
        ylim([-0.05 0.15])
    elseif i==3
        % (3) g0=2, g1=0.1 h=1: figure 5 and figure 6
        figure(5)
        set(5,'Position',[156   100   693   560],'name','g0-2_g1-0dot1_h-1_ForceAndAcceleration')
        figure(6)
        set(6,'Position',[156   100   693   560],'name','g0-2_g1-0dot1_h-1_AngleAndPosition')
        test_InvertedPendulum_with_fuzzy_controller('g0',2,'g1',0.1,'FigureNumber',[5,6]);
        figure(5)
        subplot(3,1,1)
        ylim([-2 4])
        figure(6)
        subplot(3,1,1)
        ylim([-0.05 0.15])
    elseif i==4
        % (4) g0=2, g1=0.1 h=5: figure 7 and figure 8
        figure(7)
        set(7,'Position',[156   100   693   560],'name','g0-2_g1-0dot1_h-5_ForceAndAcceleration')
        figure(8)
        set(8,'Position',[156   100   693   560],'name','g0-2_g1-0dot1_h-5_AngleAndPosition')
        test_InvertedPendulum_with_fuzzy_controller('g0',2,'g1',0.1,'h',5,'FigureNumber',[7,8]);
        figure(7)
        subplot(3,1,1)
        ylim([-10 20])
        figure(8)
        subplot(3,1,1)
        ylim([-0.05 0.15])
    elseif i==5
        % 2. Experiment 2
        % Changing membership functions instead of changing input gain (g0)
        % and output gain (h)
        % Initial angle is 0.1 radians. Other initial values are 0. No extral force
        % is inputted.
        % (1) g0=2, g1=1, h=1,
        %     centerpoint=[-pi/2 -pi/4 0 pi/4 pi/2;-10*pi/4 -10*pi/8 0 10*pi/8 10*pi/4;-20 -10 0 10 20],
        %     width=[pi/2 pi/2 pi/2 pi/2 pi/2;10*pi/4 10*pi/4 10*pi/4 10*pi/4 10*pi/4;20 20 20 20 20]
        %     figure 9 and figure 10
        figure(9)
        set(9,'Position',[156   100   693   560],'name','g0-2_g1-1_h-1_equal_g1-0dot1_ForceAndAcceleration')
        figure(10)
        set(10,'Position',[156   100   693   560],'name','g0-2_g1-1_h-1_equal_g1-0dot1_AngleAndPosition')
        test_InvertedPendulum_with_fuzzy_controller('g0',2,'g1',1,'h',1,'FigureNumber',[9,10],...
            'centerpoint',[-pi/2 -pi/4 0 pi/4 pi/2;-10*pi/4 -10*pi/8 0 10*pi/8 10*pi/4;-20 -10 0 10 20],...
            'width',[pi/2 pi/2 pi/2 pi/2 pi/2;10*pi/4 10*pi/4 10*pi/4 10*pi/4 10*pi/4;20 20 20 20 20]);
        figure(9)
        subplot(3,1,1)
        ylim([-2 4])
        figure(10)
        subplot(3,1,1)
        ylim([-0.05 0.15])
    elseif i==6
        % (2) g0=2, g1=0.1, h=1,
        %     centerpoint=[-pi/2 -pi/4 0 pi/4 pi/2;-pi/4 -pi/8 0 pi/8 pi/4;-100 -50 0 50 100],
        %     width=[pi/2 pi/2 pi/2 pi/2 pi/2;pi/4 pi/4 pi/4 pi/4 pi/4;100 100 100 100 100]
        %     figure 11 and figure 12
        figure(11)
        set(11,'Position',[156   100   693   560],'name','g0-2_g1-0dot1_h-1_equal_h-5_ForceAndAcceleration')
        figure(12)
        set(12,'Position',[156   100   693   560],'name','g0-2_g1-0dot1_h-1_equal_h-5_AngleAndPosition')
        test_InvertedPendulum_with_fuzzy_controller('g0',2,'g1',0.1,'h',1,'FigureNumber',[11,12],...
            'centerpoint',[-pi/2 -pi/4 0 pi/4 pi/2;-pi/4 -pi/8 0 pi/8 pi/4;-100 -50 0 50 100],...
            'width',[pi/2 pi/2 pi/2 pi/2 pi/2;pi/4 pi/4 pi/4 pi/4 pi/4;100 100 100 100 100]);
        figure(11)
        subplot(3,1,1)
        ylim([-10 20])
        figure(12)
        subplot(3,1,1)
        ylim([-0.05 0.15])
    elseif i==7
        % 3. Experiment 3
        % Change the center points of output's membership functions to
        % make them not uniform distribution.
        % (1) g0=2, g1=0.1, h=10, uniform distribution, not extrnal force
        %     centerpoint=[-pi/2 -pi/4 0 pi/4 pi/2;-pi/4 -pi/8 0 pi/8 pi/4;-10 -5 0 5 10]
        %     width=[pi/2 pi/2 pi/2 pi/2 pi/2;pi/4 pi/4 pi/4 pi/4 pi/4;10 10 10 10 10]
        %     figure 13 and figure 14
        figure(13)
        set(13,'Position',[156   100   693   560],'name','g0-2_g1-0dot1_h-10_Uniform_NoForce_ForceAndAcceleration')
        figure(14)
        set(14,'Position',[156   100   693   560],'name','g0-2_g1-0dot1_h-10_Uniform_NoForce_AngleAndPosition')
        test_InvertedPendulum_with_fuzzy_controller('g0',2,'g1',0.1,'h',10,'FigureNumber',[13,14],...
            'centerpoint',[-pi/2 -pi/4 0 pi/4 pi/2;-pi/4 -pi/8 0 pi/8 pi/4;-10 -5 0 5 10],...
            'width',[pi/2 pi/2 pi/2 pi/2 pi/2;pi/4 pi/4 pi/4 pi/4 pi/4;10 10 10 10 10]);
        figure(13)
        subplot(3,1,1)
        ylim([-10 20])
        figure(14)
        subplot(3,1,1)
        ylim([-0.05 0.15])
    elseif i==8
        % (2) g0=2, g1=0.1, h=10, not uniform distribution, not extrnal force
        %     centerpoint=[-pi/2 -pi/4 0 pi/4 pi/2;-pi/4 -pi/8 0 pi/8 pi/4;-20 -5 0 5 20]
        %     width=[pi/2 pi/2 pi/2 pi/2 pi/2;pi/4 pi/4 pi/4 pi/4 pi/4;10 10 10 10 10]
        %     figure 15 and figure 16
        figure(15)
        set(15,'Position',[156   100   693   560],'name','g0-2_g1-0dot1_h-10_NotUniform_NoForce_ForceAndAcceleration')
        figure(16)
        set(16,'Position',[156   100   693   560],'name','g0-2_g1-0dot1_h-10_NotUniform_NoForce_AngleAndPosition')
        test_InvertedPendulum_with_fuzzy_controller('g0',2,'g1',0.1,'h',10,'FigureNumber',[15,16],...
            'centerpoint',[-pi/2 -pi/4 0 pi/4 pi/2;-pi/4 -pi/8 0 pi/8 pi/4;-20 -5 0 5 20],...
            'width',[pi/2 pi/2 pi/2 pi/2 pi/2;pi/4 pi/4 pi/4 pi/4 pi/4;10 10 10 10 10]);
        figure(15)
        subplot(3,1,1)
        ylim([-10 20])
        figure(16)
        subplot(3,1,1)
        ylim([-0.05 0.15])
    elseif i==9
        % (3) g0=2, g1=0.1, h=10, uniform distribution, Extrnal force 600N
        % from 0.99s to 1.01s
        %     centerpoint=[-pi/2 -pi/4 0 pi/4 pi/2;-pi/4 -pi/8 0 pi/8 pi/4;-10 -5 0 5 10]
        %     width=[pi/2 pi/2 pi/2 pi/2 pi/2;pi/4 pi/4 pi/4 pi/4 pi/4;10 10 10 10 10]
        %     figure 17 and figure 18
        figure(17)
        set(17,'Position',[156   100   693   560],'name','g0-2_g1-0dot1_h-10_Uniform_Force_ForceAndAcceleration')
        figure(18)
        set(18,'Position',[156   100   693   560],'name','g0-2_g1-0dot1_h-10_Uniform_Force_AngleAndPosition')
        test_InvertedPendulum_with_fuzzy_controller('g0',2,'g1',0.1,'h',10,'FigureNumber',[17,18],...
            'centerpoint',[-pi/2 -pi/4 0 pi/4 pi/2;-pi/4 -pi/8 0 pi/8 pi/4;-10 -5 0 5 10],...
            'width',[pi/2 pi/2 pi/2 pi/2 pi/2;pi/4 pi/4 pi/4 pi/4 pi/4;10 10 10 10 10],...
            'ForceInput',600,'StartTime',0.99,'EndTime',1.01);
        figure(17)
        subplot(3,1,1)
        ylim([-100 50])
        figure(18)
        subplot(3,1,1)
        ylim([-30 10])
    elseif i==10
        % (4) g0=2, g1=0.1, h=10, not uniform distribution, Extrnal force 600N
        % from 0.99s to 1.01s
        %     centerpoint=[-pi/2 -pi/4 0 pi/4 pi/2;-pi/4 -pi/8 0 pi/8 pi/4;-20 -5 0 5 20]
        %     width=[pi/2 pi/2 pi/2 pi/2 pi/2;pi/4 pi/4 pi/4 pi/4 pi/4;10 10 10 10 10]
        %     figure 19 and figure 20
        figure(19)
        set(19,'Position',[156   100   693   560],'name','g0-2_g1-0dot1_h-10_NotUniform_Force_ForceAndAcceleration')
        figure(20)
        set(20,'Position',[156   100   693   560],'name','g0-2_g1-0dot1_h-10_NotUniform_Force_AngleAndPosition')
        test_InvertedPendulum_with_fuzzy_controller('g0',2,'g1',0.1,'h',10,'FigureNumber',[19,20],...
            'centerpoint',[-pi/2 -pi/4 0 pi/4 pi/2;-pi/4 -pi/8 0 pi/8 pi/4;-20 -5 0 5 20],...
            'width',[pi/2 pi/2 pi/2 pi/2 pi/2;pi/4 pi/4 pi/4 pi/4 pi/4;10 10 10 10 10],...
            'ForceInput',600,'StartTime',0.99,'EndTime',1.01);
        figure(19)
        subplot(3,1,1)
        ylim([-200 100])
        figure(20)
        subplot(3,1,1)
        ylim([-0.6 0.2])
    elseif i==11
        % 4. Experiment 4: Plot control surface for g0=2, g1=0.1, h=10 with
        % uniform distribution center points and not uniform distribution
        % center points
        % figure 21 and figure 22
        fontsize=20;
        e=linspace(-0.9,0.9,60);
        de=linspace(-9,9,60);
        g0=2;g1=0.1;h=10;
        rulebase=[5,5,5,4,3;
                  5,5,4,3,2;
                  5,4,3,2,1;
                  4,3,2,1,1;
                  3,2,1,1,1];
        functiontype='triangle';
        COGtype='min';
        [X_e,Y_de]=meshgrid(e,de);
        % figure 21: unform center points
        figure(21)
        centerpoint=[-pi/2 -pi/4 0 pi/4 pi/2;-pi/4 -pi/8 0 pi/8 pi/4;-10 -5 0 5 10];
        width=[pi/2 pi/2 pi/2 pi/2 pi/2;pi/4 pi/4 pi/4 pi/4 pi/4;10 10 10 10 10];
        F=zeros(size(X_e));
        for j=1:length(e)
            for k=1:length(de)
                F(k,j)=FuzzyController(e(j),de(k),g0,g1,h,rulebase,centerpoint,...
    width,functiontype,COGtype);
            end
        end
        set(21,'Position',[156   191   678   469],'name','Control_Surface_Uniform_Center')
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
        centerpoint=[-pi/2 -pi/4 0 pi/4 pi/2;-pi/4 -pi/8 0 pi/8 pi/4;-20 -5 0 5 20];
        width=[pi/2 pi/2 pi/2 pi/2 pi/2;pi/4 pi/4 pi/4 pi/4 pi/4;10 10 10 10 10];
        F=zeros(size(X_e));
        for j=1:length(e)
            for k=1:length(de)
                F(k,j)=FuzzyController(e(j),de(k),g0,g1,h,rulebase,centerpoint,...
    width,functiontype,COGtype);
            end
        end
        set(22,'Position',[156   191   678   469],'name','Control_Surface_NotUniform_Center')
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
    else
        error(['Unknow experiment number: ' num2str(i)])
    end
end
end