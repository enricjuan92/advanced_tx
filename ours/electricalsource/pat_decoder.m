function pat_dec = pat_decoder (pat,mod,options)
% This function decodes the received signal. In our case we have used it as
% an error source, i.e., considering that there is a bad decoding there will
% be a high number of error and a bad BER. 
% The decoder just will be a good function to implement if at the transmitter
% there is an encoder.

if nargin > 2 && isfield(options,'binary')
    binary = options.binary;
else
    binary = false;
end


switch mod
    % 
    case 'dpsk' % differential coding.
        stars_t = pat2stars(pat,'dpsk');
        stars_r=zeros(size(stars_t));
        stars_r=conj(stars_t).*fastshift(stars_t,1);
        pat = ~stars2pat(stars_r,'dpsk');
    case 'dqpsk'
        % In case of have a binary qpsk the symbols are converted from
        % pattern to stars and they are decoded as indicates below.
        if binary
            stars_t = pat2stars(pat,'dqpsk',struct('binary',binary));
        else
            stars_t = pat2stars(pat,'dqpsk');
        end
        % Decoding of received vector
        stars_r=zeros(size(stars_t));
        stars_r=conj(stars_t).*fastshift(stars_t,1);
        figure(5)
        stem(real(stars_r),imag(stars_r));
        
        % Once the symbols vector has been decoded, the symbols are
        % converted to pattern --> pat (0, 1, 2, 3) and patmat ([0 0],  [0 1],
        %[1 0], [1 1]). Finally, the pattern is inverted.
        [pat patmat] = stars2pat(stars_r,'dqpsk')
        patmat=~patmat;     % both pattern have to be inverted
        pat=3-pat;
        
    otherwise
        error('wrong modulation format in pat_decoder');
end

% This function returns the symbols as (0, 1, 2 and 3)
pat_dec= pat;
end