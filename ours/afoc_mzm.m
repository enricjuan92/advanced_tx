function Eout = afoc_mzm(Vpi, Vbias, elec, Ein)

V_u = elec/2;
V_l = -elec/2;

Ph_u = pi*(V_u-Vbias)/Vpi;
Ph_l = pi*(V_l+Vbias)/Vpi;


Eout = -1i*Ein.*0.5.*(exp(1i*Ph_u) - exp(1i*Ph_l));
%Eout = 2i./((exp(1i*Eout_p) - exp(1i*(-Eout_p))));
%Eout = Ein.*asin(0.5*(Ph_u-Ph_l)).*exp(1i*(0.5*(Ph_u+Ph_l)));
%Eout = asin(Eout_p);


