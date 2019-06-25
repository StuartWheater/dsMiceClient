#-------------------------------------- HEADER --------------------------------------------#
#' @title Model Fitted Values
#' @description Computes the fitted values from objects returned by modeling functions.
#' @details Considering \code{y} as a response variable and x as study variable, the fitted values are the y-values that
#' would expect for the given x-values according to the best-fitting straight line.
#' @param regression an object of regression model.
#' @param checks a boolean, if TRUE (default) checks that verify elements on the server side
#' such checks lengthen the run-time so the default is FALSE and one can switch these checks
#' on (set to TRUE) when faced with some error(s).
#' @param datasources a list of opal object(s) obtained after login in to opal servers;
#' these objects hold also the data assign to R, as \code{data frame}, from opal datasources.
#' @return a list of fitted values.
#' @author Paula Raissa Costa e Silva
#' @section Dependencies:
#' \code{\link{fittedDS}}
#' @export

ds.findNas <- function(execution, datasources=NULL) {
  if (is.null(datasources)) {
    datasources <- findLoginObjects()
  }
  
  result <- NULL
  
  num.sources <- length(datasources)
  for (i in 1:num.sources){
    cally <- call('identifyNas', execution)
    result <- opal::datashield.aggregate(datasources, cally)
  }
  
  naCols <- NULL
  completeCols <- NULL
  for (r in result) {
    naCols <- append(naCols, r$naCols)
    completeCols <- append(completeCols, r$completeCols)
  }
  naCols <- unique(naCols)
  completeCols <- unique(completeCols)
  cat("Variables with NA's: ")
  cat(naCols)
  cat("\nComplete Variables: ")
  cat(completeCols)
  cat("\n")
  
  invisible(list(naCols=naCols, completeCols=completeCols))
}