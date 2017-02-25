% Figure 4
close all;
clear;
num_trials = 1000;
% ns = [round(logspace(1.5, 2 - 1/9, 8)) round(logspace(2, 3, 10))];
ns = 10^2;
p_funs = {@(n) 4};
sigmas = 1 - logspace(-3, 0, 16);
xs = log10(1 - sigmas);
Sigma_funs = Sigma_range_2D(sigmas);
transforms = {@(Xs) Xs};
estimators = {@(Xs) normal_info(Xs), ...
              @(Xs) nonparanormal_info(Xs), ...
              @(Xs) nonparanormal_Spearman_info(Xs), ...
              @(Xs) nonparanormal_Kendall_info(Xs), ...
              @(Xs) KNN_info(Xs)};

[results, std_errs] = ...
  test(estimators, ns, p_funs, Sigma_funs, transforms, num_trials);

columnwidth = 8.25381;
fig = figure('units', 'centimeters', 'position', [5 5 columnwidth 6]);
hold all;
colorOrder = get(gca, 'ColorOrder');
maxY = -Inf;
minY = Inf;
for estimator_idx = 1:length(estimators)
  means = squeeze(results(1, 1, :, 1, estimator_idx));
  maxY = max(maxY, max(means));
  minY = min(minY, min(means));
  CIs = 1.96 * squeeze(std_errs(1, 1, :, 1, estimator_idx)); % 95% asymptotic confidence interval radius
  lower = log10(means - CIs);
  lower(CIs > means) = 0; % can't display negative numbers on log scale
  upper = log10(means + CIs);
  color = colorOrder(mod(length(get(gca, 'Children')), size(colorOrder, 1))+1, :);
  legendPlots(estimator_idx) = plot(xs, log10(means), 'LineWidth', 1.5);
  legendPlots(estimator_idx).Marker = get_next_marker(estimator_idx);
%   plot(xs, lower, '--', 'LineWidth', 0.5, 'Color', color);
%   plot(xs, upper, '--', 'LineWidth', 0.5, 'Color', color);
end
set(gca,'XTick', xs(1:5:end)); set(gca,'XTickLabel', sigmas(1:5:end));
xlim([1.02*min(xs) 0.95*max(xs)]);
ylim([-3 -1]);
xlabel('Cov$$(X_1,X_2)$$', 'FontSize', 12, 'Interpreter', 'latex');
% ylabel('$$\log_{10}$$(MSE)', 'FontSize', 12, 'Interpreter', 'latex');
% legend(legendPlots, {'$$\hat I$$', ...
%                      '$$\hat I_G$$', ...
%                      '$$\hat I_\rho$$', ...
%                      '$$\hat I_\tau$$', ...
%                      '$$\hat I_{KNN}$$'}, ...
%               'Location', 'southeast', ...
%               'Interpreter', 'latex', ...
%               'FontSize', 10);
fig.PaperUnits = 'centimeters';
fig.PaperPosition = [5 5 columnwidth 6];
% saveas(fig, 'figs/fig4.fig');
% saveas(fig, 'figs/fig4.png');
% saveas(fig, 'figs/fig4.eps', 'epsc2');
