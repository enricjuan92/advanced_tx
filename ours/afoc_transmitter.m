%BASIC TRANSMITTER SIMULATOR
clear all;
close all;

global GSTATE;

%Simulation parameters
Nsymb = 64;         %Number of symbols
Nt = 64;            %Points per symbol
Nfft = Nsymb*Nt;    %Points of simulation
Nch = 1;            %Number of channels
GSTATE.NSYMB = Nsymb;
GSTATE.NT = Nt;
GSTATE.NCH = Nch;
GSTATE.PRINT = false;

%First, implement the laser signal
spac = 0.4;         %Channel spacing [mm]
lam = 1550;         %Central wavelength [nm]
Ppeak = 42.7266;    %Peak power (from ex_01)
symbrate = 10;      %Baud rate [Gbaud]
duty = 1;           %Duty Cicle
roll = 0.2;         %pulse roll-off

laser_signal = afoc_lasersource(Ppeak, lam, spac, Nfft);

%Then, create the bit pattern and the electrical signal

%OOK
%seq1 = pattern('random');
%seq2 = pattern('random');

%16QAM
OPTIONS.alphabet = 4;
seq1 = pattern('debruijn', 0, OPTIONS);
seq2 = pattern('debruijn', 1, OPTIONS);

%OOK
% elec_i = electricsource(seq1, 'qpsk', symbrate, 'cosroll', duty, roll);
% elec_q = electricsource(seq2, 'qpsk', symbrate, 'cosroll', duty, roll);
%modsignal = modulationChooser(seq1, 'QPSK');
%elec_i = real(modsignal);
%elec_q = imag(modsignal);

%16QAM
par.alphabet = 4;
par.limits = [-1;1];
elec_i = electricsource(seq1, 'userdef', symbrate, 'cosroll', duty, roll, par);
elec_q = electricsource(seq2, 'userdef', symbrate, 'cosroll', duty, roll, par);


%OOK
[Eoutiq, Eopti, Eoptq] = afoc_iqmod(laser_signal, elec_i, elec_q, 1, 0);
%points = linspace(1, length(modsignal), length(modsignal));
points=linspace(1,4096,4096);
figure;
plot(points, elec_i, points, elec_q);
legend('Electrical Signal (I-Branch)', 'Electrical Signal (Q-Branch)');
figure;
plot(points, Eoutiq);
legend('IQ Modulator output')
figure;
plot(elec_i, elec_q, '*r');
title('Electrical constellation');

%One last step, in order to compare with Optilux results.
Eoptilux = qi_modulator(laser_signal, elec_i, elec_q);
figure;
plot(points, Eoptilux, points, Eoutiq);
legend('Optilux','Afoc IQ')
figure;
plot(real(Eoptilux), imag(Eoptilux), '*g');

% figure;
% plot(real(Eoutiq),imag(Eoutiq),'*');
% title('Optical constellation');

figure;
h=animatedline(real(Eoutiq(1)), imag(Eoutiq(1)), 'LineStyle', 'None', 'Marker', '*', 'Color', 'blue');
axis([-8 8 -8 8]);
for i=2:4096
    addpoints(h, real(Eoutiq(i)), imag(Eoutiq(i)))
    drawnow
end

% length(find(abs(Eoutiq)>6))/length(Eoutiq) *100