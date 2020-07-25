function [spline_steps] = ip_spline_stepping(spline, steps)
%SPLINE_STEPPING: Transforms the continuous spline into a step function
%represented by an array

spline_steps = zeros(1,steps);
epsilon = 1 / steps;

for i = 0:steps-1
    spline_steps(i+1) = ppval(spline,(i * epsilon + (i+1) * epsilon) / 2);
end

end

