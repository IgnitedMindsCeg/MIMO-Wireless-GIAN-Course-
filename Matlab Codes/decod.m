clc
close all

Mt=2;

H=[1 0.5+1j;-0.25 -1j]

HH=(H'*H)^(-1)

HH(1,1)/Mt