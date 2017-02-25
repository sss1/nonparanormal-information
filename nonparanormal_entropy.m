% Estimates the entropy H(X) of a random D-dimensional variable X given n IID
% samples of X
%
% Inputs:
%   Xs - (n-by-D) data matrix whose rows are samples of X
%
% Outputs:
%   H - estimated entropy H(X) of X
%
% The runtime of this function of O(D*n*log(n) + D^2*n + D^3)

function H = nonparanormal_entropy(Xs)

  % TODO: Estimate the sum of entropies of each dimension of Xs
  Hs = 0;

  I = nonparanormal_info(Xs);

  H = sum(Hs) - I;

end
