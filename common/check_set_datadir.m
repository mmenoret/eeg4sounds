if ~exist('datadirset','var')
    datadir = uigetdir('.','Choissisez le dossier des donn�es');
    datadirset=1;
end

disp([' Dossier data : ' datadir])
disp('Faire "clear" pour r�initiliaser')