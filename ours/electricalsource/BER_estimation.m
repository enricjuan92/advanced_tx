function [BER,totalErrors]= BER_estimation(txvector,estimated)
% This function computes the Bit Error Rate of the received signal.

% Computation of the difference vector between the transmitted and
% the estimated vectors.
difference= txvector-estimated;

% Initialization of the total errors
totalErrors=0;

% Dectection the number of errors in the difference vector.
for i=1:length(difference);
	if difference(i)~=0;
    	totalErrors=totalErrors+1;
	end
end

% Calculation of the Bit Error Rate
BER=totalErrors/(2*length(txvector));
end