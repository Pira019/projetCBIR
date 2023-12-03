%function [rr, r, rs, ormax, imagesResulats] = CBIR_Simple(queryImagePath, nlevels, nsubs,nbrImage)
function [imgsDwt2,imgsSwt2,precisionDwt2,precisionSwt2,imagesPertinentesRecupereesDWT2,imagesPertinentesRecupereesSwt2,seuil,seuilSwt] = CBIR_Simple(queryImagePath, nlevels, nsubs,filtre,nbrImage)
    dirname = './VisTexColor40_2023/';
    % Entrées :
    %   queryImagePath : chemin du fichier de l'image de requête.
    %   dirname : répertoire contenant toutes les images, par exemple, './VisTexColor40_2023/'.
    %   nlevels : nombre de niveaux de la pyramide d'ondelettes (par défaut 3).
    %   nsubs : nombre de sous-images par classe. nsubs=16, valeur par défaut pour le jeu de données VisTexColor40_2023.
    %   nbrImage nombre d'images de retour

    % Sorties :
    %   rr : classement des images pertinentes en utilisant une distance de type Euclidienne.
    %   r : taux de reconnaissance global.
    %   rs : (facultatif) taux de reconnaissance moyen pour chaque classe de texture.
    %   ormax : (facultatif) taux de reconnaissance opérationnel en pourcentage,
    %          en fonction du nombre d'images récupérées considérées.

    % Extraction des caractéristiques basée sur les ondelettes de TOUTES les images.
    [dwt2,swt2] = wavefeat_asd_INDEX(dirname, nlevels,filtre); 

    % Extraction des caractéristiques de l'image de requête DWT2.
    [queryFeatures] = wavefeat_asd(queryImagePath, nlevels,filtre);

    [queryFeaturesSwt2] = wavefeat_asd_swt(queryImagePath, nlevels,filtre);

    % Calcul des distances entre l'image de requête et toutes les autres images.
    distancesDwt2 = sqrt(sum((dwt2 - queryFeatures).^2, 1));
    distancesSwt2 = sqrt(sum((swt2 - queryFeaturesSwt2).^2, 1));

    % Classement des images en fonction des distances DWt2.
    [~, rr_dwt2] = sort(distancesDwt2);  

    % Classement des images en fonction des distances DWt2.
    [~, rr_swt2] = sort(distancesSwt2);
 
    % Évaluation des performances de recherche d'images.
   %[r, rs, ormax] = evalir(rr_swt2, nbrImage);
 
    %disp(rs)
 
    % Affichage des résultats.
    %displayResults(queryImagePath, dirname, rr, r, rs, ormax,nbrImage); 
    
    % calcule de la precision% calcule de la precision
    [precisionDwt2,imagesPertinentesRecupereesDWT2,seuil] = calculerPrecision(rr_dwt2,distancesDwt2,10,nbrImage);
    [precisionSwt2,imagesPertinentesRecupereesSwt2,seuilSwt] = calculerPrecision(rr_swt2,distancesSwt2,10,nbrImage);  

    [imgsDwt2,imgsSwt2] = resultatRecherche(dirname,rr_dwt2,rr_swt2,nbrImage); 
end
