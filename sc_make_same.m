function [A_trimmed, A_trimmings, B] = sc_make_same(spline_steps, A, B)
%SC_MAKE_SAME: We trimm piece A so that it matches piece B

%clear from zeros

B = B(find(B));
A = A(find(A));

steps = size(spline_steps,2);
epsilon = 1 / steps;

integral_B = sum(spline_steps(B) * epsilon);
current_integral_A = spline_steps(A(1)) * epsilon;


for i = 1:length(A)-1
    if(current_integral_A >= integral_B)
        break
    end
    current_integral_A = current_integral_A + spline_steps(A(1)+i) * epsilon;
end

A_trimmed = A(1:i);
A_trimmings = A(i+1:end);

end

