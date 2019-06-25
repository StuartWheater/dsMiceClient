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

ds.test1 <- function(formula, v1=NULL, v2=NULL, datasources=NULL){
  
  # if no opal login details are provided look for 'opal' objects in the environment
  if(is.null(datasources)){
    datasources <- findLoginObjects()
  }
  if(is.null(formula)){
    stop("Please provide the model formula!", call.=FALSE)
  } else {
    model.formula <- stats::as.formula(formula)
  }
  
  cally <- call("getNa", model.formula, v1, v2)
  result <- opal::datashield.aggregate(datasources, cally)
  
  return(result)
  
}