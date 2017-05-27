function E_l = afoc_lasersource(Ptx, nfft)

E_l = ones(nfft, 1)*sqrt(Ptx);

% figure;
% plot(E_l);
% title('Laser signal');
