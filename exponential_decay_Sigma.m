function Sigma = exponential_decay_Sigma(p, c)

  Sigma = eye(p);

  for j = 1:p
    for i = (j + 1):p
      Sigma(i,j) = c.^abs(i - j);
      Sigma(j,i) = Sigma(i, j);
    end
  end

end
