%% Lab 3 - TA Version, EOSC 442
% Johan Gilchrist, Feb 13, 2018

clear; close all

[data txt raw] = xlsread('lab3_data.xlsx');

date = data(:,1);
ubctanom = data(:,2); % Celsius, UBC temp anomaly
gtanom = data(:,3); % Celsiu, global temp anomaly
TSI = data(:,4); % W/m^2, solar irradiance at top of atmosphere
AOD = data(:,5); % Aerosol Optical Depth
CO2 = data(:,6); % ppm, atmospheric CO2 concentration
SO2 = data(:,7); % Tg/year, anthropogenic SO2 emissions
MEI = data(:,8); % Multivariate El Nino Index

%% Part 1: Plot each time series and linear regression of Temp Series
figure(1)
subplot(421)
    plot(date,ubctanom,'k'); hold on
    xlabel('Date'); ylabel('Temp Anomaly ({\circ}C)')
    title('UBC Temperature Anomaly from 1959-2016')
    mubc = ~isnan(ubctanom);
    [coef,bint,r,rint,stats] = ...
        regress(ubctanom,[ones(size(ubctanom)) date]);
    ubctanomlinfit = coef(1)+coef(2).*date;
    coef1 = -38.6026
    coef2 = 0.0196
    
    f2 = coef1 + coef2*date
    ubctanomlinfitbotlim = coef(1)+bint(2,1).*date;
    ubctanomlinfittoplim = coef(1)+bint(2,2).*date;
    plot(date(mubc),ubctanomlinfit(mubc),'r'); hold on
%     plot(date(mubc),ubctanomlinfitbotlim(mubc),'r--'); hold on
%     plot(date(mubc),ubctanomlinfittoplim(mubc),'r--'); hold on
    text(1951,5,['Slope = ',num2str(round(coef(2),3)),...
        ' {\circ}C/yr and R^2=',num2str(round(stats(1),3))...
        '; 95% conf = [' num2str(round(bint(2,1),3)) ','...
            num2str(round(bint(2,2),3)) ']']) 
subplot(422)
    plot(date,gtanom,'k'); hold on
    xlabel('Date'); ylabel('Temp Anomaly (C^{\circ})')
    title('Global Temperature Anomaly from 1950-2016')
      mgt = ~isnan(gtanom);
      clear bint
    [coef,bint,r,rint,stats] = ...
        regress(gtanom,[ones(size(gtanom)),date]);
    gtanomlinfit = coef(1)+coef(2).*date;
    gtanomlinfitbotlim = coef(1)+bint(2,1).*date;
    gtanomlinfittoplim = coef(1)+bint(2,2).*date;
    plot(date,gtanomlinfit,'r--'); hold on
%     plot(date,gtanomlinfitbotlim,'r--'); hold on
%     plot(date,gtanomlinfittoplim,'r--'); hold on
    text(1951,1.2,['Slope = ',num2str(round(coef(2),3)),...
        ' {\circ}C/yr and R^2=',num2str(round(stats(1),3))...
        '; 95% conf = [' num2str(round(bint(2,1),3)) ','...
            num2str(round(bint(2,2),3)) ']']) 
subplot(423)
    plot(date,TSI,'r'); xlabel('Date');
    ylabel('Total Solar Irradiance (W/m^2)')
    title('Total Solar Irradiance from 1950-2016')
subplot(424)
    plot(date,AOD,'b'); xlabel('Date');
    ylabel('Aerosol Optical Depth')
    title('Aerosol Optical Depth from 1950-2016')
subplot(425)
    plot(date,CO2,'r'); xlabel('Date');
    ylabel('CO_2 (ppm)')
    title('Atmospheric CO2 from 1950-2016')
subplot(426)
    plot(date,SO2,'b'); xlabel('Date');
    ylabel('SO_2 (Tg/year)')
    title('Anthropogenic Atmospheric SO_2 from 1950-2016')
subplot(427)
    plot(date,MEI,'g'); xlabel('Date');
    ylabel('MEI')
    title('Multivariate El Niño Index from 1950-2016')
    
    
% Histogram Plots

m1 = date <= 1985;
m2 = date > 1985;
numbins = 40;
figure(2)
subplot(211)
histogram(ubctanom(m1),linspace(min(ubctanom),max(ubctanom),numbins),...
    'normalization','probability'); hold on
    xlabel('Temp Anomaly ({\circ}C)'); ylabel('Count per bin')
    title(['Histogram of UBC Temperature Anomalies, binsize = ',...
        num2str(numbins)])
histogram(ubctanom(m2),linspace(min(ubctanom),max(ubctanom),numbins),...
    'normalization','probability');
legend('<1985','>1985')
subplot(212)
histogram(gtanom(m1),linspace(min(gtanom),max(gtanom),numbins),...
    'normalization','probability'); hold on
    xlabel('Temp Anomaly ({\circ}C)'); ylabel('Count per bin')
    title(['Histogram of Global Temperature Anomalies, binsize = ',...
        num2str(numbins)])
histogram(gtanom(m2),linspace(min(gtanom),max(gtanom),numbins),...
    'normalization','probability');
legend('<=1985','>1985')

%% Part 2: Decadal Timescale Trends
figure(3)
    n = 1;
for i = 1960:10:2020
    subplot(4,2,n)
    m = date>=i-10 & date<i;
    [coef,bint,r,rint,stats] = ...
            regress(gtanom(m),[ones(size(gtanom(m))),date(m)]);
        gtanomlinfit = coef(1)+coef(2).*date(m);
        plot(date(m),gtanom(m),'k-'); hold on
        plot(date(m),gtanomlinfit,'r-'); hold on
        text(i-10,max(gtanom(m)),['Slope = ',num2str(round(coef(2),3)),...
            ' {\circ}C/yr; R^2=',num2str(round(stats(1),3))...
            '; 95% conf = [' num2str(round(bint(2,1),3)) ','...
            num2str(round(bint(2,2),3)) ']']) 
        xlabel('Date'); ylabel('Temp Anomaly ({\circ}C)')
        title(['Global Temp Anomaly for ' num2str(i-10) '-' num2str(i)])
        n = n+1;
end

figure(4)
    n = 1;
for i = 1960:10:2020
    subplot(4,2,n)
    m = date>=i-10 & date<i;
    [coef,bint,r,rint,stats] = ...
            regress(ubctanom(m),[ones(size(ubctanom(m))),date(m)]);
        ubctanomlinfit = coef(1)+coef(2).*date(m);
        plot(date(m),ubctanom(m),'k-'); hold on
        plot(date(m),ubctanomlinfit,'r-'); hold on
        text(i-10,max(ubctanom(m)),['Slope = ',num2str(round(coef(2),3)),...
            ' {\circ}C/yr; R^2=',num2str(round(stats(1),3))...
            '; 95% conf = [' num2str(round(bint(2,1),3)) ','...
            num2str(round(bint(2,2),3)) ']']) 
        xlabel('Date'); ylabel('Temp Anomaly ({\circ}C)')
        title(['UBC Temp Anomaly for ' num2str(i-10) '-' num2str(i)])
        n = n+1;
end


%% Part 3: Local vs. Global Temp

figure(5)
plot(gtanom,ubctanom,'k.'); hold on
xlabel('UBC Temp ({\circ}C)'); ylabel('Global Temp ({\circ}C)')
m = isnan(ubctanom) | isnan(gtanom);
[R,p] = corrcoef(ubctanom(~m),gtanom(~m));
[coef,bint,r,rint,stats] = regress(ubctanom(~m),[ones(size(gtanom(~m))) gtanom(~m)]);
R1 = stats(1)^2; p1 = stats(3);
text(-0.4,-5,['Correlation = ' num2str(R(2,1)) ' and p-value = ' num2str(p(2,1))]);

%% Part 4: Regression of each forcing
figure
subplot(321)
    plot(TSI,gtanom,'.'); hold on
    xlabel('Total Solar Irradiance');
    ylabel('Global Temp Anomaly (C^{\circ})')
    title('Global Temperature Anomaly vs. TSI from 1950-2016')
      mgt = ~isnan(gtanom);
      clear bint coef gtanomlinfit gtanomlinfitbotlim gtanomlinfittoplim
    [coef,bint,r,rint,stats] = ...
        regress(gtanom,[ones(size(gtanom)),TSI]);
    gtanomlinfit = coef(1)+coef(2).*TSI;
    plot(TSI,gtanomlinfit,'r--'); hold on
    text(1366,1.4,['Slope = ',num2str(round(coef(2),3)),...
        ' {\circ}C/(W/m^2)) and R^2=',num2str(round(stats(1),3))...
        '; 95% conf = [' num2str(round(bint(2,1),3)) ','...
            num2str(round(bint(2,2),3)) ']']) 
subplot(322)
    plot(AOD,gtanom,'.'); hold on
    xlabel('Aerosol Optical Depth');
    ylabel('Global Temp Anomaly (C^{\circ})')
    title('Global Temperature Anomaly vs. AOD from 1950-2016')
      mgt = ~isnan(gtanom);
      clear bint coef gtanomlinfit gtanomlinfitbotlim gtanomlinfittoplim
    [coef,bint,r,rint,stats] = ...
        regress(gtanom,[ones(size(gtanom)),AOD]);
    gtanomlinfit = coef(1)+coef(2).*AOD;
    plot(AOD,gtanomlinfit,'r--'); hold on
    text(0.01,1.4,['Slope = ',num2str(round(coef(2),3)),...
        ' {\circ}C and R^2=',num2str(round(stats(1),3))...
        '; 95% conf = [' num2str(round(bint(2,1),3)) ','...
            num2str(round(bint(2,2),3)) ']']) 
subplot(323)
    plot(CO2,gtanom,'.'); hold on
    xlabel('Carbon Dioxide Concentration (ppm)');
    ylabel('Global Temp Anomaly (C^{\circ})')
    title('Global Temperature Anomaly vs. CO2 from 1950-2016')
      mgt = ~isnan(gtanom);
      clear bint coef gtanomlinfit gtanomlinfitbotlim gtanomlinfittoplim
    [coef,bint,r,rint,stats] = ...
        regress(gtanom,[ones(size(gtanom)),CO2]);
    gtanomlinfit = coef(1)+coef(2).*CO2;
    plot(CO2,gtanomlinfit,'r--'); hold on
    text(315,1,['Slope = ',num2str(round(coef(2),3)),...
        ' {\circ}C/ppm and R^2=',num2str(round(stats(1),3))...
        '; 95% conf = [' num2str(round(bint(2,1),3)) ','...
            num2str(round(bint(2,2),3)) ']']) 
      
        t_co2_400 = coef(1)+coef(2).*400
        t_co2_500 = coef(1)+coef(2).*500
        t_co2_950 = coef(1)+coef(2).*950


        subplot(324)
    plot(SO2,gtanom,'.'); hold on
    xlabel('Sulfate Concentration (Tg/yr)');
    ylabel('Global Temp Anomaly (C^{\circ})')
    title('Global Temperature Anomaly vs. SO2 from 1950-2016')
      mgt = ~isnan(gtanom);
      clear bint coef gtanomlinfit gtanomlinfitbotlim gtanomlinfittoplim
    [coef,bint,r,rint,stats] = ...
        regress(gtanom,[ones(size(gtanom)),SO2]);
    gtanomlinfit = coef(1)+coef(2).*SO2;
    plot(SO2,gtanomlinfit,'r--'); hold on
    text(31,1,['Slope = ',num2str(round(coef(2),3)),...
        ' {\circ}C/Tg/yr and R^2=',num2str(round(stats(1),3))...
        '; 95% conf = [' num2str(round(bint(2,1),3)) ','...
            num2str(round(bint(2,2),3)) ']']) 
subplot(325)
    plot(MEI,gtanom,'.'); hold on
    xlabel('Multivariate ENSO Index');
    ylabel('Global Temp Anomaly (C^{\circ})')
    title('Global Temperature Anomaly vs. MEI from 1950-2016')
    mgt = ~isnan(gtanom);
    clear bint coef gtanomlinfit gtanomlinfitbotlim gtanomlinfittoplim
    [coef,bint,r,rint,stats] = ...
        regress(gtanom,[ones(size(gtanom)),MEI]);
    gtanomlinfit = coef(1)+coef(2).*MEI;
    plot(MEI,gtanomlinfit,'r--'); hold on
    text(-2.5,1.4,['Slope = ',num2str(round(coef(2),3)),...
        ' {\circ}C and R^2=',num2str(round(stats(1),3))...
        '; 95% conf = [' num2str(round(bint(2,1),3)) ','...
            num2str(round(bint(2,2),3)) ']']) 
        
figure
subplot(211)
    plot(MEI,gtanom,'.'); hold on
    xlabel('Multivariate ENSO Index');
    ylabel('Global Temp Anomaly (C^{\circ})')
    title('Global Temperature Anomaly vs. MEI from 1950-2016')
    plot(MEI,gtanomlinfit,'r--'); hold on
    text(-2.5,1,['Slope = ',num2str(round(coef(2),3))]) 
subplot(212)
    plot(MEI,ubctanom,'.'); hold on
    xlabel('Multivariate ENSO Index');
    ylabel('UBC Temp Anomaly (C^{\circ})')
    title('UBC Temperature Anomaly vs. MEI from 1950-2016')
    clear bint coef gtanomlinfit gtanomlinfitbotlim gtanomlinfittoplim
    [coef,bint,r,rint,stats] = ...
        regress(ubctanom,[ones(size(ubctanom)),MEI]);
    ubctanomlinfit = coef(1)+coef(2).*MEI;
    plot(MEI,ubctanomlinfit,'r--'); hold on
    text(-2.5,5,['Slope = ',num2str(round(coef(2),3))]) 

%% Part 5: Multilinear Regression of all Forcings
figure
%     plot(date,gtanom,'.'); hold on
%     xlabel('Date');
%     ylabel('Global Temp Anomaly (C^{\circ})')
%     title('Global Temperature Anomaly vs. all forcings (with date) from 1950-2016')
%       mgt = ~isnan(gtanom);
      clear bint coef gtanomlinfit gtanomlinfitbotlim gtanomlinfittoplim
    [coefml,bintml,r,rint,stats] = ...
        regress(gtanom,[ones(size(gtanom)),date,TSI,AOD,CO2,SO2,MEI]);
    gtanomlinfit = coefml(1) + coefml(2).*date+coefml(3).*TSI + ...
        coefml(4).*AOD + coefml(5).*CO2 + coefml(6).*SO2 + coefml(7).*MEI;
    plot(gtanomlinfit,gtanom,'.'); hold on
    xlabel('ML Fitted Global Temperature Anomaly Data (C^{\circ})');
    ylabel('Raw Global Temperature Anomaly Data (C^{\circ})');
    x = linspace(min(gtanom),max(gtanom),100);
    y=x; plot(x,y,'r-')
    legend('Fit vs. Raw','y=x'); hold on
    CO2coefml = coefml(5);
    ConfIntCO2ml = bintml(5,:);
    text(-0.4,1,['Coef. Det. = ' num2str(stats(1))])
    
figure
plot(date,gtanom,'.'); hold on
    xlabel('Date');
    ylabel('Global Temp Anomaly (C^{\circ})')
    title('Global Temperature Anomaly vs. all forcings from 1950-2016')
      mgt = ~isnan(gtanom);
      clear bint coef gtanomlinfit gtanomlinfitbotlim gtanomlinfittoplim
    [coef,bint,r,rint,stats] = ...
        regress(gtanom,[ones(size(gtanom)),TSI,AOD,CO2,SO2,MEI]);
    gtanomlinfit = coef(1) + coef(2).*TSI + ...
        coef(3).*AOD + coef(4).*CO2 + coef(5).*SO2 + coef(6).*MEI;
    plot(date,gtanomlinfit,'r-'); hold on
    text(1956,1,['Slope = ',num2str(round(coef(2),3)),...
        ' {\circ}C/(W/m^2)) and R^2=',num2str(round(stats(1),3))...
        '; 95% conf = [' num2str(round(bint(2,1),3)) ','...
            num2str(round(bint(2,2),3)) ']'])
    legend('Raw Temp','ML Fit')
    coef
    bint
    stats(1)
 CO2coefml = coef(4)

%% Part 6: Regress with Random Variables Test

[dummydat text1 all] = xlsread('dummyvariables_lab3.xlsx');
trump = dummydat(:,1);
gtanomi = dummydat(:,2);
figure
    plot(trump,gtanom,'.'); hold on
    xlabel('Trump Age');
    ylabel('Global Temp Anomaly (C^{\circ})')
    title('Global Temperature Anomaly vs. Trump Age from 1950-2016')
      mgt = ~isnan(gtanom);
      clear bint coef gtanomlinfit gtanomlinfitbotlim gtanomlinfittoplim
    [coef,bint,r,rint,stats] = ...
        regress(gtanom,[ones(size(gtanom)),trump]);
    [R, p] = corrcoef(trump,gtanom);
    gtanomlinfit = coef(1)+coef(2).*trump;
    plot(trump,gtanomlinfit,'r-'); hold on
    text(25,1,['Corr. Coef. = ' num2str(R(1,2)) ', p-value = ' ...
        num2str(stats(3))]) 
