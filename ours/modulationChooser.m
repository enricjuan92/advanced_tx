function modulatedSignal = modulationChooser(binarySequence ,modulationType)

modulationType = upper(modulationType); 

switch modulationType
    case 'QPSK'
        % Determinamos la longitud de la señal modulada
        modulatedSignal = zeros (1 ,( length ( binarySequence ) /2) ) ; k=1;
        
        % Comprobamos la secuencia de dos en dos bits
        for i =1:2:( length ( binarySequence )-1) 
            
            symbol = binarySequence(i:i+1)';
            decimalNumber = bi2de(symbol); % Lee los bits de IZQUIERDA A DERECHA
            
            switch decimalNumber 
                case 0%[0,0]
                    modulatedSignal(k)= (-sqrt(1/2)-sqrt(1/2)*1j);
                    k=k+1; 
                
                case 1%[1,0]
                    modulatedSignal(k)= (sqrt(1/2)-sqrt(1/2)*1j);
                    k=k+1; 
                
                case 2%[0,1]
                    modulatedSignal(k)= (-sqrt(1/2)+sqrt(1/2)*1j);
                    k=k+1; 
                
                case 3%[1,1]
                modulatedSignal(k)= (sqrt(1/2)+sqrt(1/2)*1j); 
                k= k+1;

            end
        end
        
    otherwise
        error('the modulation modulationType does not exist.');
end
end
