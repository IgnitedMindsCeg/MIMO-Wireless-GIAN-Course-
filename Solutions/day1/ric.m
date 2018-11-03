K_dB=[-20,-10, 0, 10, 20];
K=10.^(K_dB./10);
mr=['-k' '-m' '-c' '-r' '-g'];
for i=1:length(K)
    H = sqrt(K(i)/(K(i)+1)) + sqrt(1/(K(i)+1)).*Hw; 
    [temp,x]=hist(abs(H),50);
    plot(x,temp,mr(i),'LineWidth',1.2); hold on
end
