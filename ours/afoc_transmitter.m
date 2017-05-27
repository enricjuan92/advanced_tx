function [modulation_order, Eout] = afoc_transmitter(mod,roll)
%BASIC TRANSMITTER SIMULATOR
% clear all;
% close all;

global GSTATE;

%% Configuration parameters
%Simulation parameters
%GSTATE.NSYMB =2^11;
%GSTATE.NT = 2^5;            %PoiGSTATE.NTs per symbol
Nfft = GSTATE.NSYMB*GSTATE.NT;    %PoiGSTATE.NTs of simulation
Nch = 1;            %Number of channels

GSTATE.NCH = Nch;
GSTATE.PRIGSTATE.NT = false;

%First, implemeGSTATE.NT the laser signal
Ppeak = 42.7266;    %Peak power (from ex_01)

symbrate = 10;      %Baud rate [Gbaud]
GSTATE.SRATE = symbrate;
duty = 1;           %Duty Cicle

%Modulator parameters
Vpi = 5;
Vbias = 0;
modulation= 'M-QAM';

switch mod
    case 'QPSK'
        m=4;
        Vpi=1;
    case '16-QAM'
        m=16;
        Vpi=1;
    case '64-QAM'
        m=64;
    case '256-QAM'
        m=256;
end       
  

%% Laser source generation
laser_signal = afoc_lasersource(Ppeak, Nfft);

%% Create the bit pattern and the electrical signal

[elec_i, elec_q] = elec_signal(modulation, m, roll, duty);

j = 0;

GSTATE.elec_i_sampled = zeros(GSTATE.NSYMB,1);
GSTATE.elec_q_sampled = zeros(GSTATE.NSYMB,1);

GSTATE.elec_i = elec_i;
GSTATE.elec_q = elec_q;

for i=1:GSTATE.NT:size(elec_i,1)
    j = j+1;
    GSTATE.elec_i_sampled(j) = elec_i(i);
    GSTATE.elec_q_sampled(j) = elec_q(i);
end

 
% Plot Electrical signal
points = linspace(1, length(elec_i), length(elec_i));



%Plot electrical complex constellation
% Preprocessing
levels = get_levels(elec_i, m);
[index_i_resize, index_q_resize] = isignal_reshape(elec_i, elec_q, 25);


%% IQ Modulation by means of a MZM 
Eoutiq = afoc_iqmod(laser_signal, elec_i, elec_q, Vpi, Vbias);

GSTATE.Eoutiq = Eoutiq;
j = 0;

GSTATE.Eout_i_sampled = zeros(GSTATE.NSYMB,1);
GSTATE.Eout_q_sampled = zeros(GSTATE.NSYMB,1);

for i=1:GSTATE.NT:size(elec_i,1)
    j = j+1;
    GSTATE.Eout_i_sampled(j) = real(Eoutiq(i));
    GSTATE.Eout_q_sampled(j) = imag(Eoutiq(i));
end



% Plot Optical Constellation
% Preprocessing
Eout_i = real(Eoutiq);
Eout_q = imag(Eoutiq);

[index_i_resize, index_q_resize] = isignal_reshape(Eout_i, Eout_q, 25);


%saveas(gcf, strcat('Results/',modulation, '_', 'Optical_constellation.png'));

GSTATE.Eout = Eoutiq;
GSTATE.modulation_order = m;
