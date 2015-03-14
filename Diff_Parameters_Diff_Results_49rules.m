function Diff_Parameters_Diff_Results_49rules(ExpNumber,varargin)
% This file is to show effects of different parameters (triangular
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
% 1. Experiment 1
% Different input gains (g0,g1) and output gain (h)
% Initial angle is 0.1 radians. Other initial values are 0. No extral force
% is inputted.
% (1) g0=1, g1=1, h=1: figure 1 and figure 2
% (2) g0=1, g1=0.1 h=1: figure 3 and figure 4
% (3) g0=2, g1=0.1 h=1: figure 5 and figure 6
% (4) g0=2, g1=0.1 h=5: figure 7 and figure 8


if ~isempty(varargin)
    Save=varargin{1};
else
    Save=0;
end

FigHandle=[];
FigName={};
FigPath='Simulation_Results_triangle_min/';
if exist(FigPath,'dir')~=7
    mkdir(FigPath);
end

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
        test_InvertedPendulum_with_fuzzy_controller('FigureNumber',[1,2]);
        figure(1)
        subplot(3,1,1)
        ylim([1 2.5])
        figure(2)
        subplot(3,1,1)
        ylim([0.07 0.11])
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
        test_InvertedPendulum_with_fuzzy_controller('g1',0.1,'FigureNumber',[3,4]);
        figure(3)
        subplot(3,1,1)
        ylim([-1 3])
        figure(4)
        subplot(3,1,1)
        ylim([-0.05 0.15])
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
        test_InvertedPendulum_with_fuzzy_controller('g0',2,'g1',0.1,'FigureNumber',[5,6]);
        figure(5)
        subplot(3,1,1)
        ylim([-2 4])
        figure(6)
        subplot(3,1,1)
        ylim([-0.05 0.15])
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
        test_InvertedPendulum_with_fuzzy_controller('g0',2,'g1',0.1,'h',5,'FigureNumber',[7,8]);
        figure(7)
        subplot(3,1,1)
        ylim([-10 20])
        figure(8)
        subplot(3,1,1)
        ylim([-0.05 0.15])
        FigHandle(end+1)=7;
        FigHandle(end+1)=8;
        FigName{end+1}='g0-2_g1-0dot1_h-5_ForceAndAcceleration';
        FigName{end+1}='g0-2_g1-0dot1_h-5_AngleAndPosition';
    elseif i==5
        
    else
        error(['Unknow experiment number: ' num2str(i)])
    end
end
if Save==1
    for i=1:length(FigHandle)
        %saveas(FigHandle(i),[FigPath FigName{i}],'png');
        print(FigHandle(i),'-depsc2',[FigPath FigName{i} '.eps']);
    end
end
end