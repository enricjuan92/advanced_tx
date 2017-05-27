function [signal_i, signal_q] = elec_signal(modulation, mod_ord, roll, duty)

global GSTATE;
GSTATE.NSYMB = GSTATE.NSYMB*(log2(mod_ord)/2);

limit_nseed = GSTATE.NSYMB/4;
nseed_i = randi([0 limit_nseed/2]);
nseed_q = randi([(limit_nseed/2+1) limit_nseed]);

%Binary Phase-Shift Keying (BPSK) Modulation
if strcmp(modulation, 'bpsk')       
    
    %bitseq_i = pattern('debruijn', nseed_i);
    %bitseq_q = pattern('debruijn', nseed_q);
    bitseq_i = pattern('random');
    bitseq_q = pattern('random');
    lims = [-10 10];
    
elseif strcmp(modulation, 'qpsk')       
    
    %bitseq_i = pattern('debruijn', nseed_i);
    %bitseq_q = pattern('debruijn', nseed_q);
    bitseq_i = pattern('random');
    bitseq_q = pattern('random');
    lims = [-1 1];
    
% 16-QAM Modulation
elseif strcmp(modulation, 'M-QAM')
    
    %bitseq_i = pattern('debruijn', nseed_i);
    %bitseq_q = pattern('debruijn', nseed_q);
    bitseq_i = pattern('random');
    bitseq_q = pattern('random');
    if mod_ord == 16
        lims = [-0.5 0.5];
    else 
        lims=[-5 5];
    end
%OOK
elseif strcmp(modulation, 'ook')
    
    %bitseq_i = pattern('random', nseed_i);
    %bitseq_q = zeros(GSTATE.NSYMB,1);
    bitseq_i = pattern('random');
    bitseq_q = zeros(GSTATE.NSYMB,1);
    lims = [-10 10];
    
else
    error('Modulation not supported');
end

GSTATE.NSYMB = GSTATE.NSYMB*2/log2(mod_ord);
        
signal_i = electricsignal(bitseq_i, modulation, mod_ord, lims, ...
    roll, duty);
signal_q = electricsignal(bitseq_q, modulation, mod_ord, lims, ...
    roll, duty);


end