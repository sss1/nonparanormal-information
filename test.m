function [results, std_errs] = test(estimators, ns, p_funs, Sigma_funs, transforms, num_trials)

  results = zeros(length(ns), length(p_funs), length(Sigma_funs), length(transforms), length(estimators));
  std_errs = zeros(length(ns), length(p_funs), length(Sigma_funs), length(transforms), length(estimators));

  for n_idx = 1:length(ns)
    n = ns(n_idx);

    for p_fun_idx = 1:length(p_funs)
      p_fun = p_funs{p_fun_idx};

      p = round(p_fun(n));
      disp(['Sample Size: ' num2str(n) '      Dimension: ' num2str(p)]);

      for Sigma_fun_idx = 1:length(Sigma_funs)

        Sigma_fun = Sigma_funs{Sigma_fun_idx};
        truths = zeros(num_trials, 1);

        for transform_idx = 1:length(transforms)
          tic;
          transform = transforms{transform_idx};

          all_trial_results = zeros(length(estimators), num_trials);
          parfor trial_idx = 1:num_trials

            Sigma = Sigma_fun(p);
            truth = -sum(log(eig(Sigma)))/2; % true nonparanormal mutual information
            truths(trial_idx) = truth;
            Xs = transform(mvnrnd(zeros(n, p), Sigma)); % sample synthetic data

            trial_results = zeros(size(estimators));

            % for fairness, run all estimators on same data
            for estimator_idx = 1:length(estimators)
              estimator = estimators{estimator_idx};
              trial_results(estimator_idx) = (estimator(Xs) - truth).^2;
            end

            % have to do it like this so parfor can classify variables
            all_trial_results(:, trial_idx) = trial_results;

          end
          toc;
          all_trial_results(isinf(all_trial_results)) = NaN;

          % aggregage across trials
          results(n_idx, p_fun_idx, Sigma_fun_idx, transform_idx, :) = nanmean(all_trial_results, 2);
          std_errs(n_idx, p_fun_idx, Sigma_fun_idx, transform_idx, :) = std(all_trial_results, [], 2) ./ sqrt(num_trials);

        end
        disp(['Average Truth:' num2str(mean(truths))]);
      end
    end
  end
end
