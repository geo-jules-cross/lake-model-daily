clear;

%% Load Lake Data

load('lake.mat')

% 1995 start
years2run = (1995:2012);
ndays= datenum([years2run(end)+1 1 31]) - datenum([1995 6 30]);
startday = 728840;

% % 1996 start
% years2run = (1996:2012);
% ndays= datenum([years2run(end)+1 1 31]) - datenum([1996 6 30]);
% startday = 729206;

%% Accumulate obs and mod arrays for days with obs
fprintf('Comparing observed and modeled for each lakes across all years...\n');

obs=NaN(ndays,3); mod=NaN(ndays,3); % initialize containers

% dh or dV flag
flag = 0;
% flag = 1;

if flag == 0 % Compare dh
    for day=1:ndays
        
        % Lake Bonney
        if (~isnan(lake.measured.LB.date(lake.measured.LB.date==(startday+day))==1))
            obs(day,1)=lake.measured.LB.dh(lake.measured.LB.date==(startday+day));
            mod(day,1)=lake.modeled.LB.dh(day);
        end
        
        % Lake Hoare
        if (~isnan(lake.measured.LH.date(lake.measured.LH.date==(startday+day))==1))
            obs(day,2)=lake.measured.LH.dh(lake.measured.LH.date==(startday+day));
            mod(day,2)=lake.modeled.LH.dh(day);
        end
        
        % Lake Fryxell
        if (~isnan(lake.measured.LF.date(lake.measured.LF.date==(startday+day))==1))
            obs(day,3)=lake.measured.LF.dh(lake.measured.LF.date==(startday+day));
            mod(day,3)=lake.modeled.LF.dh(day);
        end
    end
elseif flag == 1 % Compare dV
        for day=1:ndays
        
        % Lake Bonney
        obs(day,1)=lake.measured.LB.dV(day);
        mod(day,1)=lake.dV(1,day);
        
        % Lake Hoare
        obs(day,2)=lake.measured.LH.dV(day);
        mod(day,2)=lake.dV(2,day);
        
        % Lake Fryxell
        obs(day,3)=lake.measured.LF.dV(day);
        mod(day,3)=lake.dV(3,day);
    end
end

%% Calculate model skill metrics for all streams all years

fprintf('Calculating model efficiency for each lake across all years...\n');

% initialize table
skill = [];

for l=1:3

    % Calculate correlation coefficient
    ccoef = corrcoef(mod(:,l), obs(:,l), 'rows', 'complete');
    skill(l).r  = [1.0 ccoef(1,2)];
    skill(l).rsquared  = ccoef(1,2)^2;

    % Calculate standard deviation of predicted field w.r.t N (sigma_p)
    sdevp = nanstd(mod(:,l),1);
    % Calculate standard deviation of reference field w.r.t N (sigma_r)
    sdevr = nanstd(obs(:,l),1);
    % Store standard deviations
    skill(l).sdev = [sdevr sdevp];

    % Calculate root-mean-squared (RMS) error manually
    skill(l).err = (obs(:,l) - mod(:,l));
    SE = skill(l).err.^2;
    MSE = nansum(SE)/length(~isnan(SE));
    skill(l).rmse = sqrt(MSE);

    % Calculate normalized RMS error manually (to std of obs)
    skill(l).nrmse = skill(l).rmse/sdevr;

    % Calculate Nash-Sutcliffe Effciency E
    skill(l).nse = nash_sutcliffe_efficiency(mod(:,l), obs(:,l));

end

%% Model vs. measured lake level - 1:1 SCATTERPLOT by lake by year

fig = figure (4); clf; clear ha;  ha = tight_subplot(1,3, [.04 .04], [.1 .04], [.05 .15]);
set(gcf,'units','normalized','outerposition',[0.05 0.25 0.9 0.6]);

colormap(winter)

i = 1;

% Loop
for l=1:3

    axes(ha(i)); hold all;
    
    % Plot 1:1 Scatter Plot
    x = obs(:,l);
    y = mod(:,l);
    sz = 25;
    c = lake.t_vec+startday;
%     c = 'k';
    
    scatter(x,y,sz,c,'filled'); hold on;
    line([0 5], [0 5],'Color','red','LineStyle','--','LineWidth', 1.5)
    
    
    set(gca,'XColor','k', 'YColor', 'k','LineWidth', 1.5, 'FontWeight', 'bold', 'GridColor', 'k', 'box', 'on')
    if l == 1
        set(gca,'XLim',[0 4])
        set(gca,'YLim',[0 4])
    else
        set(gca,'XLim',[0 1])
        set(gca,'YLim',[0 1])
    end
    set(gca,'xticklabelmode','auto')
    set(gca,'yticklabelmode','auto')
    
    i = i + 1;
    
end

axes(ha(1))
ylabel('Sim. lake-level change (1995 datum) [m]', 'FontSize', 18)

axes(ha(2))
xlabel('Obs. lake-level change (1995 datum) [m]', 'FontSize', 18)

axes(ha(3))
hp = get(gca,'Position');
colorbar('Position', [hp(1)+hp(3)+0.02  hp(2)  0.05  hp(2)+hp(3)*3], 'FontSize', 14)
cbdate('mmm. yyyy')