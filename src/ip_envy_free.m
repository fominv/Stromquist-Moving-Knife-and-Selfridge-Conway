function [envy_free, integrals] = ip_envy_free(splines, P1_piece, P2_piece, P3_piece, steps)
%IP_ENVY_FREE: Checks wether a given solution is envy-free

% Compute the integrals

integrals = zeros(3,3);

for i=1:3
    integrals(i,1) = ip_int_indices(splines(i),P1_piece,steps);
    integrals(i,2) = ip_int_indices(splines(i),P2_piece,steps);
    integrals(i,3) = ip_int_indices(splines(i),P3_piece,steps);
end

% Check wether they are truly envy-free

[~, max_index_1] = max(integrals(1,:));
[~, max_index_2] = max(integrals(2,:));
[~, max_index_3] = max(integrals(3,:));

if isequal([max_index_1, max_index_2, max_index_3], [1, 2, 3])
    envy_free = true;
else
    envy_free = false;
end

end

