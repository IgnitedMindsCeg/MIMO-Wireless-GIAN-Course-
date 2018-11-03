% EE492m Homework 3 no. 3
% Kome Oteri
clear all 
close all
SnrdB = 0:3:15;
Ne = 1;
dmin = 2;
ResultsSISO = zeros(1,length(SnrdB));
ResultsAC = zeros(1,length(SnrdB));
ResultsED = zeros(1,length(SnrdB));

max_iter = 10000
for iter = 1:max_iter,
    h = sqrt(1/2)*(randn(1) + j*randn(1));
    for count = 1:length(SnrdB),
        rho = 10.^(SnrdB(count)/10);    
        eta = rho * abs(h).^2;
        x = sqrt((eta *dmin^2)/2);        
        ResultsSISO(count) = ResultsSISO(count)+ 0.5* Ne* erfc(x/sqrt(2)) ;   
    end
end
semilogy(SnrdB,ResultsSISO/max_iter);

for iter = 1:max_iter,
    H = sqrt(1/2)*(randn(2,2) + j*randn(2,2));
    for count = 1:length(SnrdB),
        rho = 10.^(SnrdB(count)/10);    
        etaAC = rho * (norm(H,'fro').^2)/2;
        xAC = sqrt((etaAC *dmin.^2)/2);
        ResultsAC(count) = ResultsAC(count)+ 0.5* Ne* erfc(xAC/sqrt(2)) ;   
        a = svd(H);        
        etaED = rho *a(1).^2;
        xED = sqrt((etaED *dmin.^2)/2);
        ResultsED(count) = ResultsED(count)+ 0.5*  Ne* erfc(xED/sqrt(2)) ;           
    end
end
hold on
semilogy(SnrdB,ResultsAC/max_iter,'-*');
semilogy(SnrdB,ResultsED/max_iter,'-o');
% grid on
legend('No Diversity','Alamouti','Dominant Eigenmode',0)
xlabel ('SNR (dB)')
ylabel ('SER')
title('Alamouti Code Peformance')