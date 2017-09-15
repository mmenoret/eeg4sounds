
%%%%% INITIALISATION

%%%% Ce script effectue la visualisation des donn�es brutes

%%% choix du fichier
clear
infile='C:\Users\odufor\Desktop\postdocorange\DONNEES_SUJETS\PC27\PC27OddBin_20170711_100408.mff';


%%% Identification des essais
cfg=[];
cfg.namesuj='CP12';
cfg.trialfun   = 'ft_trialfun_OddBin';% enleve 250 ms a chaque trigger
cfg.trialdef.prestim=0.5;
cfg.trialdef.poststim=1;
cfg.dataset=infile;
cfg=ft_definetrial(cfg);

trials = cfg.trl;

cfg.viewmode = 'vertical'; %%%% remplacer par butterfly pour avoir les electrodes superpos�es
%%% Param�tres de pr�processing uniquement pour la visu 
cfg.preproc.bpfilter = 'yes';
cfg.preproc.bpfreq = [0.3 70];
cfg.preproc.dftfilter = 'yes'; %%% Ceci est le notch 

%%% Cette fonction d�marre l'outil de visualisation 
cfg_visual_clean = ft_databrowser(cfg);

%%% Dans cfg_visual_clean, on a la d�finition des segments rejet�s
%%% manuellement
%%% Ils sont visibles dans cfg_visual_clean.artfctdef.visual.artifact

%%%% Pour les rejeter, appliquer la fonction ft_rejectartifact de la
%%%% mani�re suivante : 


 % rejet artefacts
    cfg            = [];
    cfg.trl        = trials;
    cfg.datafile   = infile;
    cfg.headerfile = infile;
    cfg.artfctdef = cfg_visual_clean.artfctdef;
    cfg.artfctdef.reject          = 'complete';%'complete' (default = 'complete')
    %cfg.artfctdef.minaccepttim    =                      
    %cfg.artfctdef.crittoilim      = %when using complete rejection, reject  trial only when artifacts occur within this time window (default = whole trial)
    %cfg.artfctdef.eog.artifact    = artifact_eog;
    %cfg.artfctdef.jump.artifact   = artifact_jump;
    %cfg.artfctdef.muscle.artifact = artifact_muscle;
    cfg_clean = ft_rejectartifact(cfg);

%%%%