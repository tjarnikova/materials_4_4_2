function H = shannonWiener(pcounts)
H = 0;
% H_i = 0;

pcounts = pcounts(pcounts>0);
psum = sum(pcounts,2);
    for i = 1:length(pcounts)
        p = pcounts(i)./psum;
        H_i = -(p .* log(p));
        H = H + H_i;
    end
end
