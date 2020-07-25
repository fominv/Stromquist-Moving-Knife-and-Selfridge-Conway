function [sorted_piece_indices, values] = sc_sort_pieces(spline_steps, piece_indices)
%SC_SORT_PIECES: Sorts the pieces according to player preferences

number_of_pieces = size(piece_indices,1);
steps = length(spline_steps);

evaluations = zeros(2,number_of_pieces);

for i = 1:number_of_pieces
    
    %clear from zeros
    non_zeros = find(piece_indices(i,:));
    
    evaluations(1,i) = ip_int_steps(spline_steps(piece_indices(i, non_zeros)), steps);
end

evaluations(2,:) = 1:number_of_pieces;

evaluations = transpose(evaluations);
evaluations = sortrows(evaluations);
evaluations = transpose(evaluations);

sorted_piece_indices = evaluations(2,:);
values = evaluations(1,:);

end

