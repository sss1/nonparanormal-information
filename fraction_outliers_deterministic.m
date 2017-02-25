function transforms = fraction_outliers(alphas)

  for alpha_idx = 1:length(alphas)
    alpha = alphas(alpha_idx);
    transforms{alpha_idx} = @(Xs) instantiated_transform(Xs, alpha);
  end

end

function instantiated_transform = instantiated_transform(Xs, alpha)

  [n p] = size(Xs);
  num_outliers = max(round(alpha * n), 0);


  outliers = 5 * ones(p * num_outliers, 1);
  outliers(randi([0 1]):2:end) = -5;
  outliers = reshape(outliers, [p num_outliers]);

  Xs(1:num_outliers, :) = outliers;

  instantiated_transform = Xs;

end
