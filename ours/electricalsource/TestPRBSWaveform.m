
clear all;
close all;
clc;

%% PARAMETERS

%%%%%%%%%%%%%%%%% Transmitter %%%%%%%%%%%%%%%%%
N = 2048;                         % Lenght of the symbol-pat sequence
M = 16;                           % Points per symbol
Rsymb= 10e9;                      % Symbol rate [bits/s]
rolloff = 0.5;                    % Roll-off factor
duty = 1;                         % Duty cycle

%% TRANSMITTER

%Creation of the PRBS vectors
vector1 = pattern('random');
vector2 = pattern('random');

%Creation of the electric signal for in-phase and quadrature components
signal_i = electricsignal(vector1,'qpsk',Rsymb,rolloff,duty);
signal_q = electricsignal(vector2,'qpsk',Rsymb,rolloff,duty);

% Representation of in-phase and quadrature electric signals.
figure(1)
plot(signal_i)

figure(2)
plot(signal_q)

%% RECEIVER

% We are assuming that at the receiver we have the same values that we have
% transmit.
tx_pat = [vector1 vector2];

% This function converts the pattern symbol [0 0], [0 1], [1 0], [1 1] to
% stars symbols 1, i, -1 and -i taking into account that we are working 
% with a qpsk modulation
tx_pat_stars= pat2stars(tx_pat,'qpsk');

% Despite of we are not in charge of the pattern decoding we have
% implemented it as an error source, which will provide us a large BER.
rx_pat=pat_decoder(tx_pat,'dqpsk',struct('binary',true));

% Representation of the pattern decoding
figure(3)
plot(rx_pat)

% This function converts the pattern symbols to a stars symbols
pat_complex = pat2cmx(rx_pat);

% Estimation of the received code for a QPSK modulation.
[estimated, estimated_s]= QPSKEstimator(pat_complex,M);

% Representation of the estimated signal
plot(estimated)

% This is another way to introduce error to the received channel. In this
% case we can vary how many errors we want introduce to the pattern to make
% some prove with the BER calculation.
tx_pat_err = tx_pat_stars;
numerrors= 2;
tx_pat_err(1:numerrors,1) = ~real(tx_pat_stars(1:numerrors, 1));

% BAD BER due to a bad decoding of the received signal
[BER_bad, Errors_bad] = BER_estimation(tx_pat_stars,pat_complex)

% GOOD BER due to the insertion of few errors in the received signal
[BER_good, Errors_good] = BER_estimation(tx_pat_stars,tx_pat_err)




