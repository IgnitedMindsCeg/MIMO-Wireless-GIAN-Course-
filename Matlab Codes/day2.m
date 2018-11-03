clc 
clear all
close all

nT=2;
nR=1;
N=10000;
% Hw=sqrt(1/2)*(randn(nR,nT)+j*randn(nR,nT));
Hw=[0.2362 - 1.0244j,-0.3048 + 0.2587j]
% M=4;
% Nb=1000
% X= randint(1,Nb,M); % bit: integer vector
% Xmod = qammod(X,M,0,'gray')
Xmod=[1 + j,-1 + j];

x1=Xmod(1);x2=Xmod(2);

X=[x1 -x2';x2 x1']


Y(1)=Hw*X(:,1)
Y(2)=Hw*X(:,2)
Y(2)=conj(Y(2))

H=[Hw(1) Hw(2);Hw(2)' -Hw(1)']
HH=H'

nrm=abs(Hw(1))^2 + abs(Hw(2))^2

X_cap=HH*Y.'./nrm


Xm=[x1 x2].'









