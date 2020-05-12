function [mean] = mymean(a)

mean = sum(a(~isnan(a)))./sum(~isnan(a));

end
