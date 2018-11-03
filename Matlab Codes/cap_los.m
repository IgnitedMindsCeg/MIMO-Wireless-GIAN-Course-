
clc
clear all
close all
SNR_dB=[0:5:20];  SNR_linear=10.^(SNR_dB/10);
N_iter=1000;  N_SNR=length(SNR_dB);
nT=2;  nR=2;  n=min(nT,nR);  I = eye(n);  sq2=sqrt(0.5);
K_dB=20;
K=10^(K_dB/10);
H_bar=ones(nR,nT);
% H_bar(1,2,:)=-1;
C_22_iid=zeros(1,N_SNR);  C_22_ric=zeros(1,N_SNR);
for iter=1:N_iter
   H_w = sq2*(randn(nR,nT)+j*randn(nR,nT));
   H_los = sqrt(K/(K+1)).*H_bar + sqrt(1/(K+1)).*H_w;
   tmp1 = H_w'*H_w/nT;  tmp2 = H_los'*H_los/nT;
   for i=1:N_SNR
      C_22_iid(i) = C_22_iid(i) + log2(det(I+SNR_linear(i)*tmp1));
      C_22_ric(i) = C_22_ric(i) + log2(det(I+SNR_linear(i)*tmp2));
   end
end
C_22_iid = real(C_22_iid)/N_iter;  C_22_ric = real(C_22_ric)/N_iter;
plot(SNR_dB,C_22_iid,'-g', SNR_dB,C_22_ric,'-m','LineWidth',1.2);
xlabel('SNR [dB]'); ylabel('bps/Hz');
legend('iid 2x2 channels','Rician 2x2 channels');