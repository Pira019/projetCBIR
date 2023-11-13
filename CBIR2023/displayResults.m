function displayResults(queryImagePath, dirname, rr, r, rs, ormax)
    % Chargez et affichez l'image de requête.
    queryImage = imread(queryImagePath);
    figure;
    subplot(1, min(11, length(rr) + 1), 1); % Ajustez la limite du subplot pour afficher uniquement les images pertinentes
    imshow(queryImage);
    title('Image de Requête');

    files = dir(fullfile(dirname, '*.tif')); 
        
    % Chargez et affichez les images pertinentes.
    for i = 1:min(3, length(rr)) % Boucle à travers les 3 premières images pertinentes
        % Vérifiez si l'index est dans la plage valide.
        if rr(i) + 2 <= length(files)
            % Supposons que les images sont dans le répertoire spécifié (dirname).
            imagePath =  fullfile(dirname, files(rr(i) + 2).name);
            relevantImage = imread(imagePath);
            subplot(1, min(11, length(rr) + 1), i + 1); % Ajustez la limite du subplot
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
