% Estimates the total information I(X) = (sum_j H(X_j)) - H(X) of a random
% D-dimensional Gaussian variable X given n IID samples of X
%
% Inputs:
%   Xs - (n-by-D) data matrix whose rows are samples of X
%
% Outputs:
%   I - estimated total information I(X) of X
%
% The runtime of this function of O(D*n*log(n) + D^2*n + D^3)

function I = normal_info(Xs)

  [n, p] = size(Xs); % [sample size, dimension]

  bias_correction = sum(psi((n - (1:p) + 1)/2) - log(n/2));

  % The most efficient and stable way to compute the log determinant is via the
  % Cholesky decomposition
  normalization = prod(diag(cov(Xs)));
  I = -(log(det(cov(Xs))./normalization) - bias_correction)/2;% -sum(log(diag(chol(corr(Xs)))));

end
