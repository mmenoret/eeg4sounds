

function [dataclean, cfgrej] = plot_components(comp,data,cfgtopoICA,cfgbrowsICA)

% plot the components for visual inspection
close all

cfgerp = [];
cfgerp.vartrllength = 2;
%%% Do an average of the components and plot the result
avg_comp = ft_timelockanalysis(cfgerp,comp);
ntrials = length(comp.trial);
%%% create random partitions of the trials to have partial averages

cfgerp.trials = randi(ntrials,[1 floor(0.25*ntrials)]);
avg_comp2 = ft_timelockanalysis(cfgerp,comp);

cfgerp.trials = randi(ntrials,[1 floor(0.50*ntrials)]);
avg_comp3 = ft_timelockanalysis(cfgerp,comp);

cfgerp.trials = randi(ntrials,[1 floor(0.75*ntrials)]);
avg_comp4 = ft_timelockanalysis(cfgerp,comp);



cfgTF = []; 
cfgTF.method = 'mtmfft'; 
cfgTF.output = 'pow'; 
cfgTF.tapsmofrq = 1;
cfgTF.foi = 0.5:0.2:50;
cfgTF.pad = 2.5;
%freqcomp = ft_freqanalysis(cfgTF,avg_comp);
freqcomp = ft_freqanalysis(cfgTF,comp);

cfgitc = [];
cfgitc.method = 'wavelet';
cfgitc.foi = 1:1:45;
cfgitc.toi    = (cfgtopoICA.segm(1)):0.01:cfgtopoICA.segm(2);
cfgitc.pad = 'maxperlen';
cfgitc.output = 'fourier';
freqitc = ft_freqanalysis(cfgitc, comp);

itc = [];
itc.label     = freqitc.label;
itc.freq      = freqitc.freq;
itc.time      = freqitc.time;
itc.dimord    = 'chan_freq_time';

F = freqitc.fourierspctrm;   % copy the Fourier spectrum
N = size(F,1);           % number of trials
% compute inter-trial linear coherence (itlc)
itc.itlc      = sum(F) ./ (sqrt(N*sum(abs(F).^2)));
itc.itlc      = abs(itc.itlc);     % take the absolute value, i.e. ignore phase
itc.itlc      = squeeze(itc.itlc); % remove the first singleton dimension




ft_databrowser(cfgbrowsICA, comp);

if length(comp.label) >36 
    cfgtopoICA.component = 1:36;
figure
ft_topoplotIC(cfgtopoICA, comp);

    if length(comp.label)>73
    cfgtopoICA.component = 37:72;
    figure
    ft_topoplotIC(cfgtopoICA, comp);
        if length(comp.label)>108
        cfgtopoICA.component = 73:108;
        figure
        ft_topoplotIC(cfgtopoICA, comp);
            if length(comp.label)>144
            cfgtopoICA.component = 109:144;
            figure
            ft_topoplotIC(cfgtopoICA, comp); 
                if length(comp.label)>180
                cfgtopoICA.component = 145:180;
                figure
                ft_topoplotIC(cfgtopoICA, comp);
                    if length(comp.label)>216
                    cfgtopoICA.component = 181:216;
                    figure
                    ft_topoplotIC(cfgtopoICA, comp);
                        if length(comp.label)>252
                        cfgtopoICA.component = 217:length(comp.label);
                        figure
                        ft_topoplotIC(cfgtopoICA, comp);
                        end
                    else
                    cfgtopoICA.component = 181:length(comp.label);
                    figure
                    ft_topoplotIC(cfgtopoICA, comp);
                    end
                else
                cfgtopoICA.component = 145:length(comp.label);
                figure
                ft_topoplotIC(cfgtopoICA, comp);
                end
            else
        cfgtopoICA.component = 109:length(comp.label);
        figure
        ft_topoplotIC(cfgtopoICA, comp);
            end
        else  
        cfgtopoICA.component = 73:length(comp.label);
        figure
        ft_topoplotIC(cfgtopoICA, comp);
        end
    else
    cfgtopoICA.component = 37:length(comp.label);
    figure
    ft_topoplotIC(cfgtopoICA, comp);
    end

else
    cfgtopoICA.component = 1:length(comp.label);
    figure
ft_topoplotIC(cfgtopoICA, comp);

end;

    


enduser = 0; 

while enduser==0
    
userchoice = input('Enter C to plot a specific component or R to reject components','s'); 

if strcmp(userchoice,'C')
    
    compnum2 = input('Enter component numbers e.g. [1 2 3 4]','s');
    
    eval(['complist = ' compnum2 ';']); 
    
    for k = 1:length(complist)
        compnum = complist(k);
    
    figcomps(compnum)=figure('Name',['Component ' num2str(compnum) ]); 
    
    
    subplot(5,1,1)
    semilogy(freqcomp.freq,freqcomp.powspctrm(compnum,:),'Linewidth',2);
    title('Spectrum'); 
    
    subplot(5,1,2)
    
    for j=1:size(comp.trial,2)        
    tempimage(j,:)=comp.trial{j}(compnum,:);  
    end; 
 
    imagesc(comp.time{1},1:size(comp.trial,2),tempimage);
   % colorbar
    
    title('All trials'); 
    
    subplot(5,1,3)
 hold on   
 plot(avg_comp.time,avg_comp.avg(compnum,:),'LineWidth',2);
 
    plot(avg_comp.time,avg_comp.avg(compnum,:),...
        avg_comp.time,avg_comp2.avg(compnum,:),...
        avg_comp.time,avg_comp3.avg(compnum,:),...
        avg_comp.time,avg_comp4.avg(compnum,:));
    set(gca,'YDir','reverse');
    hold off;
    
    title('ERP of component');
    
    subplot(5, 1, 4);
    imagesc(itc.time, itc.freq, squeeze(itc.itlc(compnum,:,:))); 
    axis xy
    colorbar
    title('inter-trial linear coherence');
    
    subplot(5,1,5)
    cfgtopoICA.component =compnum;
    cfgtopoICA.colorbar = 'East'; 
    
    ft_topoplotIC(cfgtopoICA, comp);
    
    set(figcomps(compnum),'Name',['Component ' num2str(compnum) ]);
    
    end;
    
elseif strcmp(userchoice,'R')
    aa = input('List of components to reject ? ', 's');
    cfgrej = [];
    cfgrej.demean = 'no';
    eval(['cfgrej.component = ' aa ]);
    dataclean = ft_rejectcomponent(cfgrej,comp,data);
        cfg=[];
        cfg.method   = 'trial';
        cfg.channel  = 'all';    % do not show EOG channels
        dataclean   = ft_rejectvisual(cfg, dataclean); 
        cfg=[];
        cfg.keeptrials = 'no'; % yes for statistical analysis no otherwise
        cfg.baseline     = [-0.2 -0]; 
        erp = ft_timelockanalysis(cfg, dataclean);
        erp = ft_timelockbaseline(cfg, erp);
        figure()
        cfg =[];
        cfg.layout = cfgbrowsICA.layout;
        cfg.showlabels    = 'yes';%, 'no' (default = 'no')
        ft_multiplotER(cfg, erp);
        
    verif = input('Is ICA analysis complete (Type "yes" or "no")');
    if strcmp(verif,'yes')
    enduser = 1;
    close all
    elseif strcmp(verif,'no')
        enduser =0;
        
    else 
        disp('wrong entry');
        pause(0.5);
    end
else
    
    disp('wrong entry');
    pause(0.5);
end

end


