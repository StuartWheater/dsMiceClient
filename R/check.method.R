#' Creates a \code{method} argument
#'
#' This helper function creates a valid \code{method} vector. The 
#' \code{method} vector is an argument to the \code{mice} function that 
#' specifies the method for each block.
#' @inheritParams mice
#' @return Vector of \code{length(blocks)} element with method names
#' @seealso \code{\link{mice}}
#' @examples
#' make.method(nhanes2)
#' @export

check.method <- function(method, vars, where, blocks, defaultMethod) {
  
  if (is.null(method)) return(make.method(vars = vars, 
                                          where = where,
                                          blocks = blocks,
                                          defaultMethod = defaultMethod))
  
  datasources <- findLoginObjects()
  vars.temp <- paste0(as.character(vars), collapse="0506")
  cally <- call("nimp", vars.temp)
  result.nimp <- datashield.aggregate(datasources, cally)
  nimp <- Reduce("+", result.nimp)
  
  # expand user's imputation method to all visited columns
  # single string supplied by user (implicit assumption of two columns)
  # if (length(method) == 1) {
  #   if (is.passive(method))
  #     stop("Cannot have a passive imputation method for every column.")
  #   method <- rep(method, length(blocks))
  #   method[nimp == 0] <- ""
  # }
  # 
  
  # # check the length of the argument
  #if (length(method) != length(blocks))
  #  stop("Length of method differs from number of blocks", call. = FALSE)
  
  return(list(method, blocks))

  # # add names to method
  # names(method) <- names(blocks)
  # 
  # # check whether the requested imputation methods are on the search path
  # active.check <- !is.passive(method) & nimp > 0 & method != ""
  # passive.check <- is.passive(method) & nimp > 0 & method != ""
  # check <- all(active.check) & any(passive.check)
  # if (check) {
  #   fullNames <- rep.int("mice.impute.passive", length(method[passive.check]))
  # } else {
  #   fullNames <- paste("mice.impute", method[active.check], sep = ".")
  #   if (length(method[active.check]) == 0) fullNames <- character(0)
  # }
  # 
  # type checks on built-in imputation methods
  # for (j in names(blocks)) {
  #   vname <- blocks[[j]]
  #   y <- data[, vname, drop = FALSE]
  #   mj <- method[j]
  #   mlist <- list(m1 = c("logreg", "logreg.boot", "polyreg", "lda", "polr"), 
  #                 m2 = c("norm", "norm.nob", "norm.predict", "norm.boot",
  #                        "mean", "2l.norm", "2l.pan",
  #                        "2lonly.pan", "quadratic", "ri"), 
  #                 m3 = c("norm", "norm.nob", "norm.predict", "norm.boot",
  #                        "mean", "2l.norm", "2l.pan", 
  #                        "2lonly.pan", "quadratic", "logreg", "logreg.boot"))
  #   cond1 <- sapply(y, is.numeric)
  #   cond2 <- sapply(y, is.factor) & sapply(y, nlevels) == 2 
  #   cond3 <- sapply(y, is.factor) & sapply(y, nlevels) > 2
  #   if (any(cond1) && mj %in% mlist$m1)
  #     warning("Type mismatch for variable(s): ", 
  #             paste(vname[cond1], collapse = ", "),
  #             "\nImputation method ", mj, " is for categorical data.",
  #             call. = FALSE)
  #   if (any(cond2) && mj %in% mlist$m2)
  #     warning("Type mismatch for variable(s): ", 
  #             paste(vname[cond2], collapse = ", "),
  #             "\nImputation method ", mj, " is not for factors.", 
  #             call. = FALSE)
  #   if (any(cond3) && mj %in% mlist$m3)
  #     warning("Type mismatch for variable(s): ", 
  #             paste(vname[cond3], collapse = ", "),
  #             "\nImputation method ", mj, " is not for factors with >2 levels.",
  #             call. = FALSE)
  # }
  
  
  #method[nimp == 0] <- ""
  #unlist(method)
}