function [g,l] = pwr_modes(H,rho)

N_tilde = size(H,1);
l_tilde = real(eig(H*H'));

l = l_tilde(find(l_tilde~=0));
N = length(l);

mu = (N_tilde+sum(N_tilde./(rho*l)))/N;
g = mu-N_tilde./(rho*l);

while (length(find(g <= 0)) ~= 0)
    l = l(find(g > 0));
    N = length(l);
    mu = (N_tilde+sum(N_tilde./(rho*l)))/N;
    g = mu-N_tilde./(rho*l);
end
