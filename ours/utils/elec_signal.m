function [signal_i, signal_q] = elec_signal( modulation, ELECS)

global GSTATE;

limit_nseed = GSTATE.NSYMB/4;
nseed_i = randi([0 limit_nseed/2]);
nseed_q = randi([(limit_nseed/2+1) limit_nseed]);

%On-Off Keying (ASK) Modulation
if strcmp(modulation, 'bpsk')       
    
    ELECS.par.alphabet = NaN;
    ELECS.par.limits = NaN;
    
    bitseq_i = pattern('debruijn', nseed_i);
    bitseq_q = pattern('debruijn', nseed_q);
    
elseif strcmp(modulation, 'qpsk')       
    
    ELECS.par.alphabet = NaN;
    ELECS.par.limits = NaN;
    
    bitseq_i = pattern('debruijn', nseed_i);
    bitseq_q = pattern('debruijn', nseed_q);
    
% 16-QAM Modulation
elseif strcmp(modulation, '16qam')
    
    modulation = 'userdef';

    ELECS.par.alphabet = 4;
    ELECS.par.limits = [-1;1];
    
    bitseq_i = pattern('debruijn', nseed_i, ELECS.par);
    bitseq_q = pattern('debruijn', nseed_q, ELECS.par);
    
%OOK
elseif strcmp(modulation, 'ook')
    
    ELECS.par.alphabet = NaN;
    ELECS.par.limits = NaN;
    
    bitseq_i = pattern('debruijn', nseed_i);
    bitseq_q = zeros(GSTATE.NSYMB,1);
    
else
    error('Modulation not supported');
end
        
signal_i = electricsignal(bitseq_i, modulation, ELECS.symbrate, ...
    ELECS.roll, ELECS.duty);
signal_q = electricsignal(bitseq_q, modulation, ELECS.symbrate, ...
    ELECS.roll, ELECS.duty);

% signal_i = electricsource(bitseq_i, modulation, ELECS.symbrate, ...
%     'cosroll', ELECS.duty, ELECS.roll, ELECS.par);
% signal_q = electricsource(bitseq_q, modulation, ELECS.symbrate, ...
%     'cosroll', ELECS.duty, ELECS.roll, ELECS.par);

end