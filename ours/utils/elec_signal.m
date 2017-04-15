function [signal_i, signal_q] = elec_signal(modulation, ELECS)

global GSTATE;

%On-Off Keying (ASK) Modulation
if strcmp(modulation, 'qpsk')       
    
    ELECS.par.alphabet = NaN;
    ELECS.par.limits = NaN;
    
    bitseq_i = pattern('random');
    bitseq_q = pattern('random');
    
% 16-QAM Modulation
elseif strcmp(modulation, '16qam')
    
    modulation = 'userdef';

    ELECS.par.alphabet = 4;
    ELECS.par.limits = [-1;1];
    
    bitseq_i = pattern('random', ELECS.par);
    bitseq_q = pattern('random', ELECS.par);
    
%OOK
elseif strcmp(modulation, 'ook')
    
    ELECS.par.alphabet = NaN;
    ELECS.par.limits = NaN;
    
    bitseq_i = pattern('random');
    bitseq_q = zeros(GSTATE.NSYMB,1);
    
else
    error('Modulation not supported');
end
        

signal_i = electricsource(bitseq_i, modulation, ELECS.symbrate, ...
    'cosroll', ELECS.duty, ELECS.roll, ELECS.par);
signal_q = electricsource(bitseq_q, modulation, ELECS.symbrate, ...
    'cosroll', ELECS.duty, ELECS.roll, ELECS.par);

end