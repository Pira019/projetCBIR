function [asd] = wavefeat_asd(file, nlevels, filtre)
    % wavefeat_asd : Calcule le vecteur de caractéristiques ASD (Average, Standard Deviation, Energy) des sous-bandes d'une image à l'aide de la décomposition en ondelettes 2D.

    % Entrées :
    %   file : nom de fichier de l'image texture en entrée.
    %   nlevels : nombre de niveaux de la pyramide d'ondelettes.
    %   filtre : filtre utilisé dans la décomposition en ondelettes 2D.

    % Sortie :
    %   asd : vecteur de caractéristiques comprenant la moyenne, l'écart-type et l'énergie des sous-bandes d'ondelettes.

    % Charger l'image
    im = imread(file);
    im = double(rgb2gray(im));

    % Normalisation de l'image
    im = (im - mean2(im)) ./ std2(im);

    % Initialiser le vecteur ASD
    asd = zeros(3 * nlevels + 3, 1);  % Pré-allouer l'espace pour les caractéristiques

    % Indice pour suivre la position dans asd
    idx = 1;

    % Boucle pour chaque niveau
    for level = 1:nlevels
        % Décomposition en ondelettes 2D avec dwt2
        [A, H, V, D] = dwt2(im, filtre, 'mode', 'sym');

        % Calculer les caractéristiques pour chaque sous-bande
        for direction = 1:3
            switch direction
                case 1
                    band = H; % Détail horizontal
                case 2
                    band = V; % Détail vertical
                case 3
                    band = D; % Détail diagonal
            end

            % Calculer les caractéristiques de la sous-bande.
            moyenne = mean(band(:));
            ecart_type = std(band(:));
            energie = sum(band(:).^2) / numel(band);

            % Stocker les caractéristiques dans le vecteur ASD.
            asd(idx:idx+2) = [ecart_type; moyenne; energie];
            idx = idx + 3;
        end

        % Ajouter l'énergie de l'image d'approximation.
        app_energy = sum(A(:).^2) / numel(A);
        asd(idx:idx+2) = [sqrt(app_energy); mean(A(:)); std(A(:))];
        idx = idx + 3;

        % Mettre à jour l'image pour la prochaine itération
        im = A;
    end
end
