function [int] = ip_int_indices(spline, indices, steps)
%IP_INT_INDICES: Computes the integral according to some spline, step size
%and indices of some piece

f = @(x) ppval(spline,x);

epsilon = 1 / steps;

for i = 1:length(indices)
    subintervals(i,:) = [(indices(i) - 1) * epsilon, indices(i) * epsilon];
end

int = 0;

for j = 1:size(subintervals,1)
    int = int + integral(f,subintervals(j,1),subintervals(j,2));
end

end