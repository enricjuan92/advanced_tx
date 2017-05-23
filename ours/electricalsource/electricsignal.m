
function elec=electricsignal(pat, mod, mod_ord, limits, roll, duty)

global GSTATE 


%% Code

% Creation of a elec vector to save the electrical vector with a size of
% M*Nx1
%elec=zeros(GSTATE.NSYMB*GSTATE.NT,1);

% Selection of the modulation to calculate the electric signal 
switch mod
    case{'bpsk', 'qpsk'}
        % For BPSK and QPSK 0s and 1s from PRBS should be represented from 1
        % to -1 is that the reason by which we have used the expression
        % 2*pat-1.
        elec=shaping(2*pat-1, duty, roll);
        % 16-QAM will be implemented for the final performance.
    case{'M-QAM'}   
        b=log2(mod_ord);
        ll=limits(1);
        ul=limits(2);
        steps_levels=(ul-ll)/(sqrt(mod_ord)-1);
        levels = [ll:steps_levels:ul];
        counter = 0;
        
        for i=1:(b/2):(length(pat)-(b/2)+1)
            counter = counter + 1;
            bin_sym = pat([i:i+((b/2)-1)])';
            dec_sym(counter) = bi2de(fliplr(bin_sym));
        end 
        
        elec_symbols = levels(dec_sym+1);
        elec = shaping(elec_symbols, duty, roll);
            
end
