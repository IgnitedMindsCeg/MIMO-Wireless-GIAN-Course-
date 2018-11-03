clear all
close all
clc
M = 1000;
rho = [0 .2 .8];
SNR = [0:2:16];

s = {'b-','r-.','k:'};
figure;
xlabel('SNR [dB]');
ylabel('Capacity');
title('Capacity vs SNR with and without correlation')
grid on
hold on;

for l = 1:length(rho),
    l
    R_t = eye(2);
    R_r = [1 rho(l);rho(l) 1]
    for snr_idx = 1:length(SNR),
        snr = 10^(SNR(snr_idx)/10);
        for m = 1:M,
            Hw = (randn(2,2)+1i*randn(2,2))/sqrt(2);
            H = R_r^(.5)*Hw*R_t^(.5);
            C(m,snr_idx)=log2((det(eye(2)+snr*H*H'/2)));
        end
        Capacity(snr_idx,l) = mean(C(:,snr_idx));
    end
    linetype = s(l);
    plot(SNR,Capacity(:,l),deal(linetype{:}));
    pause
end

legend('\rho=0','\rho=0.2','\rho=0.8');