clear all
H1 = [0.9 0.75;0.6 0.8];
H2 = [0.4 0.2;0.3 0.1];

%delay spread, in multiples of the symbol spacing
tau = [1 .25]; 

%sample spacing (2 cases)
ss = [1 .5];

beta = 0.3;

for t = 1:length(tau),
    for s = 1:length(ss),
        %Generate the sample times
        ks = [0:ss(s):4];

        for l = 1:length(ks),
            k = ks(l);
            x = sinc(k)*cos(pi*beta*k)/(1-4*beta^2*k^2)*H1+...
                sinc(k-tau(t))*cos(pi*beta*(k-tau(t)))...
                /(1-4*beta^2*(k-tau(t))^2)*H2;
            H(:,:,l) = x;
        end
        s = sprintf(' Delay = %d Ts and sampling rate = %d Ts: ',...
            tau(t),ss(s));
        disp(s)
        H
    end
end