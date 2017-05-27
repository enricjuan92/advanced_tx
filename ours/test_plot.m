global GSTATE;


t = linspace(0, length(GSTATE.EMZM_i), length(GSTATE.EMZM_i));

figure(1)
%plot3(t, Eout_i, Eout_q, 'LineWidth',2)
hold on
plot3(t, GSTATE.EMZM_i, zeros(size(t)))
plot3(t, zeros(size(t)), GSTATE.EMZM_q)
hold off
grid on
axis([0  10e3    -6  6    -6  6])
%view([-100  100])
% xlabel('Time', 'Rotation', -)
% ylabel('Real Axis', 'Rotation')
% zlabel('Imag Axis')