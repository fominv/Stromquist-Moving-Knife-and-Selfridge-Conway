function [thirds] = sc_divide_thirds(spline_steps, steps)
%SC_DIVIDE_THIRDS: Divides interval into thirds according to value function

epsilon = 1 / steps;
integral_third_1 = sum(spline_steps * epsilon) / 3;
integral_third_2 = sum(spline_steps * epsilon) * 2 / 3;
current_integral = spline_steps(1) * epsilon;

% Finding the first third

i = 1;

while current_integral < integral_third_1 && length(spline_steps) > i
    i = i + 1;
    current_integral = current_integral + spline_steps(i) * epsilon;
end

thirds(1)= i;

% Finding the second third

j = 1;

while current_integral < integral_third_2 && length(spline_steps) > j+i
    j = j + 1;
    current_integral = current_integral + spline_steps(j+i) * epsilon;
end

thirds(2)= j + i;

end

