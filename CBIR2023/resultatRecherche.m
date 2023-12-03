function [imgsDwt2, imgsSwt2] = resultatRecherche(dirname, indicesDwt2, indicesSwt2, nbrImage)
    files = dir(fullfile(dirname, '*.tif'));  
    imgsDwt2 = cell(1, min(nbrImage, length(indicesDwt2)));  % Initialisation du tableau de cellules
    imgsSwt2 = cell(1, min(nbrImage, length(indicesSwt2)));  % Initialisation du tableau de cellules

    numImagesDwt2 = min(nbrImage, length(indicesDwt2));
    numImagesSwt2 = min(nbrImage, length(indicesSwt2));

    % Chargez et affichez les images pertinentes. DWT2
    for i = 1:numImagesDwt2
        % Vérifiez si l'index est dans la plage valide. 
        idx = indicesDwt2(i) + 2;
        if idx <= length(files) && idx > 0
            imgsDwt2{i} = fullfile(dirname, files(idx).name);  
        end
    end
    
    % Chargez et affichez les images pertinentes. SWT2
    for i = 1:numImagesSwt2
        % Vérifiez si l'index est dans la plage valide. 
        idx = indicesSwt2(i) + 2;
        if idx <= length(files) && idx > 0
            imgsSwt2{i} = fullfile(dirname, files(idx).name);  
        end
    end
end
