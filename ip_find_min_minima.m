function [minimum] = ip_find_min_minima(coeff,interval)
%FIND_MIN_ROOT: Finds the minimal real root of a polynomial in the interval
%as well its function value if it exists

% First find all extrema of the polynomial

coeff_der = polyder(coeff);
extrema = transpose(roots(coeff_der));

% Delete Complex Roots

extrema_dummy = extrema;
extrema = [];

for i = 1:length(extrema_dummy)
   if imag(extrema_dummy(i)) == 0
       extrema = [extrema extrema_dummy(i)];
   end
end

% Delete All Roots not in interval = [a b]

extrema_dummy = extrema;
extrema = [];

for i = 1:length(extrema_dummy)
   if extrema_dummy(i) > interval(1) && extrema_dummy(i) < interval(2)
       extrema = [extrema extrema_dummy(i)];
   end
end

% If there are no roots left stop

if isempty(extrema)
    minimum = [];
    return
end

% Find minimum of all the remaining roots

poly = @(x) polyval(coeff,x);

[f_min_root, index] = min(poly(extrema));

min_root = extrema(index);

minimum = [min_root, f_min_root];

end

