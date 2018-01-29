function [pointsx, pointsy] = ip_points_to_interpolate(number, amount)
%Points to Interpolate: Returns points to interpolate in respect to
%number and amount

number_of_points = number+2; % +2 for the borders

% Initiating x and y values for all instances

pointsy = zeros(amount,number_of_points);
pointsx = zeros(amount,number_of_points);
pointsx(1,:) = linspace(0,number+1,number+2);
pointsx(1,:) = pointsx(1,:) / (number+1);

for i = 1:amount
    pointsy(i,:) = rand(1,number_of_points);
    pointsx(i,:) = pointsx(1,:);
end

end