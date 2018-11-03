clear all;
close all;

M = 10000;

for m = 1:M,
    H = (randn(4,4)+1i*randn(4,4))/sqrt(2);
    l_min(m) = min(eig(H*H'));
end

[pdf,X] = hist(l_min,100)
pdf = pdf/sum(pdf*(X(2)-X(1)));
pdf_theoretical = 4*exp(-4*X);
plot(X,pdf,'.')
hold on
plot(X,pdf_theoretical,'r');