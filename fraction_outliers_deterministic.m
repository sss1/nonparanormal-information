function transforms = fraction_outliers(alphas)

  for alpha_idx = 1:length(alphas)
    alpha = alphas(alpha_idx);
    transforms{alpha_idx} = @(Xs) instantiated_transform(Xs, alpha);
  end

end

function instantiated_transform = instantiated_transform(Xs, alpha)

  [n p] = size(Xs);
  num_outliers_per_col = max(round(alpha * n), 0);
  outliers = 10*(randi([0 1], [num_outliers_per_col p]) - 0.5);
  idxs = logical([ones(num_outliers_per_col, 1); zeros(n - num_outliers_per_col, 1)]);
  for col_idx = 1:p
    Xs(idxs(randperm(n)), col_idx) = outliers(:, col_idx);
  end
  instantiated_transform = Xs;

end
