%Modify the following script until it produces the same figure as the one
%I made. I wrote comments in the script to clarify the purpose of each 
%line.You can modify, add, or delete lines. Each time you do something,
%add a comment to explain it starting with your initial, e.g. if your name
%is John Smith:
%"JS: I deleted this useless command and replaced it by...because..."
%
%Don't forget to answer the question at the very end of the script. Good
% luck! :



%clear the workspace to avoid conflicts with existing variables and the
%ones used in the script
clear % JG: Don't need "all" here
%close all figures to avoid conflict with previous figures when plotting
close all

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
plot(xnew,ynew,'r+') %JG: change x to match xnew variable name and use 'r+'
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
hold on % JG: "on" instead of "off"
%on top of the previous plot, plot the best fit function (for z vs x) taken
%in the x-value stored in xgrid; use a thick red line to plot
% JG: xgrid instead of x and 'r-' instead of 'r:'
plot(xgrid,myfit(xgrid),'r-','LineWidth',2) 
%label the x and y axis
xlabel('some stupid variable')
xlabel('some dummy variable')
%add a legend
lg=legend('stupid data','amazing fit of stupid data')
%change the position of the legend to the top left of the graph so that it
%does not overlap the plot
set(lg,'Location','northwest') % JG: 'northwest' instead of 'TopLeft'

%==========================================================================
%save the current figure as a jpg
% saveas(gcf,'figure_part2_lab1a_JohanGilchrist.jpg')
%display myfit on the command window; are you satisfied with the
%coefficient found? Why?
myfit
G.rsquare % JG: output R squared value to determine satisfaction with fit


