function [half] = mk_find_half(spline_steps, steps)
%FIND_HALF: Finds the index of the step right of the value dividing the 
%integral in two

epsilon = 1 / steps;
integral_half = sum(spline_steps * epsilon) / 2;
current_integral = spline_steps(1) * epsilon;

i = 1;

while current_integral < integral_half
    i = i + 1;
    current_integral = current_integral + spline_steps(i) * epsilon;
end

half = i;

end

