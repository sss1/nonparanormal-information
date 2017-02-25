% Estimates the total information I(X) = (sum_j H(X_j)) - H(X) of a random
% D-dimensional variable X given n IID samples of X
%
% TODO: This is not yet implemented! Do not use!
%
% Inputs:
%   Xs - (n-by-D) data matrix whose rows are samples of X
%
% Outputs:
%   I - estimated total information I(X) of X
%
% The runtime of this function of O(D*n*log(n) + D^2*n + D^3)

function I = nonparanormal_Kendall_info(Xs)

  [n, p] = size(Xs); % [sample size, dimension]

  eigs = max(eig(sin((pi/2)*corr(Xs, 'type', 'Kendall'))), 0.0001);
  
  bias_correction = 0;% sum(psi((n - (1:p) + 1)/2) - log(n/2));

  I = -(sum(log(eigs)) - bias_correction)/2;

end
