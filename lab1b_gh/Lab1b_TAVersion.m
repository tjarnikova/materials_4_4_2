%% Lab 1 Part 2, EOSC 442


clc
clear
close all

%% Part 1: Loading Mauna Loa Data
% File identifier
fid = fopen('monthly_maunaloa_co2.csv');
% Format of data in each column: %f=float, %d=integer, %s=string
format = '%f %f %f %f %f %f %f %f %f %f';
% textscan function using previous two variables and 'Headerlines' option 
% (number of header lines) and 'Delimiter' separating columns option (e.g.
% comma, space, tab)
mauna_loa_data = textscan(fid, format, 'HeaderLines', 57,...
    'Delimiter', ',');

% Pulling out cell arrays (vectors stored in a cell) from our loaded data
% and saving them as an individual vectors of data
co2_date = mauna_loa_data{4};
co2 = mauna_loa_data{5};
co2sa = mauna_loa_data{6};
co2fit = mauna_loa_data{7};
co2safit = mauna_loa_data{8};

% Plotting raw CO2 data against date acquired
figure; plot(co2_date,co2); xlabel('Date'); ylabel('CO2 (ppm)')
    title('Raw CO2 vs. Time with missing data')
        set(gca, 'FontName', 'Arial'); set(gca, 'FontSize', 12)

% Changing empty data entries (indicated by -99.99 value for this dataset)
% to NaN's
co2(co2==-99.99)=NaN;
co2sa(co2sa==-99.99)=NaN;
co2fit(co2fit==-99.99)=NaN;
co2safit(co2safit==-99.99)=NaN;

% Plotting all raw CO2 data with fitted curve overplotted
figure; plot(co2_date,co2,'r-','linewidth',4);
        xlabel('Date'); ylabel('CO2 (ppm)'); hold on
        plot(co2_date,co2fit,'k-','linewidth',2); xlabel('Date');
        ylabel('CO2 Fit (ppm)'); hold on
        title('Raw CO2 Data vs. Time')
        legend('CO2 Raw','CO2 Fit','location','northwest')
        set(gca, 'FontName', 'Arial'); set(gca, 'FontSize', 14)
% Plotting seasonally adjusted CO2 data with fitted curve overplotted
figure; plot(co2_date,co2sa,'g-','linewidth',4);
        xlabel('Date'); ylabel('CO2 Seasonally Adjusted (ppm)'); hold on
        plot(co2_date,co2safit,'k-','linewidth',2); xlabel('Date');
        ylabel('CO2 SA Fit (ppm)'); hold on
        title('Seasonally Adjusted CO2 Data vs. Time')
        legend('CO2 SA','CO2 SA Fit','location','northwest')
        set(gca, 'FontName', 'Arial'); set(gca, 'FontSize', 14)
        
        
%% Part 2: Loading MEI Data

% Download MEI.html file from connect and open it in a text editor that
% will allow you to save it as a .txt file. I used Microsoft Word for this.
% Textedit app on Mac did not let me save it as a .txt file, only as a .rtf
% file that did not work.
% Follow instructions in lab manual to prepare data file for loading into
% Matlab. Read all metadata and descriptions of dataset before deleting
% text in the data file!!!

% Loading MEI data
M = load('MEI_data_only.txt');

% Take data (without date/year column) and make into its own matrix
N = M(:,2:end);
% Find total number of elements in N matrix
len = length(N(:,1)).*length(N(1,:));
% Reshape N into one long vector
mei = reshape(N',[len 1]);

meidatevec = zeros(12*length(M(:,1)),6);
row =  1;

for i = M(1,1):M(end,1)
    for j = 1:12
        meidatevec(row,:) = [i,j,1,0,0,0];
        row = row + 1;
    end
end
meidatevec = datenum(meidatevec);
figure; plot(meidatevec,mei)
    datetick; xlabel('Date'); ylabel('MEI Index')
    title('Monthly MEI Index from 1950-2012')
    


%% Understanding how Matlab stores date information
% Today's date
date
% Today's date in vector format
datevec(date)
% Today's date in day since year zero format- this is used for plotting!
datenum(date)

% Example of how to make plot with datenum command
today = datenum(date);
exm_dates = today : 0.5 : (today+10);	% increments of 1/2 day
exm_data = sin(0:20);
figure; plot(exm_dates, exm_data); xlabel('Date (MM/DD)')
    ylabel('Some dumb sinusoidal function')
    title('Example of Making Plot with datenum command')
        set(gca, 'FontName', 'Arial'); set(gca, 'FontSize', 14)

% Change date numbers into MM/DD format on plot
datetick

% Use nested for loop to create date vector with data reported every 3
% months
my_datevectors = []; row = 0;
    for year=2011:2012
        for month=1:3:12
            row = row + 1;
            my_datevectors(row, :)=[year month 1 0 0 0];
        end
    end

% Transform date vectors into date numbers
my_datenumbers = datenum(my_datevectors);

%% Part 3 - Import Your Own Data

MSL_dat = load('MSL_Global_1993_2016.txt');

date = datenum(MSL_dat(:,1));
MSL = MSL_dat(:,2); % MSL data in mm

figure; plot(date,MSL)
xlabel('Year');ylabel('Mean Sea Level (mm)')
title('Mean Sea Level (MSL) from 1993-2016')

% Done. YAY!
