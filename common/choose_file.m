function [currentfile] = choose_file(datadir)
[curfile,path2file] = uigetfile({[datadir '/*.mff']},'Choisissez le fichier � analyser');

currentfile = [path2file,curfile];
disp(['File : ' currentfile])