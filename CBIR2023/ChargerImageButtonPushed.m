
    % Spécifiez le chemin de l'image de requête, le répertoire d'images et les paramètres CBIR.
    queryImagePath = './VisTexColor40_2023/Food.0008.05.tif';
    dirname = './VisTexColor40_2023/';
    nlevels = 3;
    nsubs = 16;

    % Exécutez la recherche CBIR.
   % Call CBIR_Simple and capture the output
  CBIR_Simple(queryImagePath, dirname, nlevels, nsubs);

 
 
