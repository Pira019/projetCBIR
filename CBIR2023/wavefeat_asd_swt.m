function [asd] = wavefeat_asd_swt(file, nlevels, filter)
    % Lire l'image et convertir en niveau de gris.
    im = double(rgb2gray(imread(file)));

    % Normalisation de l'image.
    im = (im - mean2(im)) / std2(im);

   

    % Décomposition en ondelettes stationnaires 2D (SWT2).
    [A, H, V, D] = swt2(im, nlevels, filter);

    % Nombre total de sous-bandes.
    nbands = nlevels^2 + 1;  % Inclure l'image d'approximation.

    asd = zeros(2 * nbands, 1);

    % Calculer l'énergie pour chaque sous-bande.
    for level = 1:nlevels
        for direction = 1:3 % Trois directions pour chaque niveau dans SWT2
            switch direction
                case 1
                    band = H(level, :, :); % Détail horizontal
                case 2
                    band = V(level, :, :); % Détail vertical
                case 3
                    band = D(level, :, :); % Détail diagonal
            end

            % Calculer l'énergie de la sous-bande.
            energy = sum(abs(band(:)).^2) / numel(band);

            % Stocker l'énergie dans le vecteur ASD.
            index = (level - 1) * 3 + direction;
            asd(2 * index - 1:2 * index) = [sqrt(energy), mean(band(:))];
        end
    end

    % Ajouter l'énergie de l'image d'approximation.
    app_energy = sum(abs(A(:)).^2) / numel(A);
    asd(end+1:end+2) = [sqrt(app_energy), mean(A(:))]; 
end
