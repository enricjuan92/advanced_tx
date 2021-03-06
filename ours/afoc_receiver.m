function afoc_receiver(m, Eoutiq)
%RECEIVER

modord = m;

global GSTATE;
%Eoutiq is the signal after ideal optoelectronic conversion. It has Nsymb
%symbols with Nt samples per symbol (Eoutiq => COMPLEX VECTOR WITH NSYMB*NT
%ELEMENTS)


Eoutiq_att = 10^-6*Eoutiq;
Eoa_real = real(Eoutiq_att);
Eoa_imag = imag(Eoutiq_att);

%Obtain the limits of the decision regions (square decision regions)
lvls_I = get_levels(real(Eoutiq_att), modord);
lvls_Q = get_levels(imag(Eoutiq_att), modord);

GSTATE.LEVELS_I=lvls_I;
GSTATE.LEVELS_Q=lvls_Q;
%Obtain the detected symbols without noise (Edet =>VECTOR WITH NSYM COMPLEX
%COMPONENTS)
j = 0;
for i=1:GSTATE.NT:size(Eoutiq_att,1)
    j = j+1;
    Edet_real(j) = Eoa_real(i);
    Edet_imag(j) = Eoa_imag(i);
end
Edet = Edet_real+1i*Edet_imag;

GSTATE.EDET= Edet;


%Obtain the noisy symbols of Eoutiq (Enoisy => VECTOR WITH NSYM COMPLEX
%NOISY SYMBOLS)
Enoisy = noisy_detector(Eoutiq_att);
GSTATE.ENOISY=Enoisy;


%Use Edet, Enoisy, lvls_I and lvls_Q to obtain BER
GSTATE.BER = BEREstimator(Edet, Enoisy, lvls_I, lvls_Q);
