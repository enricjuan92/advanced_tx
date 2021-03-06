function [Enoisy_det] = noisy_detector(Ein)

%Ein => Received signal after optoelectric conversion


global GSTATE
%Ein_att= (10^-6)*Ein;
thNoise = comm.ThermalNoise('NoiseTemperature',290,'SampleRate',10e6);
Ein_noisy = thNoise(Ein);

Ein_real = real(Ein_noisy);
Ein_imag = imag(Ein_noisy);

j = 0;

for i=1:GSTATE.NT:size(Ein,1)
    j = j+1;
    Enoisy_det_real(j) = Ein_real(i);
    Enoisy_det_imag(j) = Ein_imag(i);
end

Enoisy_det = Enoisy_det_real + 1i*Enoisy_det_imag;

end

