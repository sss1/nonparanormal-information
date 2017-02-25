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

function I = nonparanormal_Spearman_info(Xs)

  [n, p] = size(Xs); % [sample size, dimension]

  % Should be 0.00001
  eigs = max(eig(2*sin((pi/6)*corr(Xs, 'type', 'Spearman'))), 0.00001);
  
  bias_correction = 0;% sum(psi((n - (1:p) + 1)/2) - log(n/2));

  I = -(sum(log(eigs)) - bias_correction)/2;

end
