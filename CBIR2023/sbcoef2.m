function b = sbcoef2(c, s, n)
    % SBCOEF2 Extrait les coefficients de la sous-bande 2D
    %   B = SBCOEF2(C, S, N)
    %
    % Entrées :
    %   C : cellule des coefficients de la décomposition en ondelettes
    %   S : structure des tailles des coefficients
    %   N : numéro de la sous-bande, 0 pour l'approximation,
    %      1 pour H(K), 2 pour V(K), 3 pour D(K), 4 pour H(K-1), ...
    %      où K est le nombre de niveaux de décomposition en ondelettes
    %
    % Sortie :
    %   B : coefficients de la sous-bande (sous forme d'un vecteur)

    if n == 0
        b = c{1};
    else
        q = floor((n-1) / 3);
        r = n - 1 - 3*q;

        % Calcul de la taille de la sous-bande
        level = min(q + 2, length(s.dec));
        length = s.dec(level, 1) * s.dec(level, 2);

        % Calcul de l'indice de départ
        start_idx = sum(s.dec(1:level,1).*s.dec(1:level,2)) + r*length + 1;

        % Vérification si l'indice de départ est valide
        if start_idx > numel(c{level}) || start_idx < 1
            error('Indice de départ invalide dans sbcoef2');
        end

        % Utilisation de wkeep pour extraire les coefficients de la sous-bande
        b = wkeep(c{level}, [s.dec(level,1), s.dec(level,2)], 'c', start_idx);

        % Vérification si l'extraction est valide
        if numel(b) ~= length
            error('Extraction invalide dans sbcoef2');
        end
    end
end
