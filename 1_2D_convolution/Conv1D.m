% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% Image Stitching (Visual Computing)                                      %
% Shafa Balaram                                                           %
% Function to do 1D convolution between input array g and 1D kernel f.    %
% The convolution output h is obtained after zero padding input g.        %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

function [ h ] = Conv1D( f, g )

% dimensions of arrays
N = length(g);
M = length(f);

% zero pad the input vector 
g = [ g, zeros(1, M-1)];

% initialise convolution output
h = zeros(1, N+M-1);

% compute the 1D convolution
for n = 1 : N+M-1
    h(n) = 0;
    for m = 1 : M
        if n - m + 1 > 0
            h(n) = h(n) + f(m) * g(n-m+1);
        end
    end    
end

end



