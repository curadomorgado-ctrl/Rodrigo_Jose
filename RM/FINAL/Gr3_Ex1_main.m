
clear all, clc, close all

out = sim('untitled.slx', 'StopTime', '2');
PlotPoses3(out, [1 1 0.3], 15);