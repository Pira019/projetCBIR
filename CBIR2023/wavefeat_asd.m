function [asd] = wavefeat_asd(file, nlevels, filtre)
% wavefeat_asd : Calcule le vecteur de caractéristiques ASD (Average, Standard Deviation, Energy) des sous-bandes d'une image à l'aide de la décomposition en ondelettes 2D.

% Entrées :
%   file : nom de fichier de l'image texture en entrée.
%   nlevels : nombre de niveaux de la pyramide d'ondelettes.

% Sortie :
%   asd : vecteur de caractéristiques comprenant la moyenne, l'écart-type et l'énergie des sous-bandes d'ondelettes.

% Charger l'image
im = imread(file);
im = double(rgb2gray(im));

% Normalisation de l'image
im = (im - mean2(im)) ./ std2(im);

% Décomposition en ondelettes 2D
[C, L] = wavedec2(im, nlevels, filtre);  % Voir la décomposition en ondelettes 2D. Changez le filtre selon les besoins.

nbands = 3 * nlevels + 1;  % Inclure la bande d'approximation

asd = zeros(3 * nbands, 1);

% Calculer les caractéristiques pour chaque sous-bande
for b = 1:nbands
    band = sbcoef2(C, L, b);

    % Caractéristiques : moyenne, écart-type et énergie
    avg = sum(sum(abs(band))) / (size(band, 1) * size(band, 2));
    sd = sqrt(sum(sum(abs(band - avg).^2)) / (size(band, 1) * size(band, 2)));
    energy = sum(sum(band.^2)) / (size(band, 1) * size(band, 2));

    % Stocker les caractéristiques dans le vecteur ASD
    asd(3 * b - 2:3 * b) = [sd, avg, energy];
end
end
