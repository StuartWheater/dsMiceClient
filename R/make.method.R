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
#' 
make.method <- function(where, blocks, vars=NULL,
                        defaultMethod = c("pmm", "logreg", "polyreg", "polr")) {
  
  # assign.method <- function(y) {
  #   if (is.numeric(y)) return(1)
  #   if (nlevels(y) == 2) return(2)
  #   if (is.ordered(y) && nlevels(y) > 2) return(4)
  #   if (nlevels(y) > 2) return(3)
  #   if (is.logical(y)) return(2)
  #   return(1)
  # }
  
  assign.method <- 1
  
  # assign methods based on type, 
  # use method 1 if there is no single method within the block
  method <- rep("", length(blocks))
  names(method) <- names(blocks)
  for (j in names(blocks)) {
    yvar <- blocks[[j]]
    #y <- data[, yvar]
    def <- 1
    k <- ifelse(all(diff(def) == 0), k <- def[1], 1)
    method[j] <- defaultMethod[k]
  }
  datasources <- findLoginObjects()
  vars.temp <- paste0(as.character(vars), collapse="0506")
  cally <- call("nimp", vars.temp)
  result.nimp <- datashield.aggregate(datasources, cally)
  nimp <- Reduce("+", result.nimp)
  #nimp <- nimp(where, blocks)
  method[nimp == 0] <- ""
  
  return(method)
}