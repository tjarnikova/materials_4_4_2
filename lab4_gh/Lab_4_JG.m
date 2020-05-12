%% Lab 4 TA Version
% Johan Gilchrist March 20, 2018

clear
close all

%% Part 0
A = [3 5 NaN 7];	
B = [2.1 9.4 NaN 7.5 NaN 5.2];
meanA = mymean(A)
meanA1 = nanmean(A)
meanB = mymean(B)
meanB1 = nanmean(B)
%% Part 1 - Load Stratogem Data
data = importdata('STRATOGEM_plankton.csv');
date = datetime(data.textdata(2:end,1));
pdata = data.data;
pdata(isnan(pdata)) = 0;
%% Part 2 - Plot Stratogem Data
ptotal = sum(pdata,2);
figure; subplot(211); plot(date,ptotal)
title('Total Phytoplankton Count Linear Scale'); set(gca,'fontsize',20)
xlabel('Date'); ylabel('Phytoplankton Count')
subplot(212); plot(date,ptotal)
title('Total Phytoplankton Count Log Scale')
xlabel('Date'); ylabel('Phytoplankton Count')
set(gca, 'yscale', 'log')
set(gca,'fontsize',20)
%% Part 3 - Shannon Wiener Diversity Index
pcounts = [1 1 1];
H111 = shannonWiener(pcounts)
pcounts = [1 2 3];
H123 = shannonWiener(pcounts)
pcounts = [0 0 0];
H000 = shannonWiener(pcounts)
pcounts = [1 NaN 1];
H1NaN1 = shannonWiener(pcounts)

%% Part 4 - SWDI for All Dates
Halldates = zeros(1,length(date));
for i = 1:length(date)
    pcounts = pdata(i,:);
    H = shannonWiener(pcounts);
    Halldates(i) = H;
end
figure; plot(date,Halldates);
title('Shannon Wiener Diversity Index from Apr, 2002 to June 2005')
xlabel('Date'); ylabel('SWDI')

%% Part 5 - SWDI for each year
datev = datevec(date);
row = 1;
n = datev(1,end)-datev(1,1)+1;
pyear = zeros(1,n);
Hyear = zeros(1,n);
Tyear = zeros(1,n);
for year = datev(1,1):datev(end,1)
    pyear = ptotal(datev(:,1)==year);
    Hyear = Halldates(datev(:,1)==year);
    Tyear = date(datev(:,1)==year);
    figure; subplot(211); plot(Tyear,pyear); xlabel('Date')
    ylabel('Phytoplankton Count')
    set(gca, 'yscale', 'log')
    title(['Phytoplankton Count for ' num2str(year)])
%     set(gca, 'yscale', 'log')
    subplot(212); plot(Tyear,Hyear); xlabel('Date')
    ylabel('Phytoplankton Count')
    title(['Shannon Wiener Diversity Index for ' num2str(year)])
end
    
    