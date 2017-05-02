
function elec=electricsignal(pat, mod, Rsymb,roll, duty)

%% PARAMETERS
N = 2048;                               % lenght of the symbol-pat sequence
M = 16;                                 % points per symbol



%% Code

% Creation of a elec vector to save the electrical vector with a size of
% M*Nx1
elec=zeros(M*N,1);

% Selection of the modulation to calculate the electric signal 
switch mod
    case{'bpsk', 'qpsk'}
        % For BPSK and QPSK 0s and 1s from PRBS should be represented from 1
        % to -1 is that the reason by which we have used the expression
        % 2*pat-1.
        elec=shaping(2*pat-1, duty, roll);
        % 16-QAM will be implemented for the final performance.
    case{'MQAM'}   
        % Leer pat cada log2(M)/2 
        print('It has not been implemented yet');
end
