function Sigma_funs = Sigma_range_2D(sigmas)

  for sigma_idx = 1:length(sigmas)
    sigma = sigmas(sigma_idx);
    Sigma_funs{sigma_idx} = @(p) instantiated_Sigma_fun(p, sigma);
  end

end

function Sigma = instantiated_Sigma_fun(p, sigma)

  Sigma = eye(p);
  Sigma(1, 2) = sigma;
  Sigma(2, 1) = sigma;

end
