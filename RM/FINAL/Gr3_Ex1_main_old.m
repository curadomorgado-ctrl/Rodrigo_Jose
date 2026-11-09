
clear all, clc, close all

out = sim('Gr_3_Ex1_3linkedRobot.slx', 'StopTime', '2');
PlotPoses3(out, [1 1 0.3], 15);