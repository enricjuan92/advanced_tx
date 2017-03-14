function Eout_iq = afoc_iqmod(Ein, elec1, elec2, Vpi, Vbias)

Ein_i = 0.5*Ein;
Ein_q = 0.5*Ein;

Eout_i = afoc_mzm(Vpi, Vbias, elec1, Ein_i);
Eout_q = afoc_mzm(Vpi, Vbias, elec2, Ein_q);

Eout_iq = 2*(Eout_i + Eout_q*exp(1i*(pi/2)));