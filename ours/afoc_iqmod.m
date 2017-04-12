function [Eout_iq, Eout_i, Eout_q] = afoc_iqmod(Ein, elec1, elec2, Vpi, Vbias)

Ein_i = 0.5*Ein;
Ein_q = 0.5*Ein;

Eout_i = afoc_mzm(Vpi, Vbias, elec1, Ein_i);
Eout_q = afoc_mzm(Vpi, Vbias, elec2, Ein_q);

%Popt_i = abs(Eout_i).^2;
%Popt_q = abs(Eout_q).^2;

points=linspace(1,4096,4096);
figure;
plot(points, Eout_i, points, Eout_q);
title('MZM Output (IQ)');
legend('MZM Output (I-Branch)', 'MZM Output (Q-Branch)');
%figure;
%plot(points, Popt_i, points, Popt_q);
%legend('Optical Power (I-Branch)','Optical Power (Q-Branch)');

Eout_iq = 2*(Eout_i + 1i*Eout_q);

end