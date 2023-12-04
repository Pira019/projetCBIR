function classes = obtenirClasses(imagesProches, dirname)
    % Obtenir les classes des images spécifiées
    fichiers = dir(fullfile(dirname, '*.tif'));
    classes = cell(1, numel(imagesProches));
    for i = 1:numel(imagesProches)
        nomFichier = fichiers(imagesProches(i)).name;
        [~, baseFileName, ~] = fileparts(nomFichier);
        % Diviser le nom du fichier en utilisant le point comme séparateur
        parts = strsplit(baseFileName, '.');
        % Concaténer le nom de la classe et le numéro de classe
        classe = sprintf('%s.%s', parts{1}, parts{2});
        classes{i} = classe;
    end
end
