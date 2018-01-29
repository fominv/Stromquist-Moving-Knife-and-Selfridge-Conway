function [P1_pieces, P2_pieces, P3_pieces] = sc_selfridge_conway(splines, steps)
%SC_SELFRIDGE_CONWAY: Divides the cake according to Selfridge-Conway

% Interpolating splines to step functions

spline_steps = zeros(3,steps);

for i = 1:3
    spline_steps(i,:) = ip_spline_stepping(splines(i), steps);
end

% Player 1 divides cake into 3 equal parts

thirds = sc_divide_thirds(spline_steps(1,:), steps);

piece_indices(1,1:thirds(1)) = 1:thirds(1);
piece_indices(2,thirds(1)+1:thirds(2)) = thirds(1)+1:thirds(2); 
piece_indices(3,thirds(2)+1:steps) = thirds(2)+1:steps; 

% Define a ranking of the pieces according to player 2

P2_ranking = sc_sort_pieces(spline_steps(2,:), piece_indices);

% Name the biggest piece according to player 2 A and the second biggest
% B as well as the leftover piece C

A = piece_indices(P2_ranking(3),find(piece_indices(P2_ranking(3),:)));
B = piece_indices(P2_ranking(2),find(piece_indices(P2_ranking(2),:)));
C = piece_indices(P2_ranking(1),find(piece_indices(P2_ranking(1),:)));


% Player 2 trimms piece A such that it matches the second largest

[A_trimmed, A_trimmings, B] = sc_make_same(spline_steps(2,:), A, B);

% Player 3 chooses the biggest piece of A_trimmed, B, C

piece_indices = [];

piece_indices(1,A_trimmed) = A_trimmed;
piece_indices(2,B) = B;
piece_indices(3,C) = C;

P3_ranking = sc_sort_pieces(spline_steps(3,:), piece_indices);

P3_piece = piece_indices(P3_ranking(end),find(piece_indices(P3_ranking(end),:)));

% Find the trimmed piece index to find out if player 3 chose it

A_trimmed_index = find(P3_ranking == 1);

% Player 2 chooses with the restriction that if P3 did not choose A_trimmed
% then he must choose the A_trimmed

if P3_ranking(end) ~= P3_ranking(A_trimmed_index)
    P2_piece = A_trimmed;
    
    piece_indices([P3_ranking(end), P3_ranking(A_trimmed_index)],:) = [];
    
    P_trimmed = 2;
    P_not_trimmed = 3;
else
    P2_piece = B;
    
    B_index = find(P3_ranking == 2);
    
    piece_indices([P3_ranking(end), P3_ranking(B_index)],:) = [];
    
    P_trimmed = 3;
    P_not_trimmed = 2;
end

% Player one chooses the leftover piece

P1_piece = piece_indices(1,find(piece_indices(1,:)));

% If the trimmings are too small we discard them

if length(A_trimmings) <= 3
    P1_pieces = P1_piece;
    P2_pieces = P2_piece;
    P3_pieces = P3_piece;
    return
end


% Divide the trimmings

% The player who did not choose A_trimmed divides the trimmings into three
% equal pieces

thirds = sc_divide_thirds(spline_steps(P_not_trimmed,A_trimmings), steps);

piece_indices = [];

A_trimmings_index = A_trimmings(1)-1;

piece_indices(1,A_trimmings_index+1:A_trimmings_index+thirds(1)) = A_trimmings(1:thirds(1));
piece_indices(2,A_trimmings_index+thirds(1)+1:A_trimmings_index+thirds(2)) = A_trimmings(thirds(1)+1:thirds(2));
piece_indices(3,A_trimmings_index+thirds(2)+1:A_trimmings_index+length(A_trimmings)) = A_trimmings(thirds(2)+1:length(A_trimmings));

% The player with the trimmed piece chooses a piece

P_trimmed_ranking = sc_sort_pieces(spline_steps(P_trimmed,:), piece_indices);

P_trimmed_additional_piece = piece_indices(P_trimmed_ranking(end),:);

% Player one chooses a piece

piece_indices(P_trimmed_ranking(end),:) = [];

P1_ranking = sc_sort_pieces(spline_steps(1,:), piece_indices);

P1_additional_piece = piece_indices(P1_ranking(end),:);

% Last player who chose untrimmed piece obtains remaining piece

piece_indices(P1_ranking(end),:) = [];

P_untrimmed_additional_piece = piece_indices(1,:);


% Combine all pieces, sort the indices and delete zeros

P1_pieces = [P1_piece, P1_additional_piece];
zero_indices = find(P1_pieces == 0);
if ~isempty(zero_indices)
    P1_pieces(zero_indices) = [];
end
P1_pieces = sort(P1_pieces);

if P_trimmed == 2

    P2_pieces = [P2_piece, P_trimmed_additional_piece];
    zero_indices = find(P2_pieces == 0);
    if ~isempty(zero_indices)
        P2_pieces(zero_indices) = [];
    end
    P2_pieces = sort(P2_pieces);
    
    P3_pieces = [P3_piece, P_untrimmed_additional_piece];
    zero_indices = find(P3_pieces == 0);
    if ~isempty(zero_indices)
        P3_pieces(zero_indices) = [];
    end
    P3_pieces = sort(P3_pieces);
        
else
    
    P2_pieces = [P2_piece, P_untrimmed_additional_piece];
    zero_indices = find(P2_pieces == 0);
    if ~isempty(zero_indices)
        P2_pieces(zero_indices) = [];
    end
    P2_pieces = sort(P2_pieces);
    
    P3_pieces = [P3_piece, P_trimmed_additional_piece];
    zero_indices = find(P3_pieces == 0);
    if ~isempty(zero_indices)
        P3_pieces(zero_indices) = [];
    end
    P3_pieces = sort(P3_pieces);
    
end

end

