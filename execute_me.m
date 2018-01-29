% Generate the necessary splines

interpolation_points = 10; % number interpolation points 
sample_size = 600 ; % number of samples or splines
lambda = 1000; % number of quadrature steps 

[pointsx,pointsy] = ip_points_to_interpolate(interpolation_points,sample_size);
splines = ip_interpolation(pointsx,pointsy);


% Pick 3 consecutive splines and choose them as a single problem instance

modulo = mod(sample_size,3);
splines = splines(1:end-modulo);

problem_instances = reshape(1:length(splines),[length(splines)/3, 3]);

% Compute the Solution for one problem instance

[P1_piece_mk, P2_piece_mk, P3_piece_mk] = mk_moving_knife(splines(problem_instances(1,:)), lambda);
[P1_piece_sc, P2_piece_sc, P3_piece_sc] = sc_selfridge_conway(splines(problem_instances(1,:)),lambda);

% We plot one problem instance

x = linspace(0,1,1000);

f = @(x) ppval(splines(problem_instances(1,1)),x);
g = @(x) ppval(splines(problem_instances(1,2)),x);
h = @(x) ppval(splines(problem_instances(1,3)),x);

figure()
hold on
grid on
xlim([0,1])
ylim([-2 4])

plot(x,f(x),'Color',rgb('Crimson'))
plot(x,g(x),'Color',rgb('RoyalBlue'))
plot(x,h(x),'Color',rgb('SpringGreen'))

plot(P1_piece_mk / lambda,ones(1,length(P1_piece_mk)) * -1,'o','Color',rgb('Crimson'))
plot(P2_piece_mk / lambda,ones(1,length(P2_piece_mk)) * -1,'o','Color',rgb('RoyalBlue'))
plot(P3_piece_mk / lambda,ones(1,length(P3_piece_mk)) * -1,'o','Color',rgb('SpringGreen'))

plot(P1_piece_sc / lambda,ones(1,length(P1_piece_sc)) * -1.5,'o','Color',rgb('Crimson'))
plot(P2_piece_sc / lambda,ones(1,length(P2_piece_sc)) * -1.5,'o','Color',rgb('RoyalBlue'))
plot(P3_piece_sc / lambda,ones(1,length(P3_piece_sc)) * -1.5,'o','Color',rgb('SpringGreen'))

leg1 = legend('Player 1','Player 2','Player 3');
set(leg1,'Interpreter','latex')
xlabel('Cake $= [0,1]$','Interpreter','latex')


% Plotting a lot of splines and averaging them out

figure()
hold on
grid on
xlim([0,1])
ylim([0,4])
legend()

for i = 1:sample_size
    k = @(x) ppval(splines(i),x);
    k_x = k(x);
    m(i) = plot(x,k_x);
end

avg_spline = splines(1);

for i = 2:sample_size
    avg_spline.coefs = avg_spline.coefs + splines(i).coefs;
end

avg_spline.coefs = avg_spline.coefs / sample_size;

avg_function = @(x) ppval(avg_spline,x);

m(sample_size + 1) = plot(x,avg_function(x),'x','Color', rgb('Aqua'),'DisplayName','Average');

leg1 = legend(m(end),'Average');
set(leg1,'Interpreter','latex')