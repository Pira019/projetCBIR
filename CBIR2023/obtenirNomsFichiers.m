function nomsFichiersRetournes = obtenirNomsFichiers(dirname)
    % Obtenir les noms de fichiers (sans extension) dans le répertoire spécifié.

    % Liste de tous les fichiers dans le répertoire
    fichiers = dir(fullfile(dirname, '*.tif'));

    % Extraire les noms de fichiers (sans extension) dans une cellule
    [~, nomsFichiers, ~] = cellfun(@fileparts, {fichiers.name}, 'UniformOutput', false);
    
    nomsFichiersRetournes = nomsFichiers;
end
