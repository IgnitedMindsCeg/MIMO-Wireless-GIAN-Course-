clc,clear all,close all
SNR_dB=10;
SNR_linear=10.^(SNR_dB/10);
K_dB=[-10:2:20];
N_iter=50000;  N_K=length(K_dB);
nT=2;  nR=2;  n=min(nT,nR);  I = eye(n);  sq2=sqrt(0.5);
H1_bar=ones(nR,nT);
H2_bar=H1_bar;
H2_bar(1,2,:)=-1;
C_22_1=zeros(1,N_K);  C_22_2=zeros(1,N_K);
for i=1:N_K
 K=10^(K_dB(i)/10);
 for iter=1:N_iter 
   H_w=sq2*(randn(nR,nT)+j*randn(nR,nT));
   H_1 = sqrt(K/(K+1)).*H1_bar + sqrt(1/(K+1)).*H_w;
   H_2 = sqrt(K/(K+1)).*H2_bar + sqrt(1/(K+1)).*H_w;
   tmp1 = H_1'*H_1/nT;  
   tmp2 = H_2'*H_2/nT;
   C_22_1(i) = C_22_1(i)+log2(real(det(I+SNR_linear*tmp1)));
   C_22_2(i) = C_22_2(i)+log2(real(det(I+SNR_linear*tmp2)));
  end
end
C_22_1 = C_22_1/N_iter;  C_22_2 = C_22_2/N_iter;
plot(K_dB,C_22_1,'-g', K_dB,C_22_2,'-m','LineWidth',1.2);
xlabel('K [dB]'); ylabel('bps/Hz');
legend('Channel 1','Chennel 2');