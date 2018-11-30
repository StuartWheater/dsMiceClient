<!-- README.md is generated from README.Rmd. Please edit that file -->
dsMiceClient
============

Multivariate Imputation by Chained Equations for DataSHIELD - Client
--------------------------------------------------------------------

The [`mice`](https://github.com/stefvanbuuren/mice) package creates multiple imputations (replacement values) for multivariate missing data.

The [`DataSHIELD`](https://github.com/datashield) framework is a platform for federated data analysis that brings the algorithm to the data.

The [`dsMiceClient`](https://github.com/stefvanbuuren/dsMiceClient) package is an add-on to `mice` that makes multiple imputation available for federated data systems. This is the package that the `DataSHIELD` end user installs locally.

The [`dsMice`](https://github.com/stefvanbuuren/dsMice) package is part of the `DataSHIELD` infrastructure. This is the package that the `DataSHIELD` node owner installs on the server.

Installation
------------

The following code installs the `dsMiceClient` package:

``` r
install.packages("devtools")
devtools::install_github("stefvanbuuren/dsMiceClient")
```

In order to work well, the `DataSHIELD` nodes should have installed the server site functions available from [`dsMice`](https://github.com/stefvanbuuren/dsMice)

Note
----

Warning: This is an experimental feature. These function do not yet actually work. If you have ideas about the integration of `mice` and `DataSHIELD` feel free to join in.

Related initiative
------------------

Related work appears in [`gflcampos/dsMice`](https://github.com/gflcampos/dsMice) and [`gflcampos/dsMiceClient`](https://github.com/gflcampos/dsMiceClient).

Minimal example
---------------

    Include minimal example here using public DataSHIELD nodes.
