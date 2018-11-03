
clc
close all
L=1e5;
Hw = (randn(1,L)+j*randn(1,L))/sqrt(2);
figure;
% hist(abs(H),50);
[temp,x]=hist(abs(Hw),50);
plot(x,temp,['b-'],'LineWidth',2), hold on

