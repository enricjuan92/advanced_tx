
%% Signal Shaping
function shapesig= shaping(pat, duty, roll)
% This function calculates converts the PRBS signal to an electric signal.
%% PARAMETERS
global GSTATE
    N = GSTATE.NSYMB;                               % Lenght of the symbol-pat sequence
    %N = length(pat);
    M = GSTATE.NT;                                 % Points per symbol
    Rsymb= GSTATE.SRATE;                            % Symbol rate [bits/s]
    nfft=N*M;                               % Number of FFT points
    shapesig=zeros(nfft,1);                 % Vector to save electric signal
    
    % This function creates the shaping pulse
    shpulse= rcos(M,roll, duty);                
   
    % Cyclic periodicity: First shaping pulse starts at the end of the sequence
    nstart=nfft-M+1;                            
    nend=nfft;   
    
    % Creation of the shaped signal
    shapesig(nstart:nend)= pat(1)*shpulse(1:M);
    shapesig(1:M)= pat(1)*shpulse(M+1:M*2);
    
    % Creation of the electric signal
    for kbit=2:N
        nstart = (kbit-2)*M+1;
        nend = kbit*M;
        shapesig(nstart:nend) = shapesig(nstart:nend)+pat(kbit)*shpulse; % add the kbit-pulse
    end
end

