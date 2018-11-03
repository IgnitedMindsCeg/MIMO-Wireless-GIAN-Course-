clear all
close all
clc
M = 1000;
K = [0 1 10];
SNR = [0:2:16];
H0 = [1 1; 1 1];
s = {'b-','r-.','k:'};
figure;
xlabel('SNR [dB]');
ylabel('Capacity');
title('Capacity vs SNR with and without K-factor')
grid on
hold on;

for l = 1:length(K),
    l
    k = K(l);
    for snr_idx = 1:length(SNR),
        snr = 10^(SNR(snr_idx)/10);
        for m = 1:M,
            Hw = (randn(2,2)+1i*randn(2,2))/sqrt(2);
            H = sqrt(k/(k+1))*H0+sqrt(1/(k+1))*Hw;
            C(m,snr_idx)=log2((det(eye(2)+snr*H*H'/2)));
        end
        Capacity(snr_idx,l) = mean(C(:,snr_idx));
    end
    linetype = s(l);
    plot(SNR,Capacity(:,l),deal(linetype{:}));
    pause
end

legend('K=0','K=1','K=10');