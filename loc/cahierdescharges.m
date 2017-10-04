% Description des �tapes du pipeline de preprocessing LOC


%%%% A FAIRE : TRIAL FUNCTION qui lit un fichier excel qui contiendra les
%%%% d�tails, par essai: 
%%% - condition (6 cadrans x (stereo, binaural) = 12 possibilit�s) 
%%% - bonne r�ponse ou non 
%%% - temps de r�action  (Tr) 
%%% De ces infos, on en tire des events diff�rents pour tout ca, et surtout
%%% on d�duit l'onset du son � partir du Tr 

%%% DEUX RUNS IDENTIQUES 

%%% A DEFINIR : TRIAL LENGTH ? 600 MS ? 

%% 1 - Garder un set d'electrodes d�fini � l'avance (d�fini dans script_0_paramaters) 
%% -- input : donn�es brutes 
%% -- output : donn�es brutes moins les �lectrodes rejet�es (format mat) 

%% 2 - Rejection d'artefact visuellement identifiables sur des donn�es filtr�es 
%% -- input : donn�es brutes (elec utiles )
%% -- output : annotations d'artefacts identifi�s visuellement
%% cette �tape est semi-automatique

%% 3 - Rejection d'artefacts automatique Jump + muscles 
%% -- Input : donn�es brutes (elec utiles)  + Seuil (A DEFINIR POUR LE GROUPE)
%% --output : annotations d'artefacts jump et muscles 
%% cette �tape est semi-automatique (identification du seuile 

%% 4 - Visualisation - premier contr�le qualit� : 
%% - a - �tape identique � 2 o� l'on visualise les donn�es horizontalement avec les sections identifi�es pr�cedemment comme artefacts
%% - b - mode "summary" qui permet d'identifier imm�diatement les �lectrodes trop bruit�es (� interpoler) 
%% - c - mode "electrode" idem 
%% output : annotations d'electrodes � rejeter et � interpoler plus tard

%% 5 - Transform ICA (Analyse en composantes ind�pendantes) 
%% -- Inputs : donn�es brutes (elec utiles)  + annotations d'artefacts des �tapes 2 et 3 + annotations d'electrodes � rejeter
%% -- Output : Composantes ICA

%% 6 - Inspect ICA : inspection visuelle pour identifier quelles composantes correspondent aux mouvements oculaires
%% -- input : Composantes ICA + donn�es pre-clean�es ( = brutes utiles moins elec bruit�es moins artefacts)
%% -- output : donn�es "back-projet�es"  (i.e. en enlevant la contribution des composantes artefacts mouvements oculaires) 

%% 7 - Visualisation - deuxi�me contr�le qualit� : 
%% - a - �tape identique � 2 o� l'on visualise les donn�es horizontalement avec les sections identifi�es pr�cedemment comme artefacts
%% - b - mode "summary" qui permet d'identifier imm�diatement les �lectrodes trop bruit�es (� interpoler) 
%% output : annotations de segments / essais � rejeter sur les donn�es clean 

%% 8 - Output donn�es preproc�ss�es finale
%% input : output de 7 
%% output : donn�es preproc finale 

%% 9 - Calcul des ERP individuels 
%% input : donn�es preproc finale 
%% output : ERP individuel 

%% 10 - Visu ERP individuels 




%% 10 - Calcul des grand average ERP 
%% input : ERP individuels de tous 


