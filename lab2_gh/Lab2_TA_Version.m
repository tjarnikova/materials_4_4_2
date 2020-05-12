% Lab 2 EOSC 442
% Johan Gilchrist, Jan 27 2018

clear
close all
clc

%% Part 1 - Import and Plot Data

% data = importdata('DailyAirTempUBC19592018.dat');
data = load('DailyAirTempUBC19592018.txt');

% date = data(:,1);
temp = data(:,3);
% make a date vector in day number format. note, you have to subtract the
% number of days it has been since you downloaded the data from "today" in
% the below line of code to create the correct number of days for your
% imported data. There are other ways to make your date vector.
start = datenum('January 26, 2018');
date = ((start - length(temp)):start-1)';
datevector = datevec(date);

figure; plot(date,temp); datetick
    xlabel('Date'); ylabel('Temperature (Celsius)')
    title('Daily Temperature at UBC from 1959-2017')
    set(gca, 'FontName', 'Arial'); set(gca, 'FontSize', 16)
    
%% Part 2 - Monthly Average, STD, Min, Max
mmean60yr = zeros(12,1);
mstd60yr = zeros(length(mmean60yr),1);
max60yr = zeros(length(mmean60yr),1);
min60yr = zeros(length(mmean60yr),1);
mmeandate60yr = zeros(length(mmean60yr),6);
for month = 1:12
        mmean60yr(month) = nanmean(temp(datevector(:,2)==month));
        mstd60yr(month) = nanstd(temp(datevector(:,2)==month));
        min60yr(month) = min(temp(datevector(:,2)==month));
        max60yr(month) = max(temp(datevector(:,2)==month));
        mmeandate60yr(month) = month;
end
mmeandate60yr = mmeandate60yr(:,1);
figure; plot(mmeandate60yr,mmean60yr,mmeandate60yr,min60yr,'bo',...
    mmeandate60yr,max60yr,'ro',mmeandate60yr,mmean60yr-mstd60yr,'k--',...
    mmeandate60yr,mmean60yr+mstd60yr,'k--'); 
    datetick
    legend('mean','min','max','mean ± \sigma')
    xlabel('Month'); ylabel('Temperature (Celsius)')
    title('1959-2017 Mean Temperature at UBC by Month')
    set(gca, 'FontName', 'Arial'); set(gca, 'FontSize', 16)

%% Part 3 - Monthly Time Series
mmean = zeros(12*(datevector(end,1)-datevector(1,1)),1);
mstd = zeros(length(mmean));
mmeandate = zeros(length(mmean),6);
row = 1;
for year = datevector(1,1):datevector(end,1)
    for month = 1:12
        mmean(row) = nanmean(temp(datevector(:,1)==year...
            & datevector(:,2)==month));
        mstd(row) = nanstd(temp(datevector(:,1)==year...
            & datevector(:,2)==month));
        mmeandate(row,:) = [year,month,1,0,0,0];
        row = row + 1;
    end
end
mmeandate = datenum(mmeandate);
figure; plot(mmeandate,mmean); 
    xlabel('Month'); ylabel('Temperature (Celsius)')
    title('Mean Monthly Temperature at UBC from 1959-2017')
    datetick
    set(gca, 'FontName', 'Arial'); set(gca, 'FontSize', 16)

%% Part 4 - Anomaly Time Series

ancycvec = repmat(mmean60yr,length(mmean)/12,1);
anom = mmean-ancycvec;

figure; plot(mmeandate,anom)
    xlabel('Date');ylabel('Temperature (Celsius)')
    title('Temperature Anomaly at UBC from 1959-2017')
    datetick
    set(gca, 'FontName', 'Arial'); set(gca, 'FontSize', 16)
    
%% Part 5 - Plot Daily Mean, Monthly Mean, Monthly Mean Anomaly on 1 Fig

figure;
subplot(311);
    plot(date,temp); 
    xlabel('Date'); ylabel('Temperature (Celsius)')
    title('Daily Temperature at UBC from 1959-2017')
    datetick
    set(gca, 'FontName', 'Arial'); set(gca, 'FontSize', 16)
subplot(312)
    plot(mmeandate,mmean,'k'); 
    xlabel('Month'); ylabel('Temperature (Celsius)')
    title('Mean Monthly Temperature at UBC from 1959-2017')
    datetick
    set(gca, 'FontName', 'Arial'); set(gca, 'FontSize', 16)
subplot(313)
    plot(mmeandate,anom,'r')
    xlabel('Date');ylabel('Temperature (Celsius)')
    title('Temperature Anomaly at UBC from 1959-2017')
    datetick
    set(gca, 'FontName', 'Arial'); set(gca, 'FontSize', 16)
    ylim([-5 5]);
