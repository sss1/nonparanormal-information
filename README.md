# nonparanormal-information
This repository contains estimators and experiments for our ICML 2017 paper [1] on estimating mutual information of nonparanormal (Gaussian copula) distributions.

<h2>Experiments/Figures from Paper</h2>
Each figure in the paper can be reproduced by running the corresponding gen_figure script. For example, running

  &gt;&gt; gen_figure1

will generate and save Figure 1 of the paper. Figures may differ slightly from those in the paper due to randomness of the simulated data.

<h2>Estimators</h2>
The following mutual information estimators used in the experiments are also included as separate functions:

  1) Normal information estimator, with bias correction (analyzed in [2]): normal_info.m
  2) Nonparanormal information estimator using Gaussianization (also studied by proposed by [3]): nonparanormal_info.m
  3) Nonparanormal information estimator using Spearman's rho: nonparanormal_Spearman_info.m
  4) Nonparanormal information estimator using Kendall's tau: nonparanormal_Kendall_info.m
  5) K-nearest neighbor information estimator (originally proposed by [4]) for fully nonparametric data (KNN_info.m&#42;)

&#42; Note that KNN_info.m relies on Zoltán Szabó's Information Theoretical Estimators (ITE) Toolbox (https://bitbucket.org/szzoli/ite/)

<h2>References</h2>

[1] Singh, Shashank, and Barnabás Pøczos. "Nonparanormal Information Estimation." arXiv preprint arXiv:1702.07803 (2017). Accepted to ICML 2017.

[2] Cai, T. Tony, Tengyuan Liang, and Harrison H. Zhou. "Law of log determinant of sample covariance matrix and optimal estimation of differential entropy for high-dimensional gaussian distributions." Journal of Multivariate Analysis 137 (2015): 161-172.

[3] Ince, Robin AA, et al. "A statistical framework for neuroimaging data analysis based on mutual information estimated via a Gaussian copula." Human brain mapping (2016).

[4] Kozachenko, L. F., and Nikolai N. Leonenko. "Sample estimate of the entropy of a random vector." Problemy Peredachi Informatsii 23.2 (1987): 9-16.
