function displayResults(queryImagePath, dirname, rr, r, rs, ormax,nbrImage)
  
    % Chargez et affichez l'image de requête.
    queryImage = imread(queryImagePath);
    figure;
    subplot(1, min(nbrImage+1, length(rr) + 1), 1); % Configure le subplot pour afficher l'image de requête 
    imshow(queryImage);
    title('Image de Requête');

    files = dir(fullfile(dirname, '*.tif'));  
    % Chargez et affichez les images pertinentes.
    for i = 1:min(nbrImage, length(rr))
        % Vérifiez si l'index est dans la plage valide. 
        if rr(i) + 2 <= length(files) 
            imagePath =  fullfile(dirname, files(rr(i) + 2).name);   
            disp(imagePath)
            relevantImage = imread(imagePath);
            subplot(1, min(nbrImage+1, length(rr) + 1), i + 1);
            imshow(relevantImage);
            title(['Rang ', num2str(i)]);
        end
    end

     % Affichez des informations supplémentaires en bas
    annotation('textbox', [0, 0, 1, 0.1], 'String', {
        sprintf('Taux de reconnaissance global : %.2f%%', r * 100),
        'Taux de reconnaissance moyen par classe de texture :',
        num2str(rs),
        sprintf('Taux de reconnaissance opérationnel (ORMax) : %.2f%%', ormax * 100)
    }, 'FitBoxToText', 'on', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
end
