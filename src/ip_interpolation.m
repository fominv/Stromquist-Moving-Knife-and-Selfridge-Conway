function [splines] = ip_interpolation(pointsx, pointsy)
%INTERPOLATION: Returns normalized and integral=1 splines corresponding to
%the points

amount = size(pointsx,1);

% Fitting the splines

for i = 1:amount
    splines(i) = spline(pointsx(i,:),pointsy(i,:));
end


% Prevent that polynomial is smaller than 0 at some point

for i = 1:amount
    
    % Find the minimum extrema of the polynomial
    
    minimum = ip_spline_min_minima(splines(i));
    
    if ~isempty(minimum)
        y_min = minimum(2);
        
        % Check if minimal minima below 0
        
        if y_min < 0
             splines(i).coefs(:,end) = splines(i).coefs(:,end) - y_min;
         end
    end
    
end

% Normalization

for i = 1:amount
    poly = @(x) ppval(splines(i),x);    
    alpha = integral(poly,0,1);
    splines(i).coefs = splines(i).coefs / alpha;
end

end

