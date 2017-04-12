function animated_plot(complex_signal, stitle, margins)


% Animation Plot
figure;
title(stitle)
h=animatedline(real(complex_signal(1)), imag(complex_signal(1)), 'LineStyle', 'None', 'Marker', '*', 'Color', 'blue');

axis(margins);

%pause(5)

for i=2:length(complex_signal)
    
    addpoints(h, real(complex_signal(i)), imag(complex_signal(i)))    
    drawnow
 
end

end