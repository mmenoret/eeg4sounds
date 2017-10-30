%% 2 - Rejection d'artefact visuellement identifiables sur des donn�es filtr�es 
%% -- input : donn�es brutes (elec utiles )
%% -- output : annotations d'artefacts identifi�s visuellement
%% cette �tape est semi-automatique
addpath ../common/

check_set_resultdir;

[filetoinspect,filepath] = uigetfile([resultdir '/ecoute/import/*.mat']);

%%% Checking whether this file has been already inspected 


%%% Create result folder for storing visual artefacts

if ~exist([resultdir '/ecoute/vis_art'],'dir')
    
    mkdir([resultdir '/ecoute/vis_art'])
    
end

resultfile_visart = [resultdir, '/ecoute/vis_art/', filetoinspect];

if exist(resultfile_visart,'file')
    disp('File has already been visually inspected : loading results.');
end



%%% Defining the cfg for inspection 

cfg = [];

visdata = load([filepath,filetoinspect],'data');

cfg.viewmode = 'vertical'; %%%% remplacer par butterfly pour avoir les electrodes superpos�es
%%% Param�tres de pr�processing uniquement pour la visu
cfg.preproc.bpfilter = 'yes';
cfg.preproc.bpfreq = [0.3 70];

%cfg.blocksize = 10; %%% by blocks of 10 seconds 
cfg.channel = [1:50];

cfg.preproc.dftfilter = 'yes'; %%% Ceci est le notch

%%% Cette fonction d�marre l'outil de visualisation
cfg_visual_clean = ft_databrowser(cfg,visdata.data);