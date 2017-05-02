%% Raised Cosine Function
function rc= rcos(M,roll, duty)
% This function creates the shaping pulse, employed to make the PRBS signal
% more real. In our case we have choosen a raised cosine as shaping pulse.
    %% PARAMETERS
    N = 2048;                               % lenght of the symbol-pat sequence
    Rsymb= 10e9;                            % symbol rate [bits/s]

    % Shaping pulse over 2 bit times because the roll-off spreads de pulses.
    shpulse=zeros(M*2,1);                      
    
    % Start index of cos roll-off
    nl=round(0.5*(1-roll)*duty*M);              
    
    % End index of cos roll-off
    nr=duty*M-nl-1;                              
    
    % Index is where the pulse is 1
    nmark = 1:nl;                               
    
    % Transition region of cos roll-off
    ncos  = nl:nr;                              
    shpulse(M+nmark) = 1;
    hperiod = duty*M-2*nl;
    
    
    if hperiod ~= 0
        shpulse(ncos+M+1) = 0.5*(1+cos(pi/(hperiod)*(ncos-nl+0.5)));
    end
    shpulse(1:M) = flipud(shpulse(M+1:M*2));  % first half of the pulse

rc=shpulse;