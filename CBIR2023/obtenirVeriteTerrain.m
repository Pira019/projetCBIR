function [veriteTerrain] = obtenirVeriteTerrain(dirname, nsubs)
    % Obtenir les noms de fichiers (sans extension) de la vérité terrain en fonction de la convention de nommage des fichiers.
    
    % Liste de tous les fichiers dans le répertoire
    fichiers = dir(fullfile(dirname, '*.tif'));

    % Extraire les informations de classe à partir des noms de fichiers
    nomsClasses = cellfun(@(x) strtok(x, '.'), {fichiers.name}, 'UniformOutput', false);

    % Générer une liste unique de classes
    classesUniques = unique(nomsClasses);

    % Initialiser un tableau de noms pour la vérité terrain
    veriteTerrain = strings(1, nsubs * numel(classesUniques));

    % Itérer à travers chaque classe et sélectionner les premières images nsubs
    index = 1;
    for i = 1:numel(classesUniques)
        imagesClasse = fichiers(strcmp(nomsClasses, classesUniques{i}));
        imagesClasse = imagesClasse(1:nsubs);  % Sélectionner les premières images nsubs
        
        % Ajouter les noms de fichiers sans extension au tableau de vérité terrain
        [~, fileNames, ~] = cellfun(@fileparts, {imagesClasse.name}, 'UniformOutput', false);
        veriteTerrain(index:index+nsubs-1) = string(fileNames);
        index = index + nsubs;
    end
end
