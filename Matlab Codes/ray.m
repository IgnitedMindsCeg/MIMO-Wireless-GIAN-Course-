
clc
close all
L=1e5;
Hw = (randn(1,L)+j*randn(1,L))/sqrt(2);
figure;
% hist(abs(H),50);
[temp,x]=hist(abs(Hw),50);
plot(x,temp,['b-'],'LineWidth',2), hold on


K_dB=[-20,-10, 0, 10, 20];
K=10.^(K_dB./10);
mr=['-k' '-m' '-c' '-r' '-g'];
for i=1:length(K)
    H = sqrt(K(i)/(K(i)+1)) + sqrt(1/(K(i)+1)).*Hw; 
    [temp,x]=hist(abs(H),50);
    plot(x,temp,mr(i),'LineWidth',1.2); hold on
end

legend('Rayleigh','K=-20dBm','K=-10dBm','K=0dBm','K=10dBm','K=20dBm')