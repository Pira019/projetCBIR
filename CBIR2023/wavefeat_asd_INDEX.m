function [asd] = wavefeat_asd_INDEX(dirname,nlevels)

% Input:
%   dirname: directory that contains all images, e.g. '../VisTex/sub128'
%   nlevels: number of wavelet pyramid levels.

% Output:
%   asd: Feature vectors from average and standard deviation.

files=dir(dirname);
% Initialize
asd  = [];

for i=3:size(files,1)
    
[fv] = wavefeat_asd([dirname,files(i).name], nlevels);
 asd  = [asd, fv];

end

%cette fonction agit comme une enveloppe pour extraire des caractéristiques basées sur les ondelettes (moyenne et écart-type des coefficients d'ondelettes) à partir d'images dans un répertoire donné. Les vecteurs de caractéristiques sont collectés et renvoyés sous forme de matrice (asd). L'extraction réelle des caractéristiques par ondelettes est effectuée par la fonction wavefeat_asd.