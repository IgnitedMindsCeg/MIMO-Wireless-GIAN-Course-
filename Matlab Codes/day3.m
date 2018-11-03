
clear all;
close all;
clc

nT=2;
nR=2;
M=4;
Nb=1000
Xm= randint(1,Nb,M); % bit: integer vector
Xmod = qammod(Xm,M,0,'gray');
Xmod=[1 + j,-1 + j];
X=[Xmod(1) Xmod(2)].'


H=sqrt(1/2)*(randn(nR,nT)+j*randn(nR,nT))
H=[-0.8256 + 0.8831i, 0.8025 + 0.4420i;
    -0.2678 + 0.3977i, 1.2196 - 0.0895i]

Y=sqrt(1/nT)*H*X;
Gzf=sqrt(nT).*inv(H'*H)*H'


X_cap=Gzf*Y
X