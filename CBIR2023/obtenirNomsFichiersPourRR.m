function nomsFichiersRetournes = obtenirNomsFichiersPourRR(dirname, rr)
    % Obtenir les noms de fichiers correspondant aux indices de rr (sans extension).

    files = dir(fullfile(dirname, '*.tif'));  
    
    % Initialiser le tableau cellulaire pour les noms de fichiers retournés
    nomsFichiersRetournes = cell(1, numel(rr));

    % Charger et afficher les images pertinentes.
    for i = 1:numel(rr)
        % Vérifier si l'index est dans la plage valide. 
        index = min(rr(i), numel(files)); 
        nomFichierComplet = files(index).name;
        
        % Extraire le nom du fichier sans l'extension
        [~, nomFichierSansExt, ~] = fileparts(nomFichierComplet);
        
        % Séparer le nom du fichier en parties
        parts = split(nomFichierSansExt, '.');
        
        % Reformater le nom du fichier dans le style "nomClass.numClass"
        %nomFormate = sprintf('%s.%s', parts{1}, parts{2});
        nomFormate = sprintf('%s', parts{1});
        % Ajouter le nom du fichier au tableau
        nomsFichiersRetournes{i} = nomFormate;
    end 
end
