function [S] = LiteSign(x)

x = -x;
S = 1 ./ (1 + exp(x));
end

