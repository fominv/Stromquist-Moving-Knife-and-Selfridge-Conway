function [P1_piece, P2_piece, P3_piece] = mk_moving_knife(splines, steps)
%Moving_Knife: Calculates the solution according to the stromquist moving 
%knife with steps size epsilon

spline_steps(1,:) = ip_spline_stepping(splines(1), steps);
spline_steps(2,:) = ip_spline_stepping(splines(2), steps);
spline_steps(3,:) = ip_spline_stepping(splines(3), steps);

% Preallocate intervals

intervals = zeros(3,size(spline_steps,2));

for i = 1:steps-1
    halfs(1) = i + mk_find_half(spline_steps(1,i+1:end),steps);
    halfs(2) = i + mk_find_half(spline_steps(2,i+1:end),steps);
    halfs(3) = i + mk_find_half(spline_steps(3,i+1:end),steps);
    
    [left, middle, right] = mk_position(halfs);
    
    left_player_middle_part = ip_int_steps(spline_steps(left,i+1:halfs(middle)), steps);
    left_player_left_part = ip_int_steps(spline_steps(left,1:i), steps);
    
    right_player_right_part = ip_int_steps(spline_steps(right,halfs(middle):end), steps);
    right_player_left_part = ip_int_steps(spline_steps(right,1:i), steps);
    
    middle_player_middle_part = ip_int_steps(spline_steps(middle,i+1:halfs(middle)), steps);
    middle_player_right_part = ip_int_steps(spline_steps(middle,halfs(middle):end), steps);
    middle_player_left_part = ip_int_steps(spline_steps(middle,1:i), steps);
    
    if left_player_middle_part <= left_player_left_part
        intervals(left,1:i) = ones(1,i);
        intervals(middle,i+1:halfs(middle)) = ones(1,halfs(middle) - i);
        intervals(right,halfs(middle)+1:end) = ones(1,size(spline_steps,2) - halfs(middle));
        break
    end
    
    if right_player_right_part <= right_player_left_part
        intervals(right,1:i) = ones(1,i);
        intervals(left,i+1:halfs(middle)) = ones(1,halfs(middle) - i);
        intervals(middle, halfs(middle)+1:end) = ones(1,size(spline_steps,2) - halfs(middle));
        break
    end
    
    if middle_player_middle_part <= middle_player_left_part && middle_player_right_part <= middle_player_left_part
        intervals(middle,1:i) = ones(1,i);
        intervals(left,i+1:halfs(middle)) = ones(1,halfs(middle) - i);
        intervals(right, halfs(middle)+1:end) = ones(1,size(spline_steps,2) - halfs(middle));
        break
    end
        
end

% Transform the output to correct form

indices = linspace(1,size(spline_steps,2),size(spline_steps,2));

intervals(1,:) = intervals(1,:) .* indices;
intervals(2,:) = intervals(2,:) .* indices;
intervals(3,:) = intervals(3,:) .* indices;

% Sort the indices and delete zeros, which are a programming artefact

P1_piece = intervals(1,:);
zero_indices = find(P1_piece == 0);
if ~isempty(zero_indices)
    P1_piece(zero_indices) = [];
end
P1_piece = sort(P1_piece);

P2_piece = intervals(2,:);
zero_indices = find(P2_piece == 0);
if ~isempty(zero_indices)
    P2_piece(zero_indices) = [];
end
P2_piece = sort(P2_piece);

P3_piece = intervals(3,:);
zero_indices = find(P3_piece == 0);
if ~isempty(zero_indices)
    P3_piece(zero_indices) = [];
end
P3_piece = sort(P3_piece);

end

