%The RLS algorithm was taken from the mathwork.com.The algorithm desined by
%Ryan Fuller.
%Link:
%https://www.mathworks.com/matlabcentral/fileexchange/36858-recursive-least-squares-filter


function [y,w,delta] = RLSFilterI232(x,d)
p       = 40;                % filter order
lambda  = 0.999;              % forgetting factor
laminv  = 1/lambda;
delta   = 1.0;              % initialization parameter
% Filter Initialization
w       = zeros(p,1);       % filter coefficients
P       = delta*eye(p);     % inverse correlation matrix
for m = p:length(d)
    j = x(m:-1:m-p+1); % Acquire chunk of data
    e(m) = d(m)-w'*j;% Error signal equation
    Pi = P*j;% Parameters for efficiency
    k = (Pi)/(lambda+j'*Pi); % Klman Filter gain vector update
    P = (P - k*j'*P)*laminv;% Inverse correlation matrix update
    w = w + k*e(m);% Filter coefficients adaption
    
end
y=e;
return
