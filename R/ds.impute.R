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


ds.impute <- function(formula, family, type, m, datasources=NULL){
  
  # if no opal login details are provided look for 'opal' objects in the environment
  if(is.null(datasources)){
    datasources <- findLoginObjects()
  }
  
  #regression <- dsModellingClient::ds.glm(formula=formula, family = family)
  regression <- ds.linear(formula = formula, datasources = datasources)
  
  coef <- regression$coefficients[,1]
  frm <- regression$call
  
  # #Data transformations
  beta.vect.temp <- paste0(as.character(coef), collapse="x")
  model.formula <- as.formula(formula)
  
  cally <- call("getImpute", beta.vect.temp, model.formula, type, as.character(m))
  result <- opal::datashield.aggregate(datasources, cally)
  
  toReturn <- NULL
  switch(type, 
         split={
           toReturn <- result
         },
         combine={
           #Difference between estimates and real values
           cont <- 1
           imputedValues <- c()
           teste <- list()
           
           yHatMiss <- c()
           yHatObs <- c()
           for (r in result) {
             yHatMiss <- rbind(yHatMiss, r$yHatMis)
             yHatObs <- rbind(yHatObs, r$yHatObs)
           }
           yHatMiss <- cbind(yHatMiss, as.numeric(rownames(yHatMiss)))
           colnames(yHatMiss) <- c("yHat", "idx")
           yHatMiss <- as.data.frame(yHatMiss)
           
           idValor <- c()
           teste <- list()
           for (i in 1:nrow(yHatMiss)) {
             subtract <- data.frame(abs(mapply('-', yHatMiss[i,]$yHat, yHatObs))) #same x values rownames
             colnames(subtract) <- "dif"
             rownames(subtract) <- rownames(yHatObs)
             subtract$names <- rownames(subtract)
             orderedDiff <- subtract[with(subtract, order(dif)), ]
             topDiff <- orderedDiff[1:m,]
             candidateMap <- sample(topDiff[,"names"], 1)
             # #candidateMap <- orderedDiff[1,] #id que vou mapear na lista de valores completos
             teste[[cont]] <- c(candidateMap, yHatMiss[i,]$idx)
             idValor[cont] <- candidateMap
             cont <- cont + 1
           }
           resultdfr <- as.data.frame(do.call("rbind", teste))
           idValor.list <- unique(idValor)
           idValor.list.temp <- paste0(as.character(idValor.list), collapse="x")
           cally2 <- call("getXValuesComplete", model.formula, idValor.list.temp)
           result2 <- opal::datashield.aggregate(datasources, cally2)
           imputedValuesList <- NULL
           for(node in result2) {
             imputedValuesList <- rbind(imputedValuesList, node)
           }
           imputedValuesList <- cbind(imputedValuesList, rownames(imputedValuesList))
           colnames(imputedValuesList) <- c("imputedValues", "idx")
           mapValues <- merge(resultdfr, imputedValuesList, by.x = "V1", by.y = "idx")
           imputedFinal <- list()
           for (j in 1:length(result)) {
             mergeImputed <- merge(result[[j]]$yHatMis, mapValues, by.x=0, by.y="V2")
             imputedFinal.aux <- as.data.frame(mergeImputed[,"imputedValues"])
             rownames(imputedFinal.aux) <- mergeImputed[,"Row.names"]
             colnames(imputedFinal.aux) <- "imputedValues"
             imputedFinal[[j]] <- imputedFinal.aux
           }
           names(imputedFinal) <- names(result)
           toReturn <- imputedFinal
         }
  )
  
  return(toReturn)
  
  
  # # imputedValues <- as.data.frame(imputedValues)
  # # rownames(imputedValues) <- naLines
  
  
  # cat("\n1st regression formula: ")
  # cat(as.character(model.formula))
  # cat("\n1st regression coefficients: ")
  # cat(coef)
  # cat("\n")
  
  # invisible(model.formula)
  
}