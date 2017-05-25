function [BER] = BEREstimator(E_ideal, E_detected, regs_I, regs_Q)

%E_ideal => Vector con todos los símbolos sin ruido
%E_detected => Vector con todos los símbolos con ruido

incorrect_symb = 0;

reg_dec_noiseless_I = zeros(1, length(E_ideal));
reg_dec_noiseless_Q = zeros(1, length(E_ideal));
reg_dec_noisy_I = zeros(1, length(E_detected));
reg_dec_noisy_Q = zeros(1, length(E_detected));

%LOCATE THE REGIONS OF THE NOISELESS SYMBOLS

for i=1:length(E_ideal) 
    %Get each component of the ith noiseless symbol
    Eideal_I = real(E_ideal(i));
    Eideal_Q = imag(E_ideal(i));
    
    %For each frontier of the I component
    for j=1:length(regs_I)
        %Check if the ideal I component is below that frontier
        if (Eideal_I < regs_I(j))
            %If it is, assign decision region
            reg_dec_noiseless_I(i) = j;
            %For each frontier of the Q component
            for k=1:length(regs_Q)
                %Check if the ideal Q component is below that frontier
                if (Eideal_Q < regs_Q(k))
                    %If it is, assign decision region
                    reg_dec_noiseless_Q(i) = k;
                    break
                end
            end
            %If no decision region has been found for the Q component
            if (reg_dec_noiseless_Q(i) == 0)
                %It is above the last frontier
                reg_dec_noiseless_Q(i) = length(regs_Q)+1;
            end
            break
        end
    end
    %If no decision region has been found for the I component
    if (reg_dec_noiseless_I(i) == 0)
        %It is above the last one
        reg_dec_noiseless_I(i) = length(regs_I)+1;
        %Same proocedure to find Q component region
        for k=1:length(regs_Q)
            if (Eideal_Q < regs_Q(k))
                reg_dec_noiseless_Q(i) = k;
                break;
            end
        end
        if (reg_dec_noiseless_Q(i) == 0)
            reg_dec_noiseless_Q(i) = length(regs_Q)+1;
        end
    end
end

%LOCATE THE REGIONS OF THE NOISY SYMBOLS

for i=1:length(E_detected)
    %Get each component of the ith noisy symbol
    Edetected_I = real(E_detected(i));
    Edetected_Q = imag(E_detected(i));
    
    %For each frontier of the I component
    for j=1:length(regs_I)
        %Check if the ideal I component is below that frontier
        if (Edetected_I < regs_I(j))
            %If it is, assign decision region
            reg_dec_noisy_I(i) = j;
            %For each frontier of the Q component
            for k=1:length(regs_Q)
                %Check if the ideal Q component is below that frontier
                if (Edetected_Q < regs_Q(k))
                    %If it is, assign decision region
                    reg_dec_noisy_Q(i) = k;
                    break
                end
            end
            %If no decision region has been found for the Q component
            if (reg_dec_noisy_Q(i) == 0)
                %It is above the last frontier
                reg_dec_noisy_Q(i) = length(regs_Q)+1;
            end
            break
        end
    end
    %If no decision region has been found for the I component
    if (reg_dec_noisy_I(i) == 0)
        %It is above the last one
        reg_dec_noisy_I(i) = length(regs_I)+1;
        %Same proocedure to find Q component region
        for k=1:length(regs_Q)
            if (Edetected_Q < regs_Q(k))
                reg_dec_noisy_Q(i) = k;
                break;
            end
        end
        if (reg_dec_noisy_Q(i) == 0)
            reg_dec_noisy_Q(i) = length(regs_Q)+1;
        end
    end
end

%COMPARE THE REGIONS OF EACH SYMBOL

for i=1:length(E_ideal)
    if ((reg_dec_noisy_I(i) ~= reg_dec_noiseless_I(i)) || (reg_dec_noisy_Q(i) ~= reg_dec_noiseless_Q(i)))
        incorrect_symb = incorrect_symb + 1;
    end
end

BER = (incorrect_symb)/length(E_detected);

end
