clc
close all
clear all
Rt=[1                      0.76*exp(0.17j*pi)   
   0.76*exp(-0.17j*pi)   1                  ];
Rr=[1                      0.6*exp(0.23j*pi)   
   0.6*exp(-0.23j*pi)   1                  ];

nT=2;
nR=2;
N=1000;
Hw=sqrt(1/2)*(randn(nT*nR,N)+j*randn(nT*nR,N));
% R = chol(kron(Rt,Rr))';
R = sqrtm(sqrt(kron(Rt,Rr)));

H_crr=zeros(nR,nT,N);
for i=1:N
    tmp=R*Hw(:,i); 
    H_crr(:,:,i)=reshape(tmp,nR,nT);  
end
H_crr





