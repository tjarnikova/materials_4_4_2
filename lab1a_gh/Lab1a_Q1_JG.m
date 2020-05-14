% Lab 1 EOSC 442
% TA Version - Johanand Gilchrist, Jan 8, 2018

% This script is the answer key to the Lab 1 worksheet for EOSC 442

clear % clear all variables in workspace
close all % close all figure windows
clc % clear command window history

%% Q1 %%

% i. %
A=3.*rand(100,5)-1;
%use this command to check size of A
% size(A);
%use these commands to check max min vsals
% max(A)
% min(A)

% ii. %
B=A.^3;
%use this command to check first value of B = A(1)^3. Should output 1 if true
% B(1) == A(1)^3;

% iii. %
x=A(:,2);
% check that this works by double clicking both variables in the workspace
% window

% iv. %
y=B(:,end-1);
% check that this works by double clicking both variables in the workspace
% window

% v. %
mask=y<0;
% check that this works by outputting first values of y and mask vectors.
% masking a number in a vector/matrix means setting it's index value to 0
% in the corresponding mask vector/matrix e.g. if first value of y is
% positive, first value of mask should be 0, thus masking the positive
% value. E.g. these commands:
% y(1)
% mask(1)

% vi. %
y(mask)=2*rand(1);
% check that this works by scrolling up in the command window and comparing
% the first negative value of y with the value in the same index of your
% new y vector. the value should have changed from a random negative number
% between -1 and 0 to a positive random number between 0 and 2.

% vii. %
figure; plot(x,y,'ro');title('Q1, Part vii')
% This plot should look like a bunch of red circles scattered randomaly
% across the domain and range of the data (e.g. x,y values).
% Use "help plot" to see instructions on how to use the plot command and
% for a table of symbols and colors that can be defined within the plot
% command.

% viii. %
figure; plot(x(x<1),y(x<1),'b+');title('Q1, Part viii')
% check that this is correct by looking at figure 1 from 1<x<2. You can do
% this by zooming in manually with the magnificaiton glass tool or by going
% to the drop down "Edit" menu and selecting "Axes Properties" and then
% setting the axes limits to be between 1 and 2 and pressing return.

% ix. %
C=sum(B);
% Use the "help sum" command in the command window for the answer. Do not
% try to check this by manually summing up each column in B!!!

% x. %
C = sort(C);
% Use "help sort" command in the command window for documentation on how to
% use the "sort" function.

% xi. %
figure; plot(C,exp(C),'k--');title('Q1, Part x')
% Use "help exp" in the command window to see how to calculate the
% exponential of a vector/matrix. Note that you can do algebra on
% vectors/matrices within the plot command instead of creating a new
% variable first.


%% Q2 %%

%Modify the following script until it produces the same figure as the one
%I made. I wrote comments in the script to clarify the purpose of each 
%line.You can modify, add, or delete lines. Each time you do something,
%add a comment to explain it starting with your initial, e.g. if your name
%is John Smith:
%"JS: I deleted this useless command and replaced it by...because..."
%
%Don't forget to answer the question at the very end of the script. Good
%luck! :)



%clear the workspace to avoid conflicts with existing variables and the
%ones used in the script
clear % JG: Don't need "all" here
%close all figures to avoid conflict with previous figures when plotting
% close all

%==========================================================================
%create a column vector with 150 rows filled with random number between -5
%and 5
x=10*rand(150,1)-5;
%create a column vector y equal to x, squared, plus some noise
y=x.^2+0.5*rand(150,1); % JG: should be "x.^2..."
%introduce 10 random NaN in y, like real measurements
y(randi(150,10,1))=NaN;


%==========================================================================
%create a mask where y has NaN
masknan=~isnan(y);

%mask y
ynew=y(masknan);
% JG: need to get rid of x entries corrpsonding to NaN's in y
xnew=x(masknan); 
%open a new figure 1
figure(1)
%divide it into 2 vertical subplots and open the first one
% JG: 1st entry should be "2" and third "1" to make on plot on top of other
% Also don't need commas
subplot(211) 
%plot ynew vs x using red crosses symbols, i.e., y vs x without datapoints
% for which y is a NaN
plot(xnew,ynew,'rx') %JG: change x to match xnew variable name and use 'r+'
%label the x and y axis
xlabel('some stupid variable')
ylabel('some idiot variable')


%==========================================================================
%create a new vector z that is a function of x and some noise
% JG: should be rand(150,1) instead of rand(150)
z=3*x.^3+7 + rand(150,1)*10-5; 

%==========================================================================
%create a mask where z is below -200 AND above 200
maskz=z>-200 & z<200; % JG: change '|' to '&'
%fit x and z where z is between -200 and 200, using a 4th degree polynomial
%fit
% JG: x(maskz) instead of just x. Also include G in output to see
% goodness-of-fit measures 
[myfit,G]=fit(x(maskz),z(maskz),'poly4'); 
%==========================================================================
%open figure 1
figure(1)
%open the second subplot
subplot(212) % JG: change from subplot(1,2,2) to subplot(212)
%plot z as a function of x with black circles
plot(x,z,'ko') % JG: change from 'go' to 'ko'
%create a vector of 1000 equally spaced datapoints spanning the range of
%values in x
xgrid=linspace(min(x),max(x),1000); % JG: need "...,1000)" in linspace
%hold previous plot to avoid overwritting
hold all % JG: "on" instead of "off"
%on top of the previous plot, plot the best fit function (for z vs x) taken
%in the x-value stored in xgrid; use a thick red line to plot
% JG: xgrid instead of x and 'r-' instead of 'r:'
plot(xgrid,myfit(xgrid),'r-','LineWidth',2) 
%label the x and y axis
xlabel('some stupid variable')
xlabel('some dummy variable')
%add a legend
lg=legend('stupid data','amazing fit of stupid data');
%change the position of the legend to the top left of the graph so that it
%does not overlap the plot
set(lg,'Location','northwest') % JG: 'northwest' instead of 'TopLeft'

%==========================================================================
%save the current figure as a jpg
saveas(gcf,'figure_part2_lab1a_JohanGilchrist.jpg')
%display myfit on the command window; are you satisfied with the
%coefficient found? Why?
myfit
% JG: output R squared value to determine satisfaction with fit. Use
% "fprintf" function to print a variable name and it's value to the command
% window 
fprintf('R^2=%5.3f\n',G.rsquare) 


%% Q3 %%
%clear
% close all

load Lab1_data.mat

% Make mask that satisfies two conditions- 1) only want data from depths
% below 250 m and 2) ignore -9999 temp entries due to corrupted/missing
% data.
maskd = D > 250 & T ~= -9999;
% figure; plot(D(maskd),T(maskd),'ko')
% Using scatter plot function to plot cold temp data points as "cool" blue
% colors with a color gradient towards "warm" red colors for higher temp
% data points. Can also just use the line of code before this comment for a
% simple line plot
figure; scatter(T(maskd),-D(maskd),20,T(maskd),'filled')
% Using char(176) for degree symbol in the xlabel for temperature. Not
% extremely important, but makes for better looking plot and also
% demonstrates how to add automated labels, which can combine strings and
% numbers all in a label command. More advanced technique for later in the
% course. Label for y-axis used in same line here
xlabel(['Temperature (C',char(176),')']);ylabel('Depth (m)')
title('Depth vs. Temperature below 250 m Depth') % make title for plot
set(gca,'FontSize',20) %set the font size of everything


