<!-- README.md is generated from README.Rmd. Please edit that file -->
miceds
======

\[Multivariate Imputation by Chained Equations for DataSHIELD\]
---------------------------------------------------------------

The [`mice`](https://cran.r-project.org/package=mice) package implements a popular method to deal with missing data. The package creates multiple imputations (replacement values) for multivariate missing data.

The [`DataSHIELD`](https://github.com/datashield) framework is a platform for federated data analysis that brings the algorithm to the data.

The \[`miceds`\] package is an add-on to `mice` that makes multiple imputation available for federated data systems.

Installation
------------

If you have been marked as a collaborator on GitHub, you need to generate a personal access token (PAT) on <https://github.com/settings/tokens>. The following code installs the `miceds` package:

``` r
install.packages("devtools")
Sys.setenv(GITHUB_PAT = "copy_your_token_here")
devtools::install_github("stefvanbuuren/miceds")
```

Note: It is best to put your token in [`.Renviron`](http://happygitwithr.com/github-pat.html#how-do-you-authenticate-yourself).

Minimal example
---------------

    Include minimal example here using public DataSHIELD nodes.
