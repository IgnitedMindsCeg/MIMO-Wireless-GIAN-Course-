clc
clear all
close all
figure
SNR_dB=10;  SNR_linear=10.^(SNR_dB/10.);
N_iter=50000; sq2=sqrt(0.5); grps = ['m-'; 'b-'];
for Icase=1:2 
   if Icase==1,  nT=2; nR=2;  % 2x2
    else   nT=4; nR=4;       % 4x4
   end
   n=min(nT,nR);  I = eye(n);
   for iter=1:N_iter
      H = sq2*(randn(nR,nT)+j*randn(nR,nT)); 
      C(iter) = log2(real(det(I+SNR_linear/nT*H'*H)));
   end
   [PDF,Rate] = hist(C,50);
   PDF = PDF/N_iter;
   CDF(Icase,:)=cumsum(PDF);
   plot(Rate,CDF(Icase,:),grps(Icase,:),'LineWidth',1.2); hold on
end
xlabel('Rate[bps/Hz]'); ylabel('CDF')
axis([1 18 0 1]); grid on; set(gca,'fontsize',10); 
legend('{\it M_T}={\it M_R}=2','{\it M_T}={\it M_R}=4');