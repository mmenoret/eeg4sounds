if ~exist('resultdirset','var')
    resultdir = uigetdir('.','Choissisez le dossier des r�sultats');
    resultdirset=1;
    
    
    %%% Individual tests to check if the directory structure was set or not
    %%% 
    
    
    
end

disp(['Results Directory : ' resultdir])