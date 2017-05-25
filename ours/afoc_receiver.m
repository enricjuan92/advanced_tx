%function BER = afoc_receiver(m, Eoutiq)
%RECEIVER

modord = m;

%Eoutiq is the signal after ideal optoelectronic conversion. It has Nsymb
%symbols with Nt samples per symbol (Eoutiq => COMPLEX VECTOR WITH NSYMB*NT
%ELEMENTS)
Eoutiq_att = 10^-6*Eoutiq;
Eoa_real = real(Eoutiq_att);
Eoa_imag = imag(Eoutiq_att);

%Obtain the limits of the decision regions (square decision regions)
lvls_I = get_levels(real(Eoutiq_att), modord);
lvls_Q = get_levels(imag(Eoutiq_att), modord);

%Obtain the detected symbols without noise (Edet =>VECTOR WITH NSYM COMPLEX
%COMPONENTS)
j = 0;
for i=(Nt/2):Nt:size(Eoutiq_att,1)
    j = j+1;
    Edet_real(j) = Eoa_real(i);
    Edet_imag(j) = Eoa_imag(i);
end
Edet = Edet_real+1i*Edet_imag;
scatterplot(Edet);
for i=1:length(lvls_I)
    hold on;
    plot(ones(length(lvls_I)*2+1)*lvls_I(i), -length(lvls_I):length(lvls_I), 'r--')
end

for i=1:length(lvls_Q)
    hold on;
    plot(-length(lvls_Q):length(lvls_Q), ones(length(lvls_Q)*2+1)*lvls_Q(i), 'r--')
end

%Obtain the noisy symbols of Eoutiq (Enoisy => VECTOR WITH NSYM COMPLEX
%NOISY SYMBOLS)
Enoisy = noisy_detector(Eoutiq_att);
scatterplot(Enoisy);
for i=1:length(lvls_I)
    hold on;
    plot(ones(length(lvls_I)*2+1)*lvls_I(i), -length(lvls_I):length(lvls_I), 'r--')
end

for i=1:length(lvls_Q)
    hold on;
    plot(-length(lvls_Q):length(lvls_Q), ones(length(lvls_Q)*2+1)*lvls_Q(i), 'r--')
end

%Use Edet, Enoisy, lvls_I and lvls_Q to obtain BER
BER = BEREstimator(Edet, Enoisy, lvls_I, lvls_Q);
