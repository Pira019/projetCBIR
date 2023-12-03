function b = sbcoef2(c, s, n)
% SBCOEF2 Extrait les coefficients de la sous-bande 2D
%   B = SBCOEF2(C, S, N)
%
% Entrées :
%   [C, S] : structure de décomposition en ondelettes (voir WAVEDEC2)
%   N : numéro de la sous-bande, 0 pour l'approximation,
%      1 pour H(K), 2 pour V(K), 3 pour D(K), 4 pour H(K-1), ...
%      où K est le nombre de niveaux de décomposition en ondelettes
%
% Sortie :
%   B : coefficients de la sous-bande (sous forme d'un vecteur)

if n == 0
    b = c(1:s(1,1)*s(1,2));
else
    q = floor((n-1) / 3);
    r = n - 1 - 3*q;

    % Calcul de la taille de la sous-bande
    length = s(q+2,1)*s(q+2,2);

    % Calcul de l'indice de départ
    start_idx = sum(s(1:q+1,1).*s(1:q+1,2)) + r*length + 1;

    % Vérification si l'indice de départ est valide
    if start_idx > numel(c) || start_idx < 1
        error('Indice de départ invalide dans sbcoef2');
    end

    % Utilisation de wkeep pour extraire les coefficients de la sous-bande
    b = wkeep(c, length, 'c', start_idx);

    % Vérification si l'extraction est valide
    if numel(b) ~= length
        error('Extraction invalide dans sbcoef2');
    end
end
end

%La logique utilisée ici simplifie le calcul des indices en évitant de spécifier un last directement, ce qui pourrait contribuer à des erreurs (excee d'index). La fonction wkeep gère cela, en extrayant la portion nécessaire du vecteur c en fonction de l'indice de départ et de la longueur spécifiés.
%Cette fonction est utile dans le contexte de la décomposition en ondelettes, où les images sont décomposées en différentes sous-bandes représentant différentes échelles et directions.




