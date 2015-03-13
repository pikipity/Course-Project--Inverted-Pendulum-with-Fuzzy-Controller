% This file is to show effects of different parameters
% 1. Experiment 1
% Different input gains (g0,g1) and output gain (h)
% Initial angle is 0.1 radians. Other initial values are 0. No extral force
% is inputted.
% (1) g0=1, g1=1, h=1: figure 1 and figure 2
test_InvertedPendulum_with_fuzzy_controller('FigureNumber',[1,2]);
figure(1)
subplot(3,1,1)
yaxis([1 2.5])
figure(2)
subplot(2,1,1)
yaxis([0.07 0.11])