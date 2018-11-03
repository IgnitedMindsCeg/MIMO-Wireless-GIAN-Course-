clear all
close all
symbols = [ -1 1];
eps_var = 0:0.1:1;
errors_AC = zeros(size(eps_var));

SNR = 10.^(15/10);
noise_var = 1/SNR;
max_iter = 10000
for iter = 1:max_iter,
    [iter]
    h =  sqrt(0.5)* (randn(2,1)+ j* randn(2,1));
    H = [h(1) h(2) ; h(2)' -h(1)'];
    s_index = round(rand(2,1));
    s = symbols(s_index+1).';
    n = sqrt(noise_var/2)*(randn(2,1)+j*randn(2,1));
    y = H*s + n;

    for count = 1:length(eps_var),
        index = eps_var(count);
        eps = sqrt(index/2)*(randn(2,1)+j*randn(2,1)); 
        H_hat = [h(1)+ eps(1)  (h(2)+eps(2)) 
        		(h(2) + eps(2))' -(h(1) + eps(1))'];
        z = H_hat'*y;
        decoded_AC = sign(real(z)); 
        decoded_AC(find(decoded_AC == -1)) = 0;
        s_index;
        errors = sum(abs(decoded_AC - s_index));
        errors_AC(count) = errors_AC(count) + errors;
    end 
end
BER_AC = errors_AC/(max_iter*2)

semilogy(eps_var, BER_AC, '-d')
xlabel(texlabel('sigma_epsilon^2'))
ylabel('BER')
