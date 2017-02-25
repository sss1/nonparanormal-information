function transforms = fraction_transform(num_alphas, transform)

  for alpha_idx = 0:num_alphas
    alpha = alpha_idx/num_alphas;
    transforms{alpha_idx + 1} = @(Xs) instantiated_transform(Xs, alpha, transform);
  end

end

function instantiated_transform = instantiated_transform(Xs, alpha, transform)

  idx = max(round(alpha * size(Xs, 2)), 1);
  instantiated_transform = [transform(Xs(:, 1:(idx-1))) Xs(:, idx:end)];

end
