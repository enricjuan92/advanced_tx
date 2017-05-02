function [Eout_iq, Eout_i, Eout_q] = afoc_iqmod(Ein, elec1, elec2, Vpi, Vbias)

Ein_i = 0.5*Ein;
Ein_q = 0.5*Ein;

Eout_i = afoc_mzm(Vpi, Vbias, elec1, Ein_i);
Eout_q = afoc_mzm(Vpi, Vbias, elec2, Ein_q);

%modulation = 'ook';

points=linspace(1, length(Eout_i), length(Eout_i));
figure;
plot(points, Eout_i, points, Eout_q);
title('MZM Output (IQ)');
legend('MZM Output (I-Branch)', 'MZM Output (Q-Branch)');
%saveas(gcf, strcat('Results/',modulation, '_', 'MZM_output.png'));

Eout_iq = 2*(Eout_i + 1i*Eout_q);

end