function classeMajoritaire = determinerClasseMajoritaire(imagesProches, dirname)
    % Déterminer la classe majoritaire parmi les images les plus proches
    classes = obtenirClasses(imagesProches, dirname);
    
    % Trouver la classe majoritaire
    [uniques, ~, idx] = unique(classes);
    occurences = histcounts(idx, 1:numel(uniques)+1);
    
    [~, indiceMajoritaire] = max(occurences);
    classeMajoritaire = uniques{indiceMajoritaire}; 
end
