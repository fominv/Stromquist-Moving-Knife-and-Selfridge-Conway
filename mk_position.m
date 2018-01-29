function [pos_left, pos_middle, pos_right] = mk_position(half_points)
%RECIEVED_PIECE: Calculates the current position among the players

player_halfs(1,:) = half_points;
player_halfs(2,:) = linspace(1,3,3);

% Use the sortrows to determine the ranking

player_halfs = transpose(player_halfs);

player_halfs = sortrows(player_halfs);

player_halfs = transpose(player_halfs);

pos_left = player_halfs(2,1);
pos_middle = player_halfs(2,2);
pos_right = player_halfs(2,3);

end

