% Estimates the total information I(X) = (sum_j H(X_j)) - H(X) of a random
% D-dimensional nonparametric random variable X given n IID samples of X
%
% Inputs:
%   Xs - (n-by-D) data matrix whose rows are samples of X
%   k - positive integer kNN parameter (optional; default: k = 2)
% 
% Outputs:
%   I - estimated total information I(X) of X
%
% The runtime of this function of O(D*n*log(n) + D^2*n + D^3)

function I = KNN_info(Xs, k)

  if nargin < 2
    k = 2;
  end

  [n, p] = size(Xs); % [sample size, dimension]

  co = HShannon_kNN_k_initialization(1); %initialize the entropy (’H’) estimator
  co.k = 2;
  H_total = HShannon_kNN_k_estimation(Xs',co);

  H_sum = 0;
  for dim = 1:p
    H_sum = H_sum + HShannon_kNN_k_estimation(Xs(:, dim)',co);
  end

  I = H_sum - H_total;

end
