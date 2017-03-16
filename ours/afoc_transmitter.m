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
seq1 = pattern('random');
seq2 = pattern('random');

elec_i = electricsource(seq1, 'ook', symbrate, 'cosroll', duty, roll);
elec_q = electricsource(seq2, 'ook', symbrate, 'cosroll', duty, roll);

Eoutiq = afoc_iqmod(laser_signal, elec_i, elec_q, 1, 0);
points=linspace(1,4096,4096);
figure;
plot(points, elec_i, points, elec_q);
legend('Electrical Signal (I-Branch)', 'Electrical Signal (Q-Branch)');
figure;
plot(points, Eoutiq);
legend('IQ Modulator output')