function pat2comp = pat2cmx (pat)
% This functionc converts a pat vector ( symbols represented as 0, 1, 2, 3)
% to a stars vector (1, i, -1, -i)

stars=zeros(size(pat))


for n=1:length(pat)
    if pat(n,:)==0 stars(n)=1;end
    if pat(n,:)==1 stars(n)=i;end
    if pat(n,:)==3 stars(n)=-1;end
    if pat(n,:)==2 stars(n)=-i;end                
end

pat2comp=stars;