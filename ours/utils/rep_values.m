function index = rep_values(array, freq)

uniq = unique(array);
[n, bin] = histc(array, unique(array));
viv = find(n > freq);
index = find(ismember(bin, viv));

end