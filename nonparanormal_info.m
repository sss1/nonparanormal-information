% Estimates the total information I(X) = (sum_j H(X_j)) - H(X) of a random
% D-dimensional variable X given n IID samples of X
%
% Inputs:
%   Xs - (n-by-D) data matrix whose rows are samples of X
%
% Outputs:
%   I - estimated total information I(X) of X
%
% The runtime of this function of O(D*n*log(n) + D^2*n + D^3)

function I = nonparanormal_info(Xs)

  [n, p] = size(Xs); % [sample size, dimension]

  % TODO: check whether we need to truncate (``Winsorize'') tiedrank(Xs)/n
  % G contains the data transformed such that each dimension is standard normal
  G = norminv(tiedrank(Xs)/(n + 1), 0, 1);

  bias_correction = sum(psi((n - (1:p) + 1)/2) - log(n/2))/2;

  % The most efficient and stable way to compute the log determinant is via the
  % Cholesky decomposition
  I = -(sum(log(diag(chol(cov(G))))) - bias_correction);

end
