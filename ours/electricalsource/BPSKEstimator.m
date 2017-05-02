
function estimated = BPSKEstimator(input , samplesPerSymbol)

estimated = zeros(size(input));
divided=input/samplesPerSymbol;

for i=1:length(divided) 
    if divided(i) > 0
        estimated(i) = 1;
    else
        estimated(i) = 0;
    end
end
end