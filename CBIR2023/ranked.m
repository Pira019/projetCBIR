function rr = ranked(fs, ns, normflag, normorder)
% RANKED Rank relevant images using Euclidean-liked distance
%
% Input:
%	fs:	feature sets, one column per image
%	ns:	(optional), number of subimages per texture class
%		(default 16)
%	normflag: (optional), indicate method of normalization vectors
%			1 for use standard deviation (default)
%			2 for use deviation from the median
%			3 for weights equal to 1 (unweighted)
%	normorder: (optional), indicate the norm that used for computing
%		distances: 1 for L1-norm, 2 for L2-norm
%		(default 2)
%
% Output:
%	rr:	rank of relevant images, one column for each query

if nargin < 2
    ns = 16;
end

if nargin < 3
    normflag = 1;
end

if nargin < 4
    normorder = 2;
end

[nf, nimages] = size(fs);


% ------------- %
% Normalization %
% ------------- %
switch normflag
    case 1,
	% Method 1: Use standand deviation
	w = std(fs, 1, 2);
    case 2,
	% Method 2: Use deviation from the median
	% Theoretical, this method is LESS affected by outliers
	m = median(fs, 2);
	w = sum(abs(fs - m(:, ones(1, nimages))), 2) / nimages;
    otherwise,
	% Do not use weights (all weights equal to 1)
	w = ones(nf, 1);
end

fs = fs ./ w(:, ones(1, nimages));

rr = zeros(ns, nimages);
copies = zeros(1, nimages);
ii = 1:nimages;

for q = 1:nimages			% each query			
    % Compute distances of each image in the database to the query
    switch normorder
	case 1,
	    % L^1 norm
	    d = sum(abs(fs - fs(:, q+copies)), 1);
	case 2
	    % L^2 norm
	    d = sum((fs - fs(:, q+copies)) .^2, 1);
	case -1
	    % Approximate Kullback-Leibler distance for the Laplacian pdf
	    d = sum(fs ./ fs(:, q+copies) + fs(:, q+copies) ./ fs - 2, 1);
    end
    
    % Sort distances in ascending order
    [sd, si] = sort(d);

    % Find the rank of the images
    r(si) = ii;
    
    % Save the ranks of the relevant images
    c = floor((q-1) / ns);
    rr(:, q) = r((c*ns+1):((c+1)*ns))';
end
