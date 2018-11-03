

clc
clear all
close all

%%
%A transmitter with height of 6m has the transmit power of 42 dBm. A
%reciever is placed 2Km away from the transmitter with the height of 2m
%from the ground. what is the received power in dBm?
PdBm=42;
P_W=10^((PdBm-30)/10)

ht=6;
hr=2;
d=2e3;

Pr=P_W*(ht*hr/d^2)^2;


Pr_dBm=10*log10(Pr)+30;
%%
%What is the range if receiver sensitivity is -90dBm?
Rx_s=-90;
Rx_s_w=dBm2w(Rx_s);
range=power(P_W/Rx_s_w,1/4)*sqrt(ht*hr); 
%%
%Generate a SISO rayleigh channel.
L=1e5;
Hw = (randn(1,L)+j*randn(1,L))/sqrt(2);
figure;
% hist(abs(H),50);
[temp,x]=hist(abs(Hw),50);
plot(x,temp,['b-' 's']), hold on
%%
%Generate a SISO RIcian channel.
K_dB=-20;
K=10^(K_dB/10);
H = sqrt(K/(K+1)) + sqrt(1/(K+1))*Hw; 
[temp,x]=hist(abs(H),50);
plot(x,temp,['r-' '^'])

%%
%Generate a MIMO channel (Rayleigh).
nT=2;
nR=2;
N=2;
H_iid = sqrt(2)*(randn(N,nR,nT)+j*randn(N,nR,nT));

%%
%Generate a Correlated MIMO channel.
Rt=[1                      0.76*exp(0.17j*pi)   
   0.76*exp(-0.17j*pi)   1                  ];
Rr=[1                      0.6*exp(0.23j*pi)   
   0.6*exp(-0.23j*pi)   1                  ];

nT=2;
nR=2;
N=10000;
Hw=sqrt(1/2)*(randn(nT*nR,N)+j*randn(nT*nR,N));
% C = chol(kron(Rt,Rr))';

R = sqrtm(sqrt(kron(Rt,Rr)));

H_corr=zeros(nR,nT,N);
for i=1:N
    tmp=R*Hw(:,i); 
    H_corr(:,:,i)=reshape(tmp,nR,nT);  
end

h11(1:N)=abs(H_corr(1,1,:));


figure;
% hist(abs(H),50);
[temp,x]=hist(h11,50);
plot(x,temp,['b-' 's']), hold on

%%
%Genarate Racian fading
K_dB=20;
K=10^(K_dB/10);

H_bar=ones(nR,nT,N);
% H_bar(1,2,:)=-1

H_ric = sqrt(K/(K+1)).*H_bar + sqrt(1/(K+1)).*H_corr;


h11(1:N)=abs(H_ric(1,1,:));

[temp,x]=hist(h11,50);
plot(x,temp,['r-' '^']), hold on
%%
% 
% clear all
% H1 = [0.9 0.75;0.6 0.8];
% H2 = [0.4 0.2;0.3 0.1];
% %delay spread, in multiples of the symbol spacing
% tau = [1 .25];
% %sample spacing (2 cases)
% ss = [1 .5];
% beta = 0.3;
% for t = 1:length(tau),
% for s = 1:length(ss),
% %Generate the sample times
% ks = [0:ss(s):4];
% for l = 1:length(ks),
%     k = ks(l);
%     x = sinc(k)*cos(pi*beta*k)/(1-4*beta^2*k^2)*H1+ sinc(k-tau(t))*cos(pi*beta*(k-tau(t)))/(1-4*beta^2*(k-tau(t))^2)*H2;
%     H(:,:,l) = x;
% end
% s = sprintf('Delay = %d Ts and sampling rate = %d Ts: ', tau(t),ss(s));
% disp(s)
% H
% end
% end
% 
% 

