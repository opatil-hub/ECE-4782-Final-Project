function [W,e] = my_nlms(x,d,M,mu,alpha,I)

% x-reference input (noise)

% d-desired or primary input, here the signal plus noise, 's+no'

% M - filter length

% alpha - normalization factor

% I-no. of iterations

% W-final weight vector

% e-error signal e=d-W*x, this is the signal recovered

 

[m,n] = size(x);

if (n>m)

    x = x.';

end

 

Lx = length(x);

itr = I;

W = zeros(M,1);

x = [zeros(M-1,1); x];

 

for i = 1:itr

    for k = 1:Lx

        X = x(k+M-1:-1:k);

        y = W'*X;

        e(k,1) = d(k,1) - y;

        p = alpha + X'*X;

        W = W + ((2*mu*e(k,1))/p)*X;

    end

end