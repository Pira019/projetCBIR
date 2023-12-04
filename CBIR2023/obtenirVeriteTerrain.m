function veriteTerrain = obtenirVeriteTerrain(dirname, nsubs, classeNumeroRequete)
    % Obtenir les noms de fichiers (sans extension) de la vérité terrain en fonction du format de nommage des fichiers.
    
    % Liste de tous les fichiers dans le répertoire
    fichiers = dir(fullfile(dirname, '*.tif'));

    % Initialiser un tableau de noms pour la vérité terrain
    veriteTerrain = strings(1, nsubs);

    % Itérer à travers les fichiers de la classe de l'image de requête
    index = 1;
    imagesClasseRequete = fichiers(contains({fichiers.name}, classeNumeroRequete));
    imagesClasseRequete = imagesClasseRequete(1:nsubs);  % Sélectionner les premières images nsubs

    % Ajouter les noms de fichiers au tableau de vérité terrain avec le format "nomClass.numClass"
    for i = 1:nsubs
        [~, fileName, ~] = fileparts(imagesClasseRequete(i).name);
        parts = split(fileName, '.');  % Diviser le nom de fichier en parties
        classe = sprintf('%s', parts{1});  % Format "nomClass.numClass"
        veriteTerrain(index) = string(classe);
        index = index + 1;
    end
end
