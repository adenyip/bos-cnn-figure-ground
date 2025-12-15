function [p, chi2, tbl] = McNemar(labels,predA,predB)
    correctA = predA == labels;
    correctB = predB == labels;

    a = sum(correctA & correctB);   % both correct
    b = sum(correctA & ~correctB);  % A correct, B wrong
    c = sum(~correctA & correctB);  % A wrong, B correct
    d = sum(~correctA & ~correctB); % both wrong

    tbl = [a b; c d];

    if b + c == 0
        chi2 = NaN;  % undefined
        p = 1.0;
    else
        chi2 = (abs(b - c) - 1)^2 / (b + c);
        p = 1 - chi2cdf(chi2, 1);
    end
end