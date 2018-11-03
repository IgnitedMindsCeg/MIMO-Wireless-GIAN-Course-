K_dB=20;
K=10^(K_dB/10);
H_bar=ones(nR,nT,N);
% H_bar(1,2,:)=-1
H_ric = sqrt(K/(K+1)).*H_bar + sqrt(1/(K+1)).*H_w;

