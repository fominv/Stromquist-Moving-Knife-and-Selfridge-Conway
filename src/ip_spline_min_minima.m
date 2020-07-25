function [minimum] = ip_spline_min_minima(spline)
%SPLINE_ROOT: Finds the roots of the spline in the interval [0 1]

breaks = spline.breaks;
coefs = spline.coefs;

% Find the roots in each subinterval

extrema = [];

for i = 1:length(breaks)-1
    
    % The coefficients are regarding [0,breaks(i+1)-breaks(i)], 
    % therefore we need to add the current interval to the minima
    minimum = ip_find_min_minima(coefs(i,:),[0 breaks(i+1)-breaks(i)]);
    
    if ~isempty(minimum)
        extrema(i) = minimum(1) + breaks(i);
    end
end

% Check if there any roots

if isempty(extrema) 
    minimum = [];
    return
end

% If we found some roots, determine the minimal one

poly = @(x) ppval(spline,x);

[f_min_root, index]= min(poly(extrema));

min_root = extrema(index);

minimum = [min_root, f_min_root];

end

