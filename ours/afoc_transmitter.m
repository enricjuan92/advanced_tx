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
roll = 0.1;         %pulse roll-off

laser_signal = afoc_lasersource(Ppeak, lam, spac, Nfft);

%Then, create the bit pattern and the electrical signal

%Seguir aquí. Lo último es que ahora tenemos cuatro secuencias
%de bits con la 16QAM.

%OOK!!!___
%seq1 = pattern('random');
%seq2 = pattern('random');

%16QAM!!!___
OPTIONS.alphabet=16;
[PAT,BMAT] = pattern('random',OPTIONS);

%OOK!!!___
%elec_i = electricsource(seq1, 'qpsk', symbrate, 'cosroll', duty, roll);
%elec_q = electricsource(seq2, 'qpsk', symbrate, 'cosroll', duty, roll);

%16QAM!!!___
elec_i = electricsource(BMAT(:,1), 'qpsk', symbrate, 'cosroll', duty, roll);
elec_q = electricsource(BMAT(:,2), 'qpsk', symbrate, 'cosroll', duty, roll);

%OOK!!!___
%[Eoutiq, Eopti, Eoptq] = afoc_iqmod(laser_signal, elec_i, elec_q, 1, 0);
%16QAM!!!___
[Eoutiq, Eopti, Eoptq] = afoc_iqmod(laser_signal, elec_i, elec_q, 1, 0);
points=linspace(1,4096,4096);
figure;
plot(points, elec_i, points, elec_q);
legend('Electrical Signal (I-Branch)', 'Electrical Signal (Q-Branch)');
figure;
plot(points, Eoutiq);
%plot(Eopti,Eoptq,'.b');
legend('IQ Modulator output')

%One last step, in order to compare with Optilux results.
Eoptilux = qi_modulator(laser_signal, elec_i, elec_q);
figure;
plot(points, Eoptilux, points, Eoutiq);
legend('Optilux','Afoc IQ')

x_axis = linspace(-5,5, length(Eopti));
figure;
%plot(x_axis,Eopti, 'b.')
plot(real(Eoutiq),imag(Eoutiq),'.');