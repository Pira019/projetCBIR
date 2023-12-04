 function [imgsDwt2,imgsSwt2,precisionDwt2,precisionSwt2,imagesPertinentesRecupereesDWT2,imagesPertinentesRecupereesSwt2,rappelDwt2,rappelSwt2] = CBIR_Simple(queryImagePath, nlevels, nsubs,filtre,nbrImage)
    dirname = './VisTexColor40_2023/';
    % Entrées :
    %   queryImagePath : chemin du fichier de l'image de requête.
    %   dirname : répertoire contenant toutes les images, par exemple, './VisTexColor40_2023/'.
    %   nlevels : nombre de niveaux de la pyramide d'ondelettes (par défaut 3).
    %   nsubs : nombre de sous-images par classe. nsubs=16, valeur par défaut pour le jeu de données VisTexColor40_2023.
    %   nbrImage nombre d'images de retour 
     

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
 
   % Détermination de la classe majoritaire parmi les k images les plus proches
   classeMajoritaireDwt2 = determinerClasseMajoritaire(rr_dwt2(1:nbrImage), dirname);
   classeMajoritaireSwt2 = determinerClasseMajoritaire(rr_swt2(1:nbrImage), dirname);


    % calcule de la precision
    [precisionDwt2,imagesPertinentesRecupereesDWT2] = calculerPrecision(rr_dwt2,obtenirVeriteTerrain(dirname,nsubs,classeMajoritaireDwt2),nbrImage,dirname);
    [precisionSwt2,imagesPertinentesRecupereesSwt2] = calculerPrecision(rr_swt2,obtenirVeriteTerrain(dirname,nsubs,classeMajoritaireSwt2),nbrImage,dirname);  

    [imgsDwt2,imgsSwt2] = resultatRecherche(dirname,rr_dwt2,rr_swt2,nbrImage); 

    % calcule de la rappel
    rappelDwt2 = calculerRappel(rr_dwt2, obtenirVeriteTerrain(dirname,nsubs,classeMajoritaireDwt2), nbrImage,dirname);
    rappelSwt2 = calculerRappel(rr_swt2, obtenirVeriteTerrain(dirname,nsubs,classeMajoritaireSwt2), nbrImage,dirname);
end
