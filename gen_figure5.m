% Figure 5
clear;
num_trials = 400;
ns = 100; % should be 100
p_funs = {@(n) 25};
Sigma_funs = {@(p) corrcov(wishrnd(eye(p), 4*p))};
alphas = 0:0.02:0.5;
transforms = fraction_outliers(alphas);
estimators = {@(Xs) normal_info(Xs), ...
              @(Xs) nonparanormal_info(Xs), ...
              @(Xs) nonparanormal_Spearman_info(Xs), ...
              @(Xs) nonparanormal_Kendall_info(Xs), ...
              @(Xs) KNN_info(Xs)
              };

[results, std_errs] = ...
  test(estimators, ns, p_funs, Sigma_funs, transforms, num_trials);

close all;
columnwidth = 8.25381;
fig = figure('units', 'centimeters', 'position', [5 5 columnwidth 6]);
hold all;
colorOrder = get(gca, 'ColorOrder');
for estimator_idx = 1:length(estimators)
  means = squeeze(results(1, 1, 1, :, estimator_idx));
  CIs = 1.96 * squeeze(std_errs(1, 1, 1, :, estimator_idx)); % 95% asymptotic confidence interval radius
  lower = log10(means - CIs);
  lower(CIs > means) = 0; % can't display negative numbers on log scale
  upper = log10(means + CIs);
  color = colorOrder(mod(length(get(gca, 'Children')), size(colorOrder, 1))+1, :);
  legendPlots(estimator_idx) = plot(alphas, log10(means), 'LineWidth', 1.5);
  legendPlots(estimator_idx).Marker = get_next_marker(estimator_idx);
  % plot(alphas, lower, '--', 'LineWidth', 0.5, 'Color', color);
  % plot(alphas, upper, '--', 'LineWidth', 0.5, 'Color', color);
end
xlim([-Inf 1.05*max(alphas)]);
xlabel('Fraction of outliers $$(\beta)$$', 'FontSize', 12, 'Interpreter', 'latex');
% ylabel('$$\log_{10}$$(MSE)', 'FontSize', 12, 'Interpreter', 'latex');
% legend(legendPlots, {'$$\hat I$$', ...
%                      '$$\hat I_G$$', ...
%                      '$$\hat I_\rho$$', ...
%                      '$$\hat I_\tau$$' ...
%                      % '$$\hat I_{KNN}$$'
%                     }, ...
%               'Location', 'southeast', ...
%               'Interpreter', 'latex', ...
%               'FontSize', 10);
fig.PaperUnits = 'centimeters';
fig.PaperPosition = [5 5 columnwidth 6];
saveas(fig, 'figs/fig5.fig');
saveas(fig, 'figs/fig5.png');
saveas(fig, 'figs/fig5.eps', 'epsc2');
