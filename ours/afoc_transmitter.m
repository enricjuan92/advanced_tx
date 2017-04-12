%BASIC TRANSMITTER SIMULATOR
clear all;
close all;

global GSTATE;

%% Configuration parameters
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

ELECS.symbrate = 10;      %Baud rate [Gbaud]
ELECS.duty = 1;           %Duty Cicle
ELECS.roll = 0.2;         %pulse roll-off

%% Laser source generation
laser_signal = afoc_lasersource(Ppeak, lam, spac, Nfft);

%% Create the bit pattern and the electrical signal

%[elec_i, elec_q] = elec_signal('ook', ELECS);
[elec_i, elec_q] = elec_signal('16qam', ELECS);

% Plot Electrical signal
points = linspace(1, length(elec_i), length(elec_i));

figure;
plot(points, elec_i, points, elec_q);
title('Electrical Signals');
legend('Electrical Signal (I-Branch)', 'Electrical Signal (Q-Branch)');

%Plot electrical complex constellation
% Preprocessing
[index_i_resize, index_q_resize] = isignal_reshape(elec_i, elec_q, 25);

figure;
plot(elec_i, elec_q, '*r');
hold on;
plot(elec_i(index_i_resize), elec_q(index_q_resize), '*b', 'LineWidth', 2);
title('Electrical constellation');
hold off;

%% IQ Modulation by means of a MZM 
Eoutiq = afoc_iqmod(laser_signal, elec_i, elec_q, 1, 0);

%Plot IQ Modulator output
figure;
subplot(2,2,1)
plot(points, real(Eoutiq));
title('I Modulator output');
subplot(2,2,2)
plot(points, imag(Eoutiq));
title('Q Modulator output');
subplot(2,2,[3 4])
plot(points, Eoutiq);
title('IQ Modulator output');

%% Comparing results with Optilux toolbox
Eoptilux = qi_modulator(laser_signal, elec_i, elec_q);

% Plot IQ modulated signal: AFOC vs. Optilux
figure;
plot(points, Eoptilux, points, Eoutiq);
title('Transmissor Ouptut: AFOC vs. Optilux')
legend('Optilux','Afoc IQ')
% Podr�amos normalizar las se�ales, restarlas y plotar la diferencia 

% Plot Optical Constellation (Optilux)
% Preprocessing
Eoptilux_i = real(Eoptilux);
Eoptilux_q = imag(Eoptilux);

[index_i_resize, index_q_resize] = isignal_reshape(Eoptilux_i, Eoptilux_q, 25);

figure;
plot(Eoptilux_i, Eoptilux_q, '*g');
hold on;
plot(Eoptilux_i(index_i_resize), Eoptilux_q(index_q_resize), '*r', 'LineWidth', 2);
title('Optical constellation (Optilux)')
hold off;

% Plot Optical Constellation animation (AFOC)
animated_plot(Eoutiq, 'Optical constellation Animation (AFOC)', [-8 8 -8 8]);

% length(find(abs(Eoutiq)>6))/length(Eoutiq) *100