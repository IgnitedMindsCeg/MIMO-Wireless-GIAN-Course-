clear all;
close all;
clc;
M = 1000;
Nt = [1:2:5];

SNR = [0:2:16]; %dB
figure(1);
title('Plot of capacity for an MxM system vs SNR')
xlabel('SNR [dB]');
ylabel('Capacity');
grid on
hold on;
figure(2);
title('Plot of 10% outage capacity for an MxM system vs SNR')
xlabel('SNR [dB]');
ylabel('Outage Capacity');
grid on
hold on;
for n = 1:length(Nt),
    N = Nt(n);
    for m = 1:M,
        H = (randn(N,N)+1i*randn(N,N))/sqrt(2);
        for snr_idx = 1:length(SNR),
            rho = 10^(SNR(snr_idx)/10);
            
            % Find the capacity for unknown channel at Tx:
            CU(m,snr_idx) = log2(real(det(eye(N)+rho*H*H'/N)));
            
            % Find the capacity for known channel at Tx:
            [gamma,eigs] = pwr_modes(H,rho);
            CK(m,snr_idx) = sum(log2(real(1+eigs.*gamma*rho/N)));
        end
    end
    C_unknown(:,n) = mean(CU)';
    C_known(:,n) = mean(CK)';
    
    for snr_idx = 1:length(SNR),

        [cdf_u,co_u] = hist(CU(:,snr_idx),100);
        cdf_u = cumsum(cdf_u);
        idx_ten_percent = find(abs(cdf_u-100)==min(abs(cdf_u-100)));
        C_unknown_outage(snr_idx,n) = co_u(idx_ten_percent(1));

        [cdf_k,co_k] = hist(CK(:,snr_idx),100);
        cdf_k = cumsum(cdf_k);
        idx_ten_percent = find(abs(cdf_k-100)==min(abs(cdf_k-100)));
        C_known_outage(snr_idx,n) = co_k(idx_ten_percent(1));
    end
    
    figure(1);
    plot(SNR,C_unknown(:,n));
    plot(SNR,C_known(:,n),'r:');
    
    figure(2);
    plot(SNR,C_unknown_outage(:,n));
    plot(SNR,C_known_outage(:,n),'r:');
    
    if n == 1
        figure(1)
        legend('Channel Unknown','Channel known');
        figure(2)
        legend('Channel Unknown','Channel known');
    end
    
    pause
end

hold off
figure
plot(Nt,C_unknown(6,:))
hold on
plot(Nt,C_known(6,:),'r:')
title('Plot of capacity vs number of antennas - channel known and unknown')
xlabel('Number of antennas')
ylabel('Capacity');
legend('Channel Unknown','Channel known');
grid on