%% Q3 %%
% By Johan Gilchrist, Jan 8, 2018 for EOSC 442 at UBC

clear
close all

load Lab1_data.mat

% Make mask that satisfies two conditions- 1) only want data from depths
% below 250 m and 2) ignore -9999 temp entries due to corrupted/missing
% data.
maskd = D > 250 & T ~= -9999;
% Plot masked data
figure; plot(T(maskd),-D(maskd),'ko')
% Using char(176) for degree symbol in the xlabel for temperature. Not
% extremely important, but makes for better looking plot and also
% demonstrates how to add automated labels, which can combine strings and
% numbers all in a label command. More advanced technique for later in the
% course. Label for y-axis used in same line here
xlabel(['Temperature (C',char(176),')']);ylabel('Depth (m)')
title('Depth vs. Temperature below 250 m Depth') % make title for plot
set(gca,'FontSize',20) %set the font size of everything

% Can also use scatter plot function to plot cold temp data points as "cool" blue
% colors with a color gradient towards "warm" red colors for higher temp
% data points. Can also just use the line of code before this comment for a
% simple line plot
figure; scatter(T(maskd),-D(maskd),20,T(maskd),'filled')
xlabel(['Temperature (C',char(176),')']);ylabel('Depth (m)')
title('Depth vs. Temperature below 250 m Depth') % make title for plot
set(gca,'FontSize',20) %set the font size of everything


