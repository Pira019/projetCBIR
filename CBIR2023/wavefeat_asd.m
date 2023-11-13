function [asd] = wavefeat_asd(file, nlevels)

% Input:
%   file: filename of the input texture image.
%   nlevels: number of wavelet pyramid levels.

% Output:
%   asd: feature vector of average and standard deviation of wavelet subbands.
im=imread(file);
im = double(rgb2gray(im));

im = (im - mean2(im)) ./ std2(im);      % Image Normalization

[C,L] = wavedec2(im,nlevels,'db1');    %See Multilevel 2-D wavelet decomposition. Change the filter as you wish.

nbands = 3 * nlevels;

asd = zeros(2 * nbands, 1);

for b = 1:nbands

    band = sbcoef2(C, L, b);
    
%     Features from average and standard deviation
      a= sum(sum(abs(band)))/(size(band,1)*size(band,2));
      sd= sqrt(sum(sum(abs(band-a).^2))/(size(band,1)*size(band,2)));
      asd(2*b-1:2*b) = [sd,a];

      %le code utilise des ondelettes orthogonales avec wavedec2 pour extraire des caractéristiques basées sur la moyenne et l'écart type des sous-bandes d'une image de texture spécifiée.
end