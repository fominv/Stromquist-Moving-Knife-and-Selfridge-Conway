function [integral] = ip_int_steps(spline_steps, steps)
%INT_MITTELPUNKTSREGEL: Calculates the intergral according to the mid-point
%rule

epsilon = 1 / steps;
integral = sum(spline_steps * epsilon);

end

