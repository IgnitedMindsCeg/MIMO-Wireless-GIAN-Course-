clc
close all
clear all

H=[0.5464 + 0.2294j;-1.2666 + 0.2736j]
H_nrm=norm(H)
ENo_dB=20
Mt=2;
ENo=10^(ENo_dB/10);
% H_rm=abs(H(1))^2+abs(H(2))^2
% SISO
C_SIMO=log2(1+ENo*H_nrm^2)

C_MISO=log2(1+(ENo/Mt)*H_nrm^2)

ENo_dB=25;
ENo=10^(ENo_dB/10);

H=[-0.8256 + 0.8831j 0.8025 + 0.4420j; -0.2678 + 0.3977j 1.2196 - 0.0895i]

I=eye(2);
lam=eig(H*H')
sum(log2(1+(ENo/2).*lam))

C=log2(real(det(I+(ENo/2).*(H*H'))))