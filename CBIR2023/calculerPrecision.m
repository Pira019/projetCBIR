function  [precision,correctementClassesTopN] = calculerPrecision(resultats, veriteTerrain, topN,dirname)
    % Calcule la précision pour les top N résultats en comparant avec la vérité terrain.

  
    % Limiter les résultats aux top N
    resultatsTopN = resultats(1:topN);
    
    nomsClass=obtenirNomsFichiersPourRR(dirname,resultatsTopN);
    
    veriteTerrain = cellstr(veriteTerrain);

    % Vérifier si la vérité terrain est présente parmi les top N résultats
    correctementClassesTopN = sum(ismember(nomsClass, veriteTerrain)); 
    % Calculer la précision pour les top N
    precision = correctementClassesTopN / numel(resultatsTopN) * 100;
end
