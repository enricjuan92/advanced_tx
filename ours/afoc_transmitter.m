%function [modulation_order, Eout] = afoc_transmitter()
%BASIC TRANSMITTER SIMULATOR
clear all;
close all;

global GSTATE;

%% Configuration parameters
%Simulation parameters
Nsymb = 2^15;         %Number of symbols
Nt = 2^5;            %Points per symbol
Nfft = Nsymb*Nt;    %Points of simulation
Nch = 1;            %Number of channels

GSTATE.NSYMB = Nsymb;
GSTATE.NT = Nt;
GSTATE.NCH = Nch;
GSTATE.PRINT = false;

%First, implement the laser signal
Ppeak = 42.7266;    %Peak power (from ex_01)

symbrate = 10;      %Baud rate [Gbaud]
GSTATE.SRATE = symbrate;
duty = 1;           %Duty Cicle
roll = 0;         %pulse roll-off

%Modulator parameters
Vpi = 5;
Vbias = 0;
%modulation = 'ook';
%modulation = 'bpsk';
%modulation = 'qpsk';
modulation = 'M-QAM';
m=64;

%% Laser source generation
%Nfft = Nfft/(log2(m)/2);
laser_signal = afoc_lasersource(Ppeak, Nfft);

%% Create the bit pattern and the electrical signal

[elec_i, elec_q] = elec_signal(modulation, m, roll, duty);

% Plot Electrical signal
points = linspace(1, length(elec_i), length(elec_i));

figure;
plot(points, elec_i, points, elec_q);
title('Electrical Signals');
legend('Electrical Signal (I-Branch)', 'Electrical Signal (Q-Branch)');
%saveas(gcf, strcat('Results/',modulation, '_', 'electrical_signals.png'));

%Plot electrical complex constellation
% Preprocessing
levels = get_levels(elec_i, m);
[index_i_resize, index_q_resize] = isignal_reshape(elec_i, elec_q, 25);

figure;
plot(elec_i, elec_q, '*r');
hold on;
plot(elec_i(index_i_resize), elec_q(index_q_resize), '*b', 'LineWidth', 2);
for i=1:length(levels)
    hold on;
    plot(ones(length(levels)*2+1)*levels(i), -length(levels):length(levels), 'r--')
end

for i=1:length(levels)
    hold on;
    plot(-length(levels):length(levels), ones(length(levels)*2+1)*levels(i), 'r--')
end

ax=gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
axis([-13.5 13.5 -13.5 13.5]);
title('Electrical constellation');
hold off;
%saveas(gcf, strcat('Results/',modulation, '_', 'electrical_constellation.png'));

%% IQ Modulation by means of a MZM 
Eoutiq = afoc_iqmod(laser_signal, elec_i, elec_q, Vpi, Vbias);

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
%saveas(gcf, strcat('Results/',modulation, '_', 'IQ_Modulator_output.png'));

% Plot Optical Constellation (Optilux)
% Preprocessing
Eout_i = real(Eoutiq);
Eout_q = imag(Eoutiq);

[index_i_resize, index_q_resize] = isignal_reshape(Eout_i, Eout_q, 25);

figure;
plot(Eout_i, Eout_q, '*g');
hold on;
plot(Eout_i(index_i_resize), Eout_q(index_q_resize), '*r', 'LineWidth', 2);
title('Optical constellation')
hold off;
%saveas(gcf, strcat('Results/',modulation, '_', 'Optical_constellation.png'));

Eout = Eoutiq;
modulation_order = m;

%% Comparing results with Optilux toolbox
% Eoptilux = qi_modulator(laser_signal, elec_i, elec_q);

% Plot IQ modulated signal: AFOC vs. Optilux
% figure;
% plot(points, Eoptilux, points, Eoutiq);
% title('Transmissor Ouptut: AFOC vs. Optilux')
% legend('Optilux','Afoc IQ')
%saveas(gcf, strcat('Results/',modulation, '_', 'Transmissor_comparison.png'));
% Podríamos normalizar las señales, restarlas y plotar la diferencia 

% Plot Optical Constellation (Optilux)
% Preprocessing
% Eoptilux_i = real(Eoptilux);
% Eoptilux_q = imag(Eoptilux);
% 
% [index_i_resize, index_q_resize] = isignal_reshape(Eoptilux_i, Eoptilux_q, 25);
% 
% figure;
% plot(Eoptilux_i, Eoptilux_q, '*g');
% hold on;
% plot(Eoptilux_i(index_i_resize), Eoptilux_q(index_q_resize), '*r', 'LineWidth', 2);
% title('Optical constellation (Optilux)')
% hold off;
%saveas(gcf, strcat('Results/',modulation, '_', 'Optical_constellation_optilux.png'));

% Plot Optical Constellation animation (AFOC)
%animated_plot(Eoutiq, 'Optical constellation Animation (AFOC)', [-8 8 -8 8]);

% length(find(abs(Eoutiq)>6))/length(Eoutiq) *100