function [p,z] = twoProportionTest(correctA,correctB,n1,n2)
p1 = correctA / n1;
p2 = correctB / n2;
p_pool = (correctA + correctB) / (n1 + n2);

z = (p1 - p2) / sqrt(p_pool * (1 - p_pool) * (1/n1 + 1/n2));
p = 2 * (1 - normcdf(abs(z)));   % two-sided p-value

end