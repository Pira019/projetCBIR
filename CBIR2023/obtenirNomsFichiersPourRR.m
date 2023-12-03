function [nomsFichiersRetournes] = obtenirNomsFichiersPourRR(dirname, rr, nbrImageRetour)
    % Obtenir les noms de fichiers correspondant aux indices de rr.

    files = dir(fullfile(dirname, '*.tif'));  
    
    % Initialiser le tableau cellulaire pour les noms de fichiers retournés
    nomsFichiersRetournes = cell(1, min(nbrImageRetour, numel(rr)));

    % Chargez et affichez les images pertinentes.
    for i = 1:min(nbrImageRetour, numel(rr))
        % Vérifiez si l'index est dans la plage valide. 
        index = min(rr(i) + 2, numel(files)); 
          [~, nomFichier, ~] = fileparts(files(index).name);
        nomsFichiersRetournes{i} = nomFichier;
    end 
end
