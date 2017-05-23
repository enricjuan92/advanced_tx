function [E_real_det, E_imag_det] = detector(Ein)

%Ein => Received signal after optoelectric conversion

Ein_att= (10^-6)*Ein;
thNoise = comm.ThermalNoise('NoiseTemperature',290,'SampleRate',10e6);
Ein_noisy = thNoise(Ein_att);
scatterplot(Ein_noisy)

Ein_real = real(Ein_noisy);
Ein_imag = imag(Ein_noisy);

Nt = 2^5;

j = 0;

for i=(Nt/2):Nt:size(Ein,1)
    j = j+1;
    E_real_det(j) = Ein_real(i);
    E_imag_det(j) = Ein_imag(i);
end

E_det = E_real_det + 1i*E_imag_det;
scatterplot(E_det);

%Contar errores
end

