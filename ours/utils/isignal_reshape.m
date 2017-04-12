function [viv_i, viv_q] = isignal_reshape(elec_i, elec_q, freq)

index_i = rep_values(elec_i, freq);
index_q = rep_values(elec_q, freq);

real_size = max(min(size(index_i), size(index_q)));

viv_i = index_i(1:real_size);
viv_q = index_q(1:real_size);

end