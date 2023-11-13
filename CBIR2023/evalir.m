
function [r, rs, ormax] = evalir(rr, mnr)
% EVALIR Evaluate Image Retrieval (IR) performance
%
% Input:
%	rr:	rank of relevant images, one column for each query
%	mnr:	(optional) maximum number of retrieved images considered
%		(default 100)
%
% Output:
%	r:	overall recognition rate
%	rs:	(optional) average recognition rate for each texture class
%	or:	(optional) operating recognition rate in percentage,
%		according to the number of retrieved images considered

[ns, nimages] = size(rr);
pr = zeros(1, nimages);

for q = 1:nimages    
    pr(q) = length(find(rr(:, q) <= ns)); %nombre de rank <= 16 par colonne
end

r = mean(pr) / ns * 100;

if nargout > 1
    rs = mean(reshape(pr, ns, floor(nimages/ns))) / ns * 100;
end

if nargout > 2
    if nargin < 2
	mnr = 100;
    end
    
    for nr = 1:mnr
	or(nr) = length(find(rr <= (nr+1))) / (ns * nimages) * 100;
    end
    sort(or);
    ormax = mean(or(85:end));
end

%cette fonction effectue le classement des images pertinentes en fonction des ensembles de caractéristiques spécifiés, des méthodes de normalisation et des métriques de distance. Le classement est effectué pour chaque image de requête, et les résultats sont stockés dans la matrice rr.
