
clc
close all

PdBm=42;
P_W=10^((PdBm-30)/10)
ht=6;
hr=2;
d=[100:500:10e3];

Pr=P_W*(ht*hr./d.^2).^2;

Pr_dBm=10*log10(Pr)+30;

figure
plot(d,Pr_dBm,'-sb')
xlabel('Distance(m)')
ylabel('Received power(dBm)')