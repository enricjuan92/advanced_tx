function Eout = afoc_mzm(Vpi, Vbias, elec, Ein)

V_u = elec/2;
V_l = -elec/2;

Ph_u = pi*(V_u-Vbias)/Vpi;
Ph_l = pi*(V_l+Vbias)/Vpi;


Eout = -1i*Ein.*0.5.*(exp(1i*Ph_u) - exp(1i*Ph_l));

Eout = Eout./max(Eout);
Eout = asin(Eout);

end


