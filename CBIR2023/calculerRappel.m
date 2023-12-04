function rappel = calculerRappel(resultats, veriteTerrain, topN, dirname)
    % Calcule le rappel pour les top N résultats en comparant avec la vérité terrain.

    % Limiter les résultats aux top N
    resultatsTopN = resultats(1:topN);

    % Obtenez les noms de fichiers correspondant aux indices de rr (sans extension)
    nomsClass = obtenirNomsFichiersPourRR(dirname, resultatsTopN);

    % Convertir veriteTerrain en cellule de chaînes de caractères
    veriteTerrain = cellstr(veriteTerrain);

    % Nombre total d'exemples pertinents
    totalPositifs = numel(veriteTerrain);

    % Nombre de vrais positifs (correspondances correctes)
    vraisPositifs = sum(ismember(nomsClass, veriteTerrain));

    % Calculer le rappel
    rappel = vraisPositifs / totalPositifs;
end
