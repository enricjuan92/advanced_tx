function levels = get_levels(sampled_vector, mod_order)

%levels = zeros((mod_order/sqrt(mod_order)) - 1, 1);

pos_vec = sampled_vector(sampled_vector >= 0);
uniq = unique(pos_vec); %diferentes niveles en el vector
[n, bin] = histc(pos_vec, uniq); 
% n: numero de repeticiones
% bin:
ordenado = sort(n, 'descend'); % Coloca en orden descediente el número de repeticiones

ordenado_Nsimb = ordenado(1:(mod_order/sqrt(mod_order))/2); % Vector que coge las N repeticiones del vector ordenado en función del
% número de símbolos de la modulación.
viv = zeros(length(ordenado_Nsimb), 1);
viv(1:length(ordenado_Nsimb)) = find(n >= ordenado_Nsimb(length(ordenado_Nsimb))); % Del vector anterior seleccionamos 
pos_vec = pos_vec(ismember(bin, viv));
pos_lvl = unique(pos_vec)';
neg_lvl = sort(-pos_lvl);
lvls = [neg_lvl pos_lvl];

levels(1:length(lvls)-1) = (mean([lvls(1:length(lvls)-1);lvls(2:length(lvls))]));

