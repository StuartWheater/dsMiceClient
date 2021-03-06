#'Imputation by the mean for DataSHIELD
#'
#'Imputes the arithmetic mean of the observed data
#'
#'@inheritParams mice.impute.ds.pmm
#'@param datasources A list with cluster information, usally the result
#'of a call to \code{opal::datashield.login()}.
#'@return Vector with imputed data, same type as \code{y}, and of length
#'\code{sum(wy)}
#'@section Warning: Imputing the mean of a variable is almost never
#'appropriate.  See Little and Rubin (2002, p. 61-62) or
#'Van Buuren (2012, p. 10-11)
#'@seealso \code{\link{mice}}, \code{\link{mean}}
#'@references Van Buuren, S., Groothuis-Oudshoorn, K. (2011). \code{mice}:
#'Multivariate Imputation by Chained Equations in \code{R}. \emph{Journal of
#'Statistical Software}, \bold{45}(3), 1-67.
#'\url{https://www.jstatsoft.org/v45/i03/}
#'
#'Little, R.J.A. and Rubin, D.B. (2002). Statistical Analysis with Missing
#'Data.  New York: John Wiley and Sons.
#'
#'Van Buuren, S. (2018).
#'\href{https://stefvanbuuren.name/fimd/sec-simplesolutions.html#sec:meanimp}{\emph{Flexible Imputation of Missing Data. Second Edition.}}
#'Chapman & Hall/CRC. Boca Raton, FL.
#'@family univariate imputation functions
#'@keywords datagen
#'@export
mice.impute.ds.mean <- function(y, ry, x = NULL, wy = NULL,
                                datasources = NULL, ...)
{
  if (is.null(datasources))
    return(mice.impute.mean(y, ry, x, wy, ...))
  if (is.null(wy))
    wy <- !ry
  x <- paste("D", get("j", envir = parent.frame()), sep = "$")
  my <- ds.mean(x = x, datasources = datasources)
  my <- as.numeric(my)
  return(rep.int(my, times = sum(wy)))
}
