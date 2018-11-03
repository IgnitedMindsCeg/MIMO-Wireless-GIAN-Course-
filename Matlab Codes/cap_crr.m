
clc
clear all
close all
SNR_dB=[0:5:20];  SNR_linear=10.^(SNR_dB/10);
N_iter=1000;  N_SNR=length(SNR_dB);
nT=2;  nR=2;  n=min(nT,nR);  I = eye(n);  sq2=sqrt(0.5);
Rr=[1        0.7 ;
   0.7     1    ];
Rt=[1        0.5 ;
   0.5     1    ];
C_22_iid=zeros(1,N_SNR);  C_22_corr=zeros(1,N_SNR);
for iter=1:N_iter
   H_iid = sq2*(randn(nR,nT)+j*randn(nR,nT));
   H_corr = Rr^(1/2)*H_iid*Rt^(1/2);
   tmp1 = H_iid'*H_iid/nT;  tmp2 = H_corr'*H_corr/nT;
   for i=1:N_SNR
      C_22_iid(i) = C_22_iid(i) + log2(det(I+SNR_linear(i)*tmp1));
      C_22_corr(i) = C_22_corr(i) + log2(det(I+SNR_linear(i)*tmp2));
   end
end
C_22_iid = real(C_22_iid)/N_iter;  C_22_corr = real(C_22_corr)/N_iter;
plot(SNR_dB,C_22_iid,'-g', SNR_dB,C_22_corr,'-m','LineWidth',1.2);
xlabel('SNR [dB]'); ylabel('bps/Hz');
legend('iid 2x2 channels','Correlated 2x2 channels');