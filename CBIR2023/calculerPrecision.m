function [precision,imagesPertinentesRecuperees,seuil] = calculerPrecision(rr, distances, pourcentage, nbrImage)
    % Calculer la précision en fonction du classement des images pertinentes (rr),
    % des distances, d'un pourcentage, et du nombre d'images souhaitées (nbrImage).

    % Calculer le seuil en fonction du pourcentage des distances.
    seuil = pourcentage / 100 * max(distances);
    
  
    % Sélectionner les indices des images pertinentes en fonction du seuil.
    indicesPertinents = find(distances < seuil); 

    % Nombre d'images pertinentes à considérer (en fonction du nombre d'images voulu).
    numImagesPertinentes = min(numel(indicesPertinents), nbrImage);

    % Gérer le cas où numImagesPertinentes est 0 pour éviter une division par zéro.
    if numImagesPertinentes == 0
        precision = 0;
        return;
    end

    % Sélectionner les numImagesPertinentes premiers indices des images classées.
    indicesClassifies = rr(1:numImagesPertinentes);

    % Utiliser le minimum entre numImagesPertinentes et nbrImage dans le calcul.
    indicesPertinentsATraiter = indicesPertinents(1:min(numImagesPertinentes, nbrImage));

    % Calculer la précision.
    imagesPertinentesRecuperees = sum(ismember(indicesClassifies, indicesPertinentsATraiter));
    precision = imagesPertinentesRecuperees / numel(rr(1:nbrImage)) * 100; 
end
