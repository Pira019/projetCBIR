function [rr, r, rs, ormax] = CBIR_Simple(queryImagePath, dirname, nlevels, nsubs)
    % Entrées :
    %   queryImagePath : chemin du fichier de l'image de requête.
    %   dirname : répertoire contenant toutes les images, par exemple, './VisTexColor40_2023/'.
    %   nlevels : nombre de niveaux de la pyramide d'ondelettes (par défaut 3).
    %   nsubs : nombre de sous-images par classe. nsubs=16, valeur par défaut pour le jeu de données VisTexColor40_2023.

    % Sorties :
    %   rr : classement des images pertinentes en utilisant une distance de type Euclidienne.
    %   r : taux de reconnaissance global.
    %   rs : (facultatif) taux de reconnaissance moyen pour chaque classe de texture.
    %   ormax : (facultatif) taux de reconnaissance opérationnel en pourcentage,
    %          en fonction du nombre d'images récupérées considérées.

    % Extraction des caractéristiques basée sur les ondelettes de TOUTES les images.
    asd = wavefeat_asd_INDEX(dirname, nlevels);

    % Extraction des caractéristiques de l'image de requête.
    [queryFeatures] = wavefeat_asd(queryImagePath, nlevels);

    % Calcul des distances entre l'image de requête et toutes les autres images.
    distances = sum((asd - queryFeatures).^2, 1);

    % Classement des images en fonction des distances.
    [~, rr] = sort(distances);

    % Évaluation des performances de recherche d'images.
    [r, rs, ormax] = evalir(rr, nsubs);
  
    % Affichage des résultats.
    displayResults(queryImagePath, dirname, rr, r, rs, ormax);
end
