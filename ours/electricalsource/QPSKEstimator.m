function [estimated,estimated_stars] = QPSKEstimator(input,samplesPerSymbol)
% This function makes a symbol estimation of the received symbol.

% Creation of a vector twice larger than the input vector to save the
% pattern symbols.
estimated = zeros(1,length(input)*2);
% Creation of a vector with the same length than the input vector to save
% the stars symbols.
estimated_stars=zeros(1,length(input));

% Initialization k parameter that scrolls the estimated vector
k=1;

% Normalization of the input vector
divided=input/samplesPerSymbol ;

% Vector with the real and imaginary values of each symbol.
symbolValues=[1;1*i;-1*i;-1];

for m=1:length(divided)
    % Calculation of the distance between the points that mark the received
    % symbols and the original points. The original symbol that be closer 
    %  to the received symbol (minimum distance) will be the estimated
    %  symbol.
    [difference , position] = min (sqrt((real(symbolValues)-real(divided(m))).^2+(imag(symbolValues)-imag(divided(m))).^2));
    switch position 
        case 1
        estimated(k:k+1) = [0 0];
        k=k+2; 
        estimated_stars(m) = 1;
        case 2
        estimated(k:k+1) = [0 1];
        k=k+2;
        estimated_stars(m) = 1*i;
        case 3
        estimated(k:k+1) = [1 0];
        k=k+2;
        estimated_stars(m) = -1*i;
        case 4
        estimated(k:k+1) = [1 1];
        k=k+2;
        estimated_stars(m) = -1;
    end
end

% Transposition of the estimate and estimate_stars vectors.
estimated = estimated';
estimated_stars=estimated_stars';
end