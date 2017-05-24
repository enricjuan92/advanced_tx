function [BER] = BEREstimator(E_ideal, E_detected, regs_I, regs_Q)

%E_ideal => Vector con todos los símbolos sin ruido
%E_detected => Vector con todos los símbolos con ruido

incorrect_symb = 0;
correct_symb = 0;

for i=1:length(E_ideal)
    E_detected_real = real(E_detected(i));
    E_detected_imag = imag(E_detected(i));
    
    E_ideal_I = real(E_ideal(i));
    E_ideal_Q = imag(E_ideal(i));
    
    %Obtener límites de la región de decisión ideal_value
    %Comparar componente I
        %Comparar componente Q
            %No error
    %Si falla alguna, error
    
    if (E_detected_real<lower_limit_I || E_detected_real>upper_limit_I)
        incorrect_symb = incorrect_symb + 1;
        disp 'Valor incorrecto!';
    elseif ((E_detected_imag<lower_limit_Q || E_detected_imag>upper_limit_Q) && (E_detected_real>lower_limit_I || E_detected_real<upper_limit_I))
        incorrect_symb = incorrect_symb + 1;
        disp 'Valor incorrecto!';
    else
        correct_symb = correct_symb + 1;
    end
    
end

BER = incorrect_symb/length(E_detected);
a = sprintf('Valores incorrectos: %d', incorrect_symb);
disp(a);

end
