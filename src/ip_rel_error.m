function [rel_error] = ip_rel_error(splines, P1_piece, P2_piece, P3_piece, steps)
%IP_REL_ERROR: Computes the relative error if there is envy

% Compute the integrals

for i=1:3
    integrals(i,1) = ip_int_indices(splines(i),P1_piece,steps);
    integrals(i,2) = ip_int_indices(splines(i),P2_piece,steps);
    integrals(i,3) = ip_int_indices(splines(i),P3_piece,steps);
end

% Find the maximum relative error

max_1 = max(integrals(1,:));
max_2 = max(integrals(2,:));
max_3 = max(integrals(3,:));

rel_error = max([(max_1 - integrals(1,1)) / integrals(1,1), ...
    (max_2 - integrals(2,2)) / integrals(2,2), ...
    (max_3 - integrals(3,3)) / integrals(3,3)]);

end

